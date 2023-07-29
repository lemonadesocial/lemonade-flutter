import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:desktop_notifications/desktop_notifications.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:matrix/encryption.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vrouter/vrouter.dart';

import 'package:app/utils/client_manager.dart';
import 'package:app/utils/localized_exception_extension.dart';
import 'package:app/utils/platform_infos.dart';
import 'package:app/utils/uia_request_manager.dart';
import 'package:app/config/app_config.dart';
import 'package:app/config/setting_keys.dart';
import '../widgets/key_verification_dialog.dart';
import 'package:app/utils/account_bundles.dart';
import 'package:app/utils/background_push.dart';
import 'package:app/utils/famedlysdk_store.dart';
import 'local_notifications_extension.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Matrix extends StatefulWidget {
  final Widget? child;

  final GlobalKey<VRouterState>? router;

  final BuildContext context;

  final List<Client> clients;

  final Map<String, String>? queryParameters;

  const Matrix({
    this.child,
    required this.router,
    required this.context,
    required this.clients,
    this.queryParameters,
    Key? key,
  }) : super(key: key);

  @override
  MatrixState createState() => MatrixState();

  /// Returns the (nearest) Client instance of your application.
  static MatrixState of(BuildContext context) =>
      Provider.of<MatrixState>(context, listen: false);
}

class MatrixState extends State<Matrix> with WidgetsBindingObserver {
  int _activeClient = -1;
  String? activeBundle;
  Store store = Store();
  late BuildContext navigatorContext;

  HomeserverSummary? loginHomeserverSummary;
  XFile? loginAvatar;
  String? loginUsername;
  bool? loginRegistrationSupported;

  BackgroundPush? backgroundPush;

  Client get client {
    if (widget.clients.isEmpty) {
      widget.clients.add(getLoginClient());
    }
    if (_activeClient < 0 || _activeClient >= widget.clients.length) {
      return currentBundle!.first!;
    }
    return widget.clients[_activeClient];
  }

  bool get webrtcIsSupported =>
      kIsWeb ||
      PlatformInfos.isMobile ||
      PlatformInfos.isWindows ||
      PlatformInfos.isMacOS;

  bool get isMultiAccount => widget.clients.length > 1;

  int getClientIndexByMatrixId(String matrixId) =>
      widget.clients.indexWhere((client) => client.userID == matrixId);

  late String currentClientSecret;
  RequestTokenResponse? currentThreepidCreds;

  void setActiveClient(Client? cl) {
    final i = widget.clients.indexWhere((c) => c == cl);
    if (i != -1) {
      _activeClient = i;
    } else {
      Logs().w('Tried to set an unknown client ${cl!.userID} as active');
    }
  }

  List<Client?>? get currentBundle {
    if (!hasComplexBundles) {
      return List.from(widget.clients);
    }
    final bundles = accountBundles;
    if (bundles.containsKey(activeBundle)) {
      return bundles[activeBundle];
    }
    return bundles.values.first;
  }

  Map<String?, List<Client?>> get accountBundles {
    final resBundles = <String?, List<_AccountBundleWithClient>>{};
    for (var i = 0; i < widget.clients.length; i++) {
      final bundles = widget.clients[i].accountBundles;
      for (final bundle in bundles) {
        if (bundle.name == null) {
          continue;
        }
        resBundles[bundle.name] ??= [];
        resBundles[bundle.name]!.add(
          _AccountBundleWithClient(
            client: widget.clients[i],
            bundle: bundle,
          ),
        );
      }
    }
    for (final b in resBundles.values) {
      b.sort(
        (a, b) => a.bundle!.priority == null
            ? 1
            : b.bundle!.priority == null
                ? -1
                : a.bundle!.priority!.compareTo(b.bundle!.priority!),
      );
    }
    return resBundles
        .map((k, v) => MapEntry(k, v.map((vv) => vv.client).toList()));
  }

  bool get hasComplexBundles => accountBundles.values.any((v) => v.length > 1);

  Client? _loginClientCandidate;

  Client getLoginClient() {
    if (widget.clients.isNotEmpty && !client.isLogged()) {
      return client;
    }
    final candidate = _loginClientCandidate ??= ClientManager.createClient(
      '${AppConfig.applicationName}-${DateTime.now().millisecondsSinceEpoch}',
    )..onLoginStateChanged
          .stream
          .where((l) => l == LoginState.loggedIn)
          .first
          .then((_) {
        if (!widget.clients.contains(_loginClientCandidate)) {
          widget.clients.add(_loginClientCandidate!);
        }
        ClientManager.addClientNameToStore(_loginClientCandidate!.clientName);
        _registerSubs(_loginClientCandidate!.clientName);
        _loginClientCandidate = null;
        widget.router!.currentState!.to('/rooms');
      });
    return candidate;
  }

  Client? getClientByName(String name) =>
      widget.clients.firstWhereOrNull((c) => c.clientName == name);

  Map<String, dynamic>? get shareContent => _shareContent;

  set shareContent(Map<String, dynamic>? content) {
    _shareContent = content;
    onShareContentChanged.add(_shareContent);
  }

  Map<String, dynamic>? _shareContent;

  final StreamController<Map<String, dynamic>?> onShareContentChanged =
      StreamController.broadcast();

  File? wallpaper;

  void _initWithStore() async {
    try {
      if (client.isLogged()) {
        // TODO: Figure out how this works in multi account
        final statusMsg = await store.getItem(SettingKeys.ownStatusMessage);
        if (statusMsg?.isNotEmpty ?? false) {
          Logs().v('Send cached status message: "$statusMsg"');
          await client.setPresence(
            client.userID!,
            PresenceType.online,
            statusMsg: statusMsg,
          );
        }
      }
    } catch (e, s) {
      client.onLoginStateChanged.addError(e, s);
      rethrow;
    }
  }

  final onRoomKeyRequestSub = <String, StreamSubscription>{};
  final onKeyVerificationRequestSub = <String, StreamSubscription>{};
  final onNotification = <String, StreamSubscription>{};
  final onLoginStateChanged = <String, StreamSubscription<LoginState>>{};
  final onUiaRequest = <String, StreamSubscription<UiaRequest>>{};
  StreamSubscription<html.Event>? onFocusSub;
  StreamSubscription<html.Event>? onBlurSub;

  String? _cachedPassword;
  Timer? _cachedPasswordClearTimer;

  String? get cachedPassword => _cachedPassword;

  set cachedPassword(String? p) {
    Logs().d('Password cached');
    _cachedPasswordClearTimer?.cancel();
    _cachedPassword = p;
    _cachedPasswordClearTimer = Timer(const Duration(minutes: 10), () {
      _cachedPassword = null;
      Logs().d('Cached Password cleared');
    });
  }

  bool webHasFocus = true;

  String? get activeRoomId => navigatorContext.vRouter.pathParameters['roomid'];

  final linuxNotifications =
      PlatformInfos.isLinux ? NotificationsClient() : null;
  final Map<String, int> linuxNotificationIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initMatrix();
    if (PlatformInfos.isWeb) {
      initConfig().then((_) => initSettings());
    } else {
      initSettings();
    }
    initLoadingDialog();
  }

  void initLoadingDialog() {
    final t = Translations.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoadingDialog.defaultTitle = t.matrix.loadingPleaseWait;
      LoadingDialog.defaultBackLabel = t.matrix.close;
      LoadingDialog.defaultOnError =
          (e) => (e as Object?)!.toLocalizedString(context);
    });
  }

  Future<void> initConfig() async {
    try {
      final configJsonString =
          utf8.decode((await http.get(Uri.parse('config.json'))).bodyBytes);
      final configJson = json.decode(configJsonString);
      AppConfig.loadFromJson(configJson);
    } on FormatException catch (_) {
      Logs().v('[ConfigLoader] config.json not found');
    } catch (e) {
      Logs().v('[ConfigLoader] config.json not found', e);
    }
  }

  void _registerSubs(String name) {
    final t = Translations.of(context);
    final c = getClientByName(name);
    if (c == null) {
      Logs().w(
        'Attempted to register subscriptions for non-existing client $name',
      );
      return;
    }
    onRoomKeyRequestSub[name] ??=
        c.onRoomKeyRequest.stream.listen((RoomKeyRequest request) async {
      if (widget.clients.any(
        ((cl) =>
            cl.userID == request.requestingDevice.userId &&
            cl.identityKey == request.requestingDevice.curve25519Key),
      )) {
        Logs().i(
          '[Key Request] Request is from one of our own clients, forwarding the key...',
        );
        await request.forwardKey();
      }
    });
    onKeyVerificationRequestSub[name] ??= c.onKeyVerificationRequest.stream
        .listen((KeyVerification request) async {
      var hidPopup = false;
      request.onUpdate = () {
        if (!hidPopup &&
            {KeyVerificationState.done, KeyVerificationState.error}
                .contains(request.state)) {
          Navigator.of(navigatorContext).pop('dialog');
        }
        hidPopup = true;
      };
      request.onUpdate = null;
      hidPopup = true;
      await KeyVerificationDialog(request: request).show(navigatorContext);
    });
    onLoginStateChanged[name] ??= c.onLoginStateChanged.stream.listen((state) {
      final loggedInWithMultipleClients = widget.clients.length > 1;
      if (loggedInWithMultipleClients && state != LoginState.loggedIn) {
        _cancelSubs(c.clientName);
        widget.clients.remove(c);
        ClientManager.removeClientNameFromStore(c.clientName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.matrix.oneClientLoggedOut),
          ),
        );

        if (state != LoginState.loggedIn) {
          widget.router?.currentState?.to(
            '/rooms',
            queryParameters: widget.router?.currentState?.queryParameters ?? {},
          );
        }
      } else {
        widget.router?.currentState?.to(
          state == LoginState.loggedIn ? '/rooms' : '/home',
          queryParameters: widget.router?.currentState?.queryParameters ?? {},
        );
      }
    });
    onUiaRequest[name] ??= c.onUiaRequest.stream.listen(uiaRequestHandler);
    if (PlatformInfos.isWeb || PlatformInfos.isLinux) {
      c.onSync.stream.first.then((s) {
        html.Notification.requestPermission();
        onNotification[name] ??= c.onEvent.stream
            .where(
              (e) =>
                  e.type == EventUpdateType.timeline &&
                  [EventTypes.Message, EventTypes.Sticker, EventTypes.Encrypted]
                      .contains(e.content['type']) &&
                  e.content['sender'] != c.userID,
            )
            .listen(showLocalNotification);
      });
    }
  }

  void _cancelSubs(String name) {
    onRoomKeyRequestSub[name]?.cancel();
    onRoomKeyRequestSub.remove(name);
    onKeyVerificationRequestSub[name]?.cancel();
    onKeyVerificationRequestSub.remove(name);
    onLoginStateChanged[name]?.cancel();
    onLoginStateChanged.remove(name);
    onNotification[name]?.cancel();
    onNotification.remove(name);
  }

  void initMatrix() {
    final t = Translations.of(context);
    // Display the app lock
    if (PlatformInfos.isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ([TargetPlatform.linux].contains(Theme.of(context).platform)
                ? SharedPreferences.getInstance()
                    .then((prefs) => prefs.getString(SettingKeys.appLockKey))
                : const FlutterSecureStorage()
                    .read(key: SettingKeys.appLockKey))
            .then((lock) {
          if (lock?.isNotEmpty ?? false) {
            AppLock.of(widget.context)!.enable();
            AppLock.of(widget.context)!.showLockScreen();
          }
        });
      });
    }

    _initWithStore();

    for (final c in widget.clients) {
      _registerSubs(c.clientName);
    }

    if (kIsWeb) {
      onFocusSub = html.window.onFocus.listen((_) => webHasFocus = true);
      onBlurSub = html.window.onBlur.listen((_) => webHasFocus = false);
    }

    if (PlatformInfos.isMobile) {
      backgroundPush = BackgroundPush(
        client,
        context,
        widget.router,
        onFcmError: (errorMsg, {Uri? link}) async {
          final result = await showOkCancelAlertDialog(
            barrierDismissible: true,
            context: context,
            title: t.matrix.oopsSomethingWentWrong,
            message: errorMsg,
            okLabel:
                link == null ? t.matrix.ok : t.matrix.help,
            cancelLabel: t.matrix.doNotShowAgain,
          );
          if (result == OkCancelResult.ok && link != null) {
            launchUrlString(link.toString());
          }
          if (result == OkCancelResult.cancel) {
            await store.setItemBool(SettingKeys.showNoGoogle, true);
          }
        },
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Logs().v('AppLifecycleState = $state');
    final foreground = state != AppLifecycleState.detached &&
        state != AppLifecycleState.paused;
    client.backgroundSync = foreground;
    client.syncPresence = foreground ? null : PresenceType.unavailable;
    client.requestHistoryOnLimitedTimeline = !foreground;
  }

  void initSettings() {
    store.getItem(SettingKeys.wallpaper).then((final path) async {
      if (path == null) return;
      final file = File(path);
      if (await file.exists()) {
        wallpaper = file;
      }
    });
    store.getItem(SettingKeys.fontSizeFactor).then(
          (value) => AppConfig.fontSizeFactor =
              double.tryParse(value ?? '') ?? AppConfig.fontSizeFactor,
        );
    store.getItem(SettingKeys.bubbleSizeFactor).then(
          (value) => AppConfig.bubbleSizeFactor =
              double.tryParse(value ?? '') ?? AppConfig.bubbleSizeFactor,
        );
    store
        .getItemBool(SettingKeys.renderHtml, AppConfig.renderHtml)
        .then((value) => AppConfig.renderHtml = value);
    store
        .getItemBool(
          SettingKeys.hideRedactedEvents,
          AppConfig.hideRedactedEvents,
        )
        .then((value) => AppConfig.hideRedactedEvents = value);
    store
        .getItemBool(SettingKeys.hideUnknownEvents, AppConfig.hideUnknownEvents)
        .then((value) => AppConfig.hideUnknownEvents = value);
    store
        .getItemBool(
          SettingKeys.showDirectChatsInSpaces,
          AppConfig.showDirectChatsInSpaces,
        )
        .then((value) => AppConfig.showDirectChatsInSpaces = value);
    store
        .getItemBool(SettingKeys.separateChatTypes, AppConfig.separateChatTypes)
        .then((value) => AppConfig.separateChatTypes = value);
    store
        .getItemBool(SettingKeys.autoplayImages, AppConfig.autoplayImages)
        .then((value) => AppConfig.autoplayImages = value);
    store
        .getItemBool(
          SettingKeys.sendTypingNotifications,
          AppConfig.sendTypingNotifications,
        )
        .then((value) => AppConfig.sendTypingNotifications = value);
    store
        .getItemBool(SettingKeys.sendOnEnter, AppConfig.sendOnEnter)
        .then((value) => AppConfig.sendOnEnter = value);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    onRoomKeyRequestSub.values.map((s) => s.cancel());
    onKeyVerificationRequestSub.values.map((s) => s.cancel());
    onLoginStateChanged.values.map((s) => s.cancel());
    onNotification.values.map((s) => s.cancel());
    client.httpClient.close();
    onFocusSub?.cancel();
    onBlurSub?.cancel();
    backgroundPush?.onRoomSync?.cancel();

    linuxNotifications?.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => this,
      child: widget.child,
    );
  }
}

class FixedThreepidCreds extends ThreepidCreds {
  FixedThreepidCreds({
    required String sid,
    required String clientSecret,
    String? idServer,
    String? idAccessToken,
  }) : super(
          sid: sid,
          clientSecret: clientSecret,
          idServer: idServer,
          idAccessToken: idAccessToken,
        );

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sid'] = sid;
    data['client_secret'] = clientSecret;
    if (idServer != null) data['id_server'] = idServer;
    if (idAccessToken != null) data['id_access_token'] = idAccessToken;
    return data;
  }
}

class _AccountBundleWithClient {
  final Client? client;
  final AccountBundle? bundle;

  _AccountBundleWithClient({this.client, this.bundle});
}
