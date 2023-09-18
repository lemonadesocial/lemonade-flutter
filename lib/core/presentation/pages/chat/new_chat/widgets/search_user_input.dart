import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class SearchUserInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final List<Profile> selectedUsers;

  const SearchUserInput({
    Key? key,
    required this.onChanged,
    required this.selectedUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.white06,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Wrap(
              spacing: 6.w,
              runSpacing: -6.h,
              children: [
                // Display tags for selected users
                for (Profile user in selectedUsers)
                  FilterChip(
                    label: Text(
                      user.displayName!,
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      side: BorderSide(color: LemonColor.white09),
                    ),
                    onSelected: (bool value) {},
                  ),
              ],
            ),
          ),
          TextField(
            cursorColor: colorScheme.onSurfaceVariant,
            onChanged: onChanged,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurfaceVariant,
            ),
            decoration: InputDecoration(
              hintText: t.chat.searchPeople,
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
              border: InputBorder.none,
              hoverColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            ),
          ),
        ],
      ),
    );
  }
}
