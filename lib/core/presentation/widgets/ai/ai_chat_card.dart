import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/ai/ai_entities.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/ai/ai_metadata_button_card.dart';
import 'package:app/core/presentation/widgets/home/create_pop_up_tile.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
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
    bool? isUser = message.isUser;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthStateAuthenticated) {
          if (!isUser!) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: LemonColor.darkCharcoalGray,
              child: Column(
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
                    title: message.finishedAnimation == true
                        ? Text(message.text ?? '')
                        : AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(message.text ?? ''),
                            ],
                            repeatForever: false,
                            totalRepeatCount: 1,
                            onFinished: onFinishedTypingAnimation,
                          ),
                  ),
                  _buildButtons(context),
                ],
              ),
            );
          }
          return Column(
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
              SizedBox(
                height: 10.h,
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
    return Container(
      width: 42.w,
      height: 42.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.icChatAiBot.provider(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (message.metadata == null || message.metadata!.isEmpty) {
      return const SizedBox();
    }
    // TODO: Extract display first item, facing problem about not able display Grid view here
    final firstButton = message.metadata?['buttons']?[0];
    final action = firstButton['action'];
    List<Color> colors = [];
    Widget? icon;
    bool featureAvailable = false;
    switch (action) {
      case 'create_post':
        icon = Assets.icons.icCreatePost.svg();
        colors = CreatePopupGradient.post.colors;
        featureAvailable = true;
        break;
      case 'create_room':
        icon = Assets.icons.icCreateRoom.svg();
        colors = CreatePopupGradient.post.colors;
        break;
      case 'create_event':
        icon = Assets.icons.icHouseParty.svg();
        colors = CreatePopupGradient.event.colors;
        break;
      case 'create_poap':
        icon = Assets.icons.icCreatePoap.svg();
        colors = CreatePopupGradient.poap.colors;
        break;
      case 'create_collectible':
        icon = Assets.icons.icCrystal.svg();
        colors = CreatePopupGradient.collectible.colors;
        break;
      default:
    }
    final title = firstButton['title'];
    final description = firstButton['description'];
    return AIMetadataButtonCard(
      title: title ?? '',
      description: description ?? '',
      suffixIcon: icon,
      featureAvailable: featureAvailable,
      colors: colors,
      onTap: () {
        if (action == 'create_post') {
          Vibrate.feedback(FeedbackType.light);
          AutoRouter.of(context).navigate(const CreatePostRoute());
        }
      },
    );
  }
}
