import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class BottomBarCreateButton extends StatelessWidget {
  const BottomBarCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    return InkWell(
      onTap: () {
        SnackBarUtils.showComingSoon();
        // authState.maybeWhen(
        //   authenticated: (session) => context.router.push(const AIRoute()),
        //   orElse: () => context.router.navigate(const LoginRoute()),
        // );
      },
      child: Container(
        width: 48.h,
        height: 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: ShapeDecoration(
          color: const Color(0x2DC69DF7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
        ),
        child: Assets.icons.icCreate.svg(),
      ),
    );
  }
}
