import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/ai/ai_page.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AIChatCard extends StatelessWidget {
  const AIChatCard({
    super.key,
    required this.message,
  });

  final AIChatMessage message;

  @override
  Widget build(BuildContext context) {
    bool isUser = message.isUser;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthStateAuthenticated) {
          if (!isUser) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: LemonColor.darkCharcoalGray,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.h,
                  horizontal: 15.w,
                ),
                leading: _buildAvatar(
                  isUser,
                  authState.authSession,
                ),
                title: Text(message.text),
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
                title: Text(message.text),
              ),
              SizedBox(
                height: 10.h,
              )
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
}
