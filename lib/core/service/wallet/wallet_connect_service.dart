// ignore_for_file: unused_field

import 'package:app/core/config.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/utils/wc_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

enum SupportedWalletApp {
  metamask(
    scheme: 'metamask',
    url: 'https://metamask.io',
  );

  final String scheme;
  final String url;

  const SupportedWalletApp({
    required this.scheme,
    required this.url,
  });
}

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
  ];
  static const defaultEvents = SupportedSessionEvent.values;

  Web3App? _app;
  String? _url;
  String? _currentWalletChainId;
  String? _currentWalletAccount;

  bool get initialized => _app != null;

  String? get currentWalletAppAccount => _currentWalletAccount;

  String? get currentWalletAppChainId => _currentWalletChainId;

  Future<bool> init() async {
    try {
      if (initialized) return true;
      _app = await Web3App.createInstance(
        projectId: AppConfig.walletConnectProjectId,
        metadata: lemonadeDAppMetadata,
      );
      // Register event handler for all chain in active session if available;
      final activeSession = await getActiveSession();

      _registerEventHandler(
        WCUtils.getSessionsChains(activeSession?.namespaces),
      );

      // Register event handler of all supported chains
      _registerEventHandler(
        Chains.allChains.map((chain) => chain.chainId).toList(),
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

  Future<bool> connectWallet({
    required SupportedWalletApp walletApp,
    List<Chains>? chains,
  }) async {
    try {
      if (_app == null) {
        await init();
      }
      final supportedChainIds =
          (AppConfig.isProduction ? Chains.mainnet : Chains.testnet)
              .map((item) => item.chainId)
              .toList();
      final supportedEvents = defaultEvents.map((item) => item.name).toList();
      final requiredNamespace = RequiredNamespace(
        chains: [AppConfig.isProduction ? ETHEREUM.chainId : GOERLI.chainId],
        methods: defaultMethods,
        events: supportedEvents,
      );

      final optionalNamespaces = RequiredNamespace(
        chains: supportedChainIds,
        methods: defaultMethods,
        events: supportedEvents,
      );
      final ConnectResponse connectResponse = await _app!.connect(
        requiredNamespaces: {
          defaultNamespace: requiredNamespace,
        },
        optionalNamespaces: {
          defaultNamespace: optionalNamespaces,
        },
      );

      final Uri? uri = connectResponse.uri;

      if (uri != null) {
        final String encodedUrl = Uri.encodeComponent('$uri');

        _url = encodedUrl;

        await launchUrlString(
          _getDeepLinkUrl(walletApp),
          mode: LaunchMode.externalApplication,
        );

        var session = await connectResponse.session.future;

        _registerEventHandler(WCUtils.getSessionsChains(session.namespaces));

        return true;
      }
      return false;
    } on JsonRpcError catch (e) {
      SnackBarUtils.showSnackbar(e.message ?? '');
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> personalSign({
    required String message,
    required String wallet,
    required SupportedWalletApp walletApp,
  }) async {
    try {
      final activeSession = await getActiveSession();

      launchUrlString(
        _getDeepLinkUrl(walletApp),
        mode: LaunchMode.externalApplication,
      );

      final data = await _app!.request(
        topic: activeSession!.topic,
        chainId: _currentWalletChainId ??
            WCUtils.getSessionsChains(activeSession.namespaces).first,
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [message, wallet],
        ),
      );
      if (data is String) return data;
      return null;
    } catch (e) {
      SnackBarUtils.showSnackbar(e.toString());
      return null;
    }
  }

  Future<String> requestTransaction({
    required String chainId,
    required EthereumTransaction transaction,
    required SupportedWalletApp walletApp,
  }) async {
    final activeSession = await getActiveSession();

    launchUrlString(
      _getDeepLinkUrl(walletApp),
      mode: LaunchMode.externalApplication,
    );

    final transactionId = await _app!.request(
      topic: activeSession!.topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [transaction.toJson()],
      ),
    );
    return transactionId;
  }

  Future<void> disconnect() async {
    final activeSession = await getActiveSession();
    if (activeSession != null) {
      await _app?.disconnectSession(
        topic: activeSession.topic,
        reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
      );
    }
  }

  String _getDeepLinkUrl(SupportedWalletApp walletApp) =>
      '${walletApp.scheme}://wc?uri=$_url';

  _onSessionEvent(SessionEvent? sessionEvent) {
    var eventName = sessionEvent?.name;
    if (eventName == 'accountsChanged') {
      if (sessionEvent?.data is List) {
        _currentWalletAccount =
            NamespaceUtils.getAccount(sessionEvent?.data[0]);
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
