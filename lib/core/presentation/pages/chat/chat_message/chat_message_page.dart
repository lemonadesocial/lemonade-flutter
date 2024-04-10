import 'dart:async';
import 'dart:io';

import 'package:app/core/presentation/pages/chat/chat_message/view/chat_message_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat/matrix_client_ios_badge_extension.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  final Widget? sideView;
  final String roomId;

  const ChatPage({
    super.key,
    this.sideView,
    @PathParam("id") required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final matrixClient = getIt<MatrixService>().client;

    return FutureBuilder(
      future: matrixClient.roomsLoading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: const LemonAppBar(),
            body: Loading.defaultLoading(context),
          );
        }
        final room = matrixClient.getRoomById(roomId);
        if (room == null) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            appBar: const LemonAppBar(),
            body: Loading.defaultLoading(context),
          );
        }
        return ChatPageWithRoom(sideView: sideView, room: room);
      },
    );
  }
}

class ChatPageWithRoom extends StatefulWidget {
  final Widget? sideView;
  final Room room;

  const ChatPageWithRoom({
    super.key,
    required this.sideView,
    required this.room,
  });

  @override
  ChatController createState() => ChatController();
}

class ChatController extends State<ChatPageWithRoom> {
  Client sendingClient = getIt<MatrixService>().client;

  Room get room => sendingClient.getRoomById(roomId) ?? widget.room;

  Timeline? timeline;

  String? readMarkerEventId;

  String get roomId => widget.room.id;

  final AutoScrollController scrollController = AutoScrollController();

  TextEditingController sendController = TextEditingController();

  Event? replyEvent;

  Event? editEvent;

  bool _scrolledUp = false;

  bool get showScrollDownButton =>
      _scrolledUp || timeline?.allowNewEvent == false;

  String inputText = '';

  String pendingText = '';

  Future<void>? loadTimelineFuture;

  Future<void>? _setReadMarkerFuture;

  @override
  void initState() {
    scrollController.addListener(_updateScrollController);
    super.initState();
    readMarkerEventId = room.fullyRead;
    loadTimelineFuture =
        _getTimeline(eventContextId: readMarkerEventId).onError((error, s) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  @override
  void dispose() {
    timeline?.cancelSubscriptions();
    timeline = null;
    super.dispose();
  }

  void updateView() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _getTimeline({
    String? eventContextId,
    Duration timeout = const Duration(seconds: 7),
  }) async {
    await sendingClient.roomsLoading;
    await sendingClient.accountDataLoading;
    if (eventContextId != null &&
        (!eventContextId.isValidMatrixId || eventContextId.sigil != '\$')) {
      eventContextId = null;
    }
    try {
      timeline = await room
          .getTimeline(
            onUpdate: updateView,
            eventContextId: eventContextId,
          )
          .timeout(timeout);
    } catch (e, s) {
      Logs().w('Unable to load timeline on event ID $eventContextId', e, s);
      if (!mounted) return;
      timeline = await room.getTimeline(onUpdate: updateView);
      if (!mounted) return;
      if (e is TimeoutException || e is IOException) {}
    }
    timeline!.requestKeys(onlineKeyBackupOnly: false);
    if (timeline!.events.isNotEmpty) {
      if (room.markedUnread) room.markUnread(false);
      setReadMarker();
    }
  }

  void requestHistory() async {
    if (!timeline!.canRequestHistory) return;
    Logs().v('Requesting history...');
    try {
      await timeline?.requestHistory();
    } catch (err) {
      rethrow;
    }
  }

  void requestFuture() async {
    final timeline = this.timeline;
    if (timeline == null) return;
    if (!timeline.canRequestFuture) return;
    Logs().v('Requesting future...');
    try {
      final mostRecentEventId = timeline.events.first.eventId;
      await timeline.requestFuture();
      setReadMarker(eventId: mostRecentEventId);
    } catch (err) {
      rethrow;
    }
  }

  void setReadMarker({String? eventId}) {
    if (_setReadMarkerFuture != null) return;
    if (eventId == null &&
        !room.hasNewMessages &&
        room.notificationCount == 0) {
      return;
    }

    final timeline = this.timeline;
    if (timeline == null || timeline.events.isEmpty) return;

    eventId ??= timeline.events.first.eventId;
    Logs().v('Set read marker...', eventId);
    // ignore: unawaited_futures
    _setReadMarkerFuture = timeline.setReadMarker(eventId: eventId).then((_) {
      _setReadMarkerFuture = null;
    });
    room.client.updateIosBadge();
  }

  void _updateScrollController() {
    if (!mounted) {
      return;
    }
    setReadMarker();
    if (!scrollController.hasClients) return;
    if (timeline?.allowNewEvent == false ||
        scrollController.position.pixels > 0 && _scrolledUp == false) {
      setState(() => _scrolledUp = true);
    } else if (scrollController.position.pixels == 0 && _scrolledUp == true) {
      setState(() => _scrolledUp = false);
    }
  }

  void scrollDown() async {
    if (!timeline!.allowNewEvent) {
      setState(() {
        timeline = null;
        _scrolledUp = false;
        loadTimelineFuture = _getTimeline().onError((_, __) {});
      });
      await loadTimelineFuture;
      setReadMarker(eventId: timeline!.events.first.eventId);
    }
    scrollController.jumpTo(0);
  }

  void onInputBarSubmitted(_) {
    send();
  }

  Timer? typingCoolDown;
  Timer? typingTimeout;
  bool currentlyTyping = false;

  void onInputBarChanged(String text) {
    setReadMarker();
    typingCoolDown?.cancel();
    typingCoolDown = Timer(const Duration(seconds: 2), () {
      typingCoolDown = null;
      currentlyTyping = false;
      room.setTyping(false);
    });
    typingTimeout ??= Timer(const Duration(seconds: 30), () {
      typingTimeout = null;
      currentlyTyping = false;
    });
    if (!currentlyTyping) {
      currentlyTyping = true;
      room.setTyping(true, timeout: const Duration(seconds: 30).inMilliseconds);
    }
    setState(() => inputText = text);
  }

  Future<void> send() async {
    if (sendController.text.trim().isEmpty) return;
    // ignore: unawaited_futures
    room.sendTextEvent(
      sendController.text,
      inReplyTo: replyEvent,
      editEventId: editEvent?.eventId,
    );
    sendController.value = TextEditingValue(
      text: pendingText,
      selection: const TextSelection.collapsed(offset: 0),
    );

    setState(() {
      inputText = pendingText;
      replyEvent = null;
      editEvent = null;
      pendingText = '';
    });
  }

  void reply({Event? replyTo}) {
    setState(() {
      replyEvent = replyTo;
    });
  }

  Future<void> sendEmojiAction({
    required Event event,
    required String emoji,
  }) async {
    Iterable<Event> allReactionEvents = event
        .aggregatedEvents(
          timeline!,
          RelationshipTypes.reaction,
        )
        .where(
          (event) =>
              event.senderId == event.room.client.userID &&
              event.type == 'm.reaction',
        );
    // prevent duplicated reactions
    bool reacted = allReactionEvents.any(
      (e) => e.content.tryGetMap('m.relates_to')?['key'] == emoji,
    );
    if (reacted) return;
    await room.sendReaction(
      event.eventId,
      emoji,
    );
  }

  void selectEditEventAction(Event? event) => setState(() {
        editEvent = event;
        inputText = sendController.text =
            editEvent!.getDisplayEvent(timeline!).calcLocalizedBodyFallback(
                  const MatrixDefaultLocalizations(),
                  withSenderNamePrefix: false,
                  hideReply: true,
                );
      });

  void cancelReplyOrEditEventAction() => setState(() {
        if (editEvent != null) {
          inputText = sendController.text = pendingText;
          pendingText = '';
        }
        replyEvent = null;
        editEvent = null;
      });

  bool get isArchived =>
      {Membership.leave, Membership.ban}.contains(room.membership);

  @override
  Widget build(BuildContext context) => ChatMessageView(this);
}

enum EmojiPickerType { reaction, keyboard }
