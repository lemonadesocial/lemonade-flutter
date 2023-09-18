import 'package:app/core/presentation/pages/chat/new_chat/new_chat_page.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateChatButton extends StatelessWidget {
  const CreateChatButton({
    super.key,
  });

  buildCustomButton() {
    return Container(
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
          )
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItems.createChat,
      MenuItems.createRoom,
      MenuItems.exploreRooms
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: buildCustomButton(),
        items: menuItems.map((item) {
          return DropdownMenuItem<MenuItemType>(
            value: item.type,
            child: MenuItems.buildItem(item),
          );
        }).toList(),
        onChanged: (value) {
          MenuItems.onChanged(context, value!);
        },
        dropdownStyleData: DropdownStyleData(
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: LemonColor.dropdownBackground,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          overlayColor: MaterialStatePropertyAll(LemonColor.dropdownBackground),
        ),
      ),
    );
  }
}

enum MenuItemType { createChat, createRoom, exploreRooms }

class MenuItem {
  const MenuItem({
    required this.type,
    required this.icon,
  });

  final MenuItemType type;
  final IconData icon;

  String get text {
    switch (type) {
      case MenuItemType.createChat:
        return 'Create chat';
      case MenuItemType.createRoom:
        return 'Create room';
      case MenuItemType.exploreRooms:
        return 'Explore rooms';
    }
  }
}

abstract class MenuItems {
  static const MenuItem createChat =
      MenuItem(type: MenuItemType.createChat, icon: Icons.chat);
  static const MenuItem createRoom =
      MenuItem(type: MenuItemType.createRoom, icon: Icons.add_box);
  static const MenuItem exploreRooms =
      MenuItem(type: MenuItemType.exploreRooms, icon: Icons.explore);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItemType type) {
    switch (type) {
      case MenuItemType.createChat:
        const NewChatPageDialog().showAsBottomSheet(context);
        break;
      case MenuItemType.createRoom:
        break;
      case MenuItemType.exploreRooms:
        break;
    }
  }
}
