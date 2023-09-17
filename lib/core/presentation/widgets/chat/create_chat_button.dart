import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateChatButton extends StatelessWidget {
  const CreateChatButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  buildCustomButton() {
    return Container(
      width: 54.h,
      height: 54.h,
      padding: const EdgeInsets.all(15),
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
          return DropdownMenuItem<String>(
            value: item.text,
            child: MenuItems.buildItem(item),
          );
        }).toList(),
        onChanged: (value) {
          MenuItems.onChanged(context, value! as MenuItem);
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

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const MenuItem createChat =
      MenuItem(text: 'Create chat', icon: Icons.chat);
  static const MenuItem createRoom =
      MenuItem(text: 'Create room', icon: Icons.add_box);
  static const MenuItem exploreRooms =
      MenuItem(text: 'Explore rooms', icon: Icons.explore);

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

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.createChat:
        //Do something
        break;
      case MenuItems.createRoom:
        //Do something
        break;
      case MenuItems.exploreRooms:
        //Do something
        break;
    }
  }
}
