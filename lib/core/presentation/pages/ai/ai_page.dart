import 'dart:async';

import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/presentation/pages/ai/widgets/ai_chat_command_view.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/ai_gql_client.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/widgets/ai/ai_chat_card.dart';
import 'package:app/core/presentation/widgets/ai/ai_chat_composer.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/graphql/__generated__/config.req.gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/schemas/ai/__generated__/schema.schema.gql.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:app/graphql/__generated__/run.req.gql.dart';
import 'package:app/core/presentation/pages/ai/widgets/fullscreen_overlay.dart';

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
  late String inputString = '';
  bool _loading = false;
  bool _initialLoading = true;

  List<AIChatMessage> messages = [];

  final TextEditingController _textController = TextEditingController();

  late StreamSubscription<bool> keyboardSubscription;
  final keyboardVisibilityController = KeyboardVisibilityController();
  Timer? _timer;
  bool _needScrollToEnd = false;
  bool _commandSelected = false;

  @override
  void initState() {
    super.initState();
    final config = GObjectIdBuilder();
    config.value = AppConfig.chatLemonAIConfig;
    final getConfigReq = GconfigReq((b) => b..vars.id = config);
    client.request(getConfigReq).listen((event) {
      setState(() {
        _initialLoading = false;
        messages.insert(
          messages.length,
          AIChatMessage(
            event.data?.config.welcomeMessage,
            null,
            false,
            false,
            true,
          ),
        );
      });
    });
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

  void onSend(String? text) {
    try {
      Vibrate.feedback(FeedbackType.light);
      FocusScope.of(context).unfocus();
      if (inputString.trim().isEmpty || text!.trim().isEmpty) return;
      _textController.clear();
      setState(() {
        inputString = '';
        messages.insert(
          messages.length,
          AIChatMessage(text, null, true, true, false),
        );
      });
      final config = GObjectIdBuilder();
      config.value = AppConfig.chatLemonAIConfig;
      final createPostReq = GRunReq(
        (b) => b
          ..vars.config = config
          ..vars.message = text
          ..vars.session = session,
      );
      setState(() {
        _loading = true;
      });
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
      appBar: LemonAppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(left: Spacing.medium, right: Spacing.xSmall),
            child: InkWell(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                AutoRouter.of(context).pop();
              },
              child: Icon(
                Icons.close_rounded,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_commandSelected) {
                    setState(() {
                      _commandSelected = false;
                    });
                  } else {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                },
                child: Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: aiChatComposerHeight),
                      child: _buildChatList(),
                    ),
                    _commandSelected
                        ? const FullScreenOverlay()
                        : const SizedBox()
                  ],
                ),
              ),
              _commandSelected ? const AIChatCommandView() : const SizedBox(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: AIChatComposer(
                    textController: _textController,
                    inputString: inputString,
                    onSend: onSend,
                    loading: _loading,
                    selectedCommand: _commandSelected,
                    onChanged: (String text) {
                      setState(() {
                        inputString = text;
                      });
                    },
                    onToggleCommand: () => setState(() {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _commandSelected = !_commandSelected;
                    }),
                    onFocusChange: (focus) {
                      setState(() {
                        _commandSelected = false;
                      });
                    },
                  ),
                ),
              )
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
    if (_initialLoading) {
      return Loading.defaultLoading(context);
    }
    return ListView.builder(
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
    );
  }
}
