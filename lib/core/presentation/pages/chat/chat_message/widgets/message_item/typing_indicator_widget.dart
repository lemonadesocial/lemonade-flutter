import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class TypingIndicators extends StatelessWidget {
  final ChatController controller;
  final client = getIt<MatrixService>().client;

  TypingIndicators(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typingUsers = controller.room.typingUsers
      ..removeWhere((u) => u.stateKey == client.userID);
    const bottomPadding = 4.0;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedContainer(
        constraints: const BoxConstraints(maxWidth: 360 * 2.5),
        height:
            typingUsers.isEmpty ? 0 : MatrixAvatar.defaultSize + bottomPadding,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
        alignment: controller.timeline!.events.isNotEmpty &&
                controller.timeline!.events.first.senderId == client.userID
            ? Alignment.topRight
            : Alignment.topLeft,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: bottomPadding,
        ),
        child: Row(
          children: [
            SizedBox(
              height: MatrixAvatar.defaultSize,
              width: typingUsers.length < 2
                  ? MatrixAvatar.defaultSize
                  : MatrixAvatar.defaultSize + 16,
              child: Stack(
                children: [
                  if (typingUsers.isNotEmpty)
                    MatrixAvatar(
                      mxContent: typingUsers.first.avatarUrl,
                      name: typingUsers.first.calcDisplayname(),
                      size: 42.w,
                      radius: 42.r,
                    ),
                  if (typingUsers.length == 2)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: MatrixAvatar(
                        mxContent: typingUsers.length == 2
                            ? typingUsers.last.avatarUrl
                            : null,
                        name: typingUsers.length == 2
                            ? typingUsers.last.calcDisplayname()
                            : '+${typingUsers.length - 1}',
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              child: Lottie.asset(Assets.lotties.typing),
            )
          ],
        ),
      ),
    );
  }
}
