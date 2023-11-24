import 'dart:async';

import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/utils/gql/ai_gql_client.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/ai/ai_chat_card.dart';
import 'package:app/core/presentation/widgets/ai/ai_chat_composer.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/graphql/ai/__generated__/run.req.gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/schemas/ai/__generated__/schema.schema.gql.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

const uuid = Uuid();

@RoutePage()
class AIPage extends StatefulWidget {
  const AIPage({Key? key}) : super(key: key);

  @override
  AIPageState createState() => AIPageState();
}

class AIPageState extends State<AIPage> {
  final client = getIt<AIClient>().client;
  final ScrollController _scrollController = ScrollController();
  final String session = uuid.v4();
  bool _loading = false;

  List<AIChatMessage> messages = [
    AIChatMessage(
      "I’m Lulu, your creative and helpful collaborator. I have limitations and won’t always get it right, but your feedback will help me improve. What would you like to create today?",
      null,
      false,
      false,
    ),
  ];

  final TextEditingController _textController = TextEditingController();

  late StreamSubscription<bool> keyboardSubscription;
  final keyboardVisibilityController = KeyboardVisibilityController();
  Timer? _timer;
  bool _needScrollToEnd = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible == true) {
        Future.delayed(const Duration(milliseconds: 300), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToEnd();
          });
        });
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_needScrollToEnd) {
        _scrollToEnd();
      }
    });
  }

  void stopAutoScrollToEnd() {
    _needScrollToEnd = false;
    _timer?.cancel();
  }

  void triggerAutoScrollToEnd() {
    _needScrollToEnd = true;
    startTimer();
  }

  void send(String text) {
    try {
      Vibrate.feedback(FeedbackType.light);
      FocusScope.of(context).unfocus();
      if (_textController.text.trim().isEmpty) return;
      _textController.clear();
      setState(() {
        _loading = true;
        messages.insert(
          messages.length,
          AIChatMessage(text, null, true, true),
        );
      });

      final config = GObjectIdBuilder();
      config.value = AppConfig.aiConfig;
      final createPostReq = GRunReq(
        (b) => b
          ..vars.config = config
          ..vars.message = text
          ..vars.session = session,
      );

      client.request(createPostReq).listen((event) {
        setState(() {
          _loading = false;
          messages.insert(
            messages.length,
            AIChatMessage(
              event.data!.run.message,
              event.data!.run.metadata,
              false,
              false,
            ),
          );
        });

        // Wait insert latest messages then scroll
        SchedulerBinding.instance.addPostFrameCallback((_) {
          triggerAutoScrollToEnd();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
    }
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          MediaQuery.of(context).viewInsets.bottom,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: <Widget>[
              _buildChatList(),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: AIChatComposer(
                  textController: _textController,
                  onSend: send,
                  loading: _loading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onFinishedTypingAnimation() {
    stopAutoScrollToEnd();
    setState(() {
      messages.last.finishedAnimation = true;
    });
  }

  Widget _buildChatList() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return AIChatCard(
            message: messages[index],
            onFinishedTypingAnimation: onFinishedTypingAnimation,
          );
        },
      ),
    );
  }
}
