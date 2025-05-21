import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/chat/chat_message/chat_message_page.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/chat_input_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_input/reply_display_widget.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/chat_settings_popup_menu.dart';
import 'package:app/core/presentation/pages/chat/chat_message/widgets/messages_list_widget.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/chat/room_status_extension.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageView extends StatelessWidget {
  final ChatController controller;
  const ChatMessageView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        backgroundColor: appColors.pageBg,
        backButtonColor: appColors.textTertiary,
        titleBuilder: (context) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MatrixAvatar(
                  size: 27,
                  mxContent: controller.room.avatar,
                  name: controller.room.name,
                  radius: 27,
                  fontSize: appText.sm.fontSize!,
                  isDirectChat: controller.room.isDirectChat,
                  presence: controller.room.directChatPresence?.presence,
                ),
                SizedBox(width: Spacing.xSmall),
                Flexible(
                  child: Text(
                    controller.room.getLocalizedDisplayname(),
                    style: appText.lg,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          ChatSettingsPopupMenu(
            room: controller.room,
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
              color: appColors.cardBg,
              image: DecorationImage(
                image: Assets.images.bgChat.provider(),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                StreamBuilder(
                  stream: controller.room.onUpdate.stream
                      .rateLimit(const Duration(seconds: 1)),
                  builder: (context, snapshot) => FutureBuilder(
                    future: controller.loadTimelineFuture,
                    builder: (context, snapshot) => controller.timeline == null
                        ? Expanded(
                            child: Center(
                              child: Loading.defaultLoading(context),
                            ),
                          )
                        : Expanded(
                            child: MessagesList(controller: controller),
                          ),
                  ),
                ),
                ReplyDisplay(controller),
                Divider(
                  color: appColors.pageDivider,
                  height: 1.h,
                ),
                ChatInput(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
