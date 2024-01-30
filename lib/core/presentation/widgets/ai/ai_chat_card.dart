import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/domain/ai/ai_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/ai/ai_chat_default_grid.dart';
import 'package:app/core/presentation/widgets/ai/ai_metadata_button_card.dart';
import 'package:app/core/presentation/widgets/common/list_tile/custom_list_tile.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AIChatCard extends StatelessWidget {
  const AIChatCard({
    super.key,
    required this.message,
    required this.onFinishedTypingAnimation,
  });

  final AIChatMessage message;
  final Function()? onFinishedTypingAnimation;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    bool? isUser = message.isUser ?? false;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthStateAuthenticated) {
          if (!isUser) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: colorScheme.secondaryContainer,
              child: Column(
                children: [
                  CustomListTile(
                    leading: _buildAvatar(
                      isUser,
                      authState.authSession,
                    ),
                    additionalInfoSection: additionalInfoSection(context),
                    title: _buildTextDisplay(),
                  ),
                ],
              ),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.h,
                  horizontal: 15.w,
                ),
                leading: _buildAvatar(
                  isUser,
                  authState.authSession,
                ),
                title: Text(message.text ?? ''),
              ),
            ],
          );
        } else {
          return Loading.defaultLoading(context);
        }
      },
    );
  }

  Widget _buildAvatar(bool isUser, User authSession) {
    if (isUser) {
      return LemonCircleAvatar(
        size: 42.w,
        url: AvatarUtils.getProfileAvatar(
          userAvatar: authSession.imageAvatar,
          userId: authSession.userId,
        ),
      );
    }
    return SizedBox(
      width: 42.w,
      height: 42.w,
      child: const LemonCircleAvatar(
        isLemonIcon: true,
        lemonIconScale: 1.4,
      ),
    );
  }

  Widget _buildTextDisplay() {
    if (message.finishedAnimation == false) {
      return AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            message.text ?? '',
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        repeatForever: false,
        totalRepeatCount: 1,
        onFinished: onFinishedTypingAnimation,
      );
    }
    return Text(
      message.text ?? '',
      style: Typo.medium.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (message.metadata == null || message.metadata!.isEmpty) {
      return const SizedBox.shrink();
    }
    final firstButton = message.metadata?['buttons']?[0];
    final firstButtonAction = firstButton['action'];

    final targetObject = aiChatDefaultGridData.firstWhere(
      (element) {
        return element?.action.value == firstButtonAction;
      },
      orElse: () => null,
    );

    if (targetObject == null) {
      return const SizedBox.shrink();
    }

    return AIMetaDataCard(
      item: targetObject,
      onTap: () {
        if (targetObject.action == AIMetadataAction.createPost) {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const CreatePostRoute());
        } else if (targetObject.action == AIMetadataAction.createEvent) {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const CreateEventRoute());
        }
      },
    );
  }

  Widget additionalInfoSection(BuildContext context) {
    bool? showDefaultGrid = message.showDefaultGrid;
    if (message.finishedAnimation == true) {
      return showDefaultGrid == true
          ? const AIChatDefaultGrid()
          : _buildButtons(context);
    }
    return const SizedBox();
  }
}
