import 'package:app/core/presentation/pages/chat/chat_list/views/chat_list_page_view.dart';
import 'package:app/core/presentation/pages/chat/new_chat/new_chat_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateChatButton extends StatelessWidget {
  final int selectedTabIndex;
  const CreateChatButton({
    super.key,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Temporary hide create guild button
    if (ChatListTabs.messages.tabIndex == ChatListTabs.guilds.index) {
      return const SizedBox();
    }
    return InkWell(
      onTap: () {
        if (selectedTabIndex == ChatListTabs.messages.tabIndex ||
            selectedTabIndex == ChatListTabs.channels.tabIndex) {
          const NewChatPageDialog().showAsBottomSheet(context);
        } else if (selectedTabIndex == ChatListTabs.guilds.tabIndex) {
          AutoRouter.of(context).navigate(const CreateGuildChannelRoute());
        }
      },
      child: Container(
        width: 54.h,
        height: 54.h,
        padding: EdgeInsets.all(15.w),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LemonColor.fabSecondaryBg, LemonColor.fabFirstBg],
          ),
          boxShadow: [
            BoxShadow(
              color: LemonColor.fabShadow,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ThemeSvgIcon(
          color: LemonColor.white,
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
