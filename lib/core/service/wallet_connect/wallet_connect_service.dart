import 'package:app/core/config.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/utils/wc_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

enum SupportedWalletApp {
  metamask(scheme: 'metamask'),
  trust(scheme: 'trust'),
  rainbow(scheme: 'rainbow');

  final String scheme;

  const SupportedWalletApp({
    required this.scheme,
  });
}

enum SupportedSessionEvent {
  accountsChanged,
  chainChanged,
}

@lazySingleton
class WalletConnectService {
  static const String defaultNamespace = 'eip155';
  static String defaultRequiredChainId = AppConfig.isProduction ? ETHEREUM.chainId : GOERLI.chainId;

  static const defaultMethods = [
    "personal_sign",
    "eth_sign",
    "eth_signTypedData",
    "eth_sendTransaction",
    "eth_signTransaction",
  ];
  static const defaultEvents = SupportedSessionEvent.values;

  Web3App? _app;
  String? _url;
  String? _currentWalletChainId;
  String? _currentWalletAccount;

  bool get initialized => _app != null;

  Future<bool> init() async {
    try {
      if (initialized) return true;
      _app = await Web3App.createInstance(
          projectId: AppConfig.walletConnectProjectId,
          metadata: PairingMetadata(
            name: 'Lemonade test',
            description: 'Lemonade test',
            url: AppConfig.webUrl,
            icons: [
              'https://walletconnect.com/walletconnect-logo.png',
            ],
          ));
      // Register event handler for all chain in active session if available;
      final activeSession = await getActiveSession();

      _registerEventHandler(WCUtils.getSessionsChains(activeSession?.namespaces));

      // Register event handler of all supported chains
      _registerEventHandler(Chains.allChains.map((chain) => chain.chainId).toList());

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
    var activeSessions = _app?.getActiveSessions().entries.map((entry) => entry.value).toList();

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
      final optionalChainIds =
          (AppConfig.isProduction ? Chains.mainnet : Chains.testnet).sublist(1).map((item) => item.chainId).toList();
      final supportedEvents = defaultEvents.map((item) => item.name).toList();
      final requiredNamespace = RequiredNamespace(
        chains: [defaultRequiredChainId],
        methods: defaultMethods,
        events: supportedEvents,
      );

      final optionalNamespaces = RequiredNamespace(
        chains: optionalChainIds,
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
          _getDeepLinkUrl(walletApp.scheme),
          mode: LaunchMode.externalApplication,
        );

        var session = await connectResponse.session.future;

        _registerEventHandler(WCUtils.getSessionsChains(session.namespaces));

        return true;
      }
      return false;
    } on JsonRpcError catch (e) {
      SnackBarUtils.showSnackbar(e.message);
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> personalSign({
    required String message,
    required String wallet,
  }) async {
    try {
      if (_shouldChangeAccount(wallet)) {
        SnackBarUtils.showSnackbar("Should change account to ${Web3Utils.formatIdentifier(wallet, length: 4)}");
        return null;
      }
      final chainId = _currentWalletChainId ?? defaultRequiredChainId;

      final activeSession = await getActiveSession();

      await launchUrlString(
        _getDeepLinkUrl(null),
        mode: LaunchMode.externalApplication,
      );

      final data = await _app!.request(
        topic: activeSession!.topic,
        chainId: chainId,
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

  String _getDeepLinkUrl(String? walletAppScheme) => '${walletAppScheme ?? 'metamask'}://wc?uri=$_url';

  _onSessionEvent(SessionEvent? sessionEvent) {
    var eventName = sessionEvent?.name;
    if (eventName == 'accountsChanged') {
      if (sessionEvent?.data is List) {
        _currentWalletAccount = NamespaceUtils.getAccount(sessionEvent?.data[0]);
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

  // bool _shouldChangeChainId(String chainId) {
  //   if(_currentWalletChainId == null) return false;
  //   return chainId != _currentWalletChainId;
  // }

  bool _shouldChangeAccount(String account) {
    if (_currentWalletAccount == null) return false;
    return account != _currentWalletAccount;
  }
}
