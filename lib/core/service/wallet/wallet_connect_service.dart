import 'package:app/core/config.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/utils/list/unique_list_extension.dart';
import 'package:app/core/utils/wc_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:injectable/injectable.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

enum SupportedSessionEvent {
  accountsChanged,
  chainChanged,
}

@lazySingleton
class WalletConnectService {
  static const String defaultNamespace = 'eip155';
  static String defaultRequiredChainId =
      AppConfig.isProduction ? ETHEREUM.chainId : GOERLI.chainId;

  static final lemonadeDAppMetadata = PairingMetadata(
    name: 'Lemonade',
    description: 'Lemonade',
    url: AppConfig.webUrl,
    icons: [
      'https://explorer-api.walletconnect.com/v3/logo/lg/1ab2c2a3-4353-472e-41a1-1ae295473600?projectId=2f05ae7f1116030fde2d36508f472bfb',
    ],
    redirect: Redirect(
      native: '${AppConfig.appScheme}://wallet-callback',
    ),
  );

  static const defaultMethods = [
    'eth_sign',
    'personal_sign',
    'eth_signTypedData',
    'eth_sendTransaction',
    'eth_sendRawTransaction',
  ];

  static const optionalMethods = [
    'eth_chainId',
  ];
  static const defaultEvents = SupportedSessionEvent.values;

  late W3MService _w3mService;
  IWeb3App? _app;
  String? _currentWalletChainId;
  String? _currentWalletAccount;

  W3MService get w3mService => _w3mService;

  bool get initialized => _app != null;

  String? get currentWalletAppAccount => _currentWalletAccount;

  String? get currentWalletAppChainId => _currentWalletChainId;

  Future<bool> init() async {
    try {
      if (initialized) return true;
      final chains =
          (await getIt<Web3Repository>().getChainsList()).getOrElse(() => []);
      final supportedChainIds =
          chains.map((chain) => chain.fullChainId ?? '').toList();

      final optionalNamespaces = W3MNamespace(
        chains: [
          ...supportedChainIds,
          ...W3MChainPresets.chains.values.map((e) => e.namespace),
        ].unique(),
        methods: MethodsConstants.allMethods,
        events: EventsConstants.allEvents,
      );

      _w3mService = W3MService(
        projectId: AppConfig.walletConnectProjectId,
        metadata: lemonadeDAppMetadata,
        logLevel: AppConfig.isProduction ? LogLevel.nothing : LogLevel.debug,
        optionalNamespaces: {
          defaultNamespace: optionalNamespaces,
        },
      );
      await _w3mService.init();
      _app = _w3mService.web3App;
      // Register event handler for all chain in active session if available;
      final activeSession = await getActiveSession();

      _registerEventHandler(
        WCUtils.getSessionsChains(activeSession?.namespaces),
      );

      // Register event handler of all supported chains
      _registerEventHandler(
        chains.map((chain) => chain.fullChainId ?? '').toList(),
      );

      _app!.onSessionEvent.subscribe(_onSessionEvent);
      _app!.onSessionUpdate.subscribe(_onSessionUpdate);

      return true;
    } catch (e) {
      return false;
    }
  }

  close() {
    if (_app == null) return;
    _app!.onSessionEvent.unsubscribeAll();
    _app!.onSessionUpdate.unsubscribeAll();
  }

  Future<SessionData?> getActiveSession() async {
    if (!initialized) {
      await init();
    }
    var activeSessions =
        _app?.getActiveSessions().entries.map((entry) => entry.value).toList();

    if (activeSessions?.isEmpty == true) return null;

    return activeSessions?.first;
  }

  Future<String?> personalSign({
    required String message,
    required String wallet,
    String? chainId,
  }) async {
    await _w3mService.launchConnectedWallet();

    final data = await _app!.request(
      topic: w3mService.session?.topic ?? '',
      chainId: chainId ?? _currentWalletChainId ?? ETHEREUM.chainId,
      request: SessionRequestParams(
        method: 'personal_sign',
        params: [message, wallet],
      ),
    );
    if (data is String) return data;

    return null;
  }

  Future<String> requestTransaction({
    required String chainId,
    required EthereumTransaction transaction,
  }) async {
    await _w3mService.launchConnectedWallet();

    final transactionId = await _app!.request(
      topic: w3mService.session?.topic ?? '',
      chainId: chainId,
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [
          transaction.copyWith(data: transaction.data ?? '').toJson(),
        ],
      ),
    );
    return transactionId;
  }

  Future<void> disconnect() async {
    await _w3mService.disconnect(disconnectAllSessions: true);
  }

  Future<void> switchChain({
    required Chain chain,
  }) async {
    if (_w3mService.session == null) {
      return;
    }

    await _w3mService.selectChain(
      W3MChainInfo(
        chainName: chain.name ?? '',
        chainId: chain.chainId ?? '',
        namespace: chain.fullChainId ?? '',
        tokenName: chain.nativeToken?.name ?? '',
        rpcUrl: chain.rpcUrl ?? '',
      ),
      switchChain: true,
    );
  }

  _onSessionEvent(SessionEvent? sessionEvent) {
    var eventName = sessionEvent?.name;
    if (eventName == 'accountsChanged') {
      if (sessionEvent?.data is List) {
        _currentWalletAccount =
            NamespaceUtils.getAccount(sessionEvent?.data[0]);
        _currentWalletChainId =
            NamespaceUtils.getChainFromAccount(sessionEvent?.data[0]);
      }
    }
    if (eventName == 'chainChanged') {
      _currentWalletChainId = sessionEvent?.chainId;
    }
  }

  _onSessionUpdate(SessionUpdate? sessionUpdate) {
    final chains = WCUtils.getSessionsChains(sessionUpdate?.namespaces);
    _registerEventHandler(chains);
  }

  _registerEventHandler(List<String> chainIds) {
    for (final chainId in chainIds) {
      for (final event in defaultEvents) {
        _app!.registerEventHandler(chainId: chainId, event: event.name);
      }
    }
  }
}

enum WCRpcErrorCode {
  userRejected(code: 5000),
  userRejectedChains(code: 5001),
  userRejectedMethods(code: 5002),
  userRejectedEvents(code: 5003),
  unsupportedChains(code: 5100),
  unsupportedMethods(code: 5101),
  unsupportedEvents(code: 5102),
  unsupportedAccounts(code: 5103),
  unsupportedNamespaceKey(code: 5104);

  final int code;
  const WCRpcErrorCode({required this.code});
}
