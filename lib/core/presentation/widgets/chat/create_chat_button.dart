import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/chat_list_page_view.dart';
import 'package:app/core/presentation/pages/chat/new_chat/new_chat_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateChatButton extends StatelessWidget {
  final int selectedTabIndex;
  const CreateChatButton({
    super.key,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: () {
        if (selectedTabIndex == ChatListTabs.messages.tabIndex ||
            selectedTabIndex == ChatListTabs.channels.tabIndex) {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (mContext) => const NewChatPageDialog(),
            useRootNavigator: true,
          );
        } else if (selectedTabIndex == ChatListTabs.guilds.tabIndex) {
          AutoRouter.of(context).navigate(const CreateGuildChannelRoute());
        }
      },
      child: Container(
        width: 54.h,
        height: 54.h,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: appColors.buttonPrimaryBg,
        ),
        child: ThemeSvgIcon(
          color: appColors.buttonPrimary,
          builder: (filter) => Assets.icons.icAdd.svg(
            colorFilter: filter,
            width: 24.w,
            height: 24.w,
          ),
        ),
      ),
    );
  }
}
