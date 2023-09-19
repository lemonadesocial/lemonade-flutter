import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';

enum ChatOptions { chatDetails, leave }

class ChatSettingsPopupMenu extends StatefulWidget {
  final Room room;

  const ChatSettingsPopupMenu({Key? key, required this.room}) : super(key: key);

  @override
  ChatSettingsPopupMenuState createState() => ChatSettingsPopupMenuState();
}

class ChatSettingsPopupMenuState extends State<ChatSettingsPopupMenu> {
  StreamSubscription? notificationChangeSub;

  @override
  void dispose() {
    notificationChangeSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    notificationChangeSub ??= getIt<MatrixService>()
        .client
        .onAccountData
        .stream
        .where((u) => u.type == 'm.push_rules')
        .listen(
          (u) => setState(() {}),
        );
    return FloatingFrostedGlassDropdown(
      items: <DropdownItemDpo<ChatOptions>>[
        DropdownItemDpo(
          label: t.chat.chatDetails,
          value: ChatOptions.chatDetails,
          leadingIcon: const Icon(
            Icons.info_outline,
          ),
        ),
        DropdownItemDpo(
          label: t.chat.leave,
          value: ChatOptions.leave,
          leadingIcon: const Icon(
            Icons.logout_outlined,
          ),
        ),
      ],
      offset: Offset(0, -25.h),
      onItemPressed: (item) async {
        switch (item?.value) {
          case ChatOptions.chatDetails:
            if (kDebugMode) {
              print("chat detail");
            }
            break;
          case ChatOptions.leave:
            if (kDebugMode) {
              print("leave");
            }
            final confirmed = await showOkCancelAlertDialog(
              useRootNavigator: false,
              context: context,
              title: t.common.areYouSure,
              okLabel: t.common.actions.ok,
              cancelLabel: t.common.actions.cancel,
            );
            if (confirmed == OkCancelResult.ok) {
              final success = await showFutureLoadingDialog(
                context: context,
                future: () => widget.room.leave(),
              );
              if (success.error == null) {
                AutoRouter.of(context).navigateNamed('/chat');
              }
            }
            break;
          default:
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        alignment: Alignment.centerRight,
        child: ThemeSvgIcon(
          color: colorScheme.onSurface,
          builder: (filter) => Assets.icons.icMoreHoriz.svg(
            colorFilter: filter,
          ),
        ),
      ),
    );
  }
}
