// import 'package:app/core/domain/user/entities/user.dart';
// import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
// import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
// import 'package:app/core/utils/avatar_utils.dart';
// import 'package:app/gen/assets.gen.dart';
// import 'package:app/theme/sizing.dart';
// import 'package:app/theme/spacing.dart';
// import 'package:app/theme/typo.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class EventTeamMemberItem extends StatelessWidget {
//   const EventTeamMemberItem({
//     super.key,
//     required this.userItem,
//     required this.onRemove,
//   });
//   final Function()? onRemove;
//   final Either<User, String> userItem;

//   String getLabelDisplay() {
//     return userItem.fold(
//       (user) => user.name ?? '',
//       (email) => email,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final user = userItem.fold((user) => user, (r) => null);
//     return Container(
//       padding: EdgeInsets.all(Spacing.smMedium),
//       decoration: ShapeDecoration(
//         color: colorScheme.secondaryContainer,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(LemonRadius.small),
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           user is User
//               ? LemonCircleAvatar(
//                   size: Sizing.medium / 2,
//                   url: AvatarUtils.getAvatarUrl(
//                     user: user,
//                   ),
//                 )
//               : Center(
//                   child: ThemeSvgIcon(
//                     color: colorScheme.onPrimary,
//                     builder: (filter) => Assets.icons.icEmailAt.svg(
//                       width: Sizing.xSmall,
//                       height: Sizing.xSmall,
//                       colorFilter: filter,
//                     ),
//                   ),
//                 ),
//           SizedBox(width: Spacing.xSmall),
//           Expanded(
//             child: SizedBox(
//               child: Text(
//                 getLabelDisplay(),
//                 style: Typo.mediumPlus.copyWith(
//                   color: colorScheme.onPrimary,
//                   height: 0,
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: Spacing.xSmall),
//           InkWell(
//             onTap: () {
//               if (onRemove != null) onRemove?.call();
//             },
//             child: Center(
//               child: ThemeSvgIcon(
//                 color: colorScheme.onSecondary,
//                 builder: (filter) => Assets.icons.icClose.svg(
//                   width: Sizing.xSmall,
//                   height: Sizing.xSmall,
//                   colorFilter: filter,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
