import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingProfileTile extends StatelessWidget {
  const SettingProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authSession = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        border: Border.all(
          color: colorScheme.onPrimary.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          LemonCircleAvatar(
            url: authSession!.userAvatar ?? '',
            size: 42.r,
          ),
          SizedBox(width: Spacing.small),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(authSession.userDisplayName ?? ''),
                Text(
                  '@${authSession.username ?? ''}',
                  style: Typo.small.copyWith(color: colorScheme.onSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
