import 'package:app/core/application/profile/report_user_bloc/report_user_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/profile/enum/user_report_reason.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ReportUserDialog extends StatelessWidget with LemonBottomSheet {
  const ReportUserDialog({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final bloc = ReportUserBloc(getIt<UserRepository>());
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<ReportUserBloc, ReportUserState>(
        listener: (context, state) {
          if (state.status == ReportUserStatus.success) {
            context.router.popUntilRoot();
            SnackBarUtils.showSuccessSnackbar(t.profile.reportSuccess);
          }

          if (state.status == ReportUserStatus.error) {
            context.router.pop();
            SnackBarUtils.showErrorSnackbar(t.common.somethingWrong);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: const LemonBackButton(),
              backgroundColor: colorScheme.onPrimaryContainer,
            ),
            backgroundColor: colorScheme.onPrimaryContainer,
            body: Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.profile.reportProfile,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.common.reportProfileDesc,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.normal),
                      color: LemonColor.darkBackground,
                    ),
                    child: ListView.separated(
                      itemCount: UserReportReason.values.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(Spacing.smMedium),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                UserReportReason.values[index].reason,
                                style: Typo.mediumPlus
                                    .copyWith(color: colorScheme.onPrimary),
                              ),
                            ),
                            Radio<UserReportReason>(
                              activeColor: LemonColor.paleViolet,
                              value: UserReportReason.values[index],
                              groupValue: state.reason,
                              onChanged: bloc.onReasonChange,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(),
                    ),
                  ),
                  SizedBox(height: Spacing.smMedium),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.normal),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            t.profile.blockProfile,
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        FlutterSwitch(
                          inactiveColor:
                              colorScheme.onPrimary.withOpacity(0.12),
                          inactiveToggleColor:
                              colorScheme.onPrimary.withOpacity(0.18),
                          activeColor: LemonColor.switchActive,
                          activeToggleColor: colorScheme.onPrimary,
                          height: 24.h,
                          width: 42.w,
                          value: state.blockUser,
                          onToggle: bloc.onBlockUserToggle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Spacing.small * 2),
                  LinearGradientButton(
                    onTap: state.reason == null
                        ? null
                        : () => bloc.reportUser(userId: userId),
                    label: t.common.actions.report,
                    textStyle: Typo.medium.copyWith(
                      fontFamily: FontFamily.nohemiVariable,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                    height: Sizing.large,
                    radius: BorderRadius.circular(LemonRadius.large),
                    mode: state.reason == null
                        ? GradientButtonMode.lavenderDisableMode
                        : GradientButtonMode.lavenderMode,
                    loadingWhen: state.status == ReportUserStatus.loading,
                  ),
                  SizedBox(height: Spacing.smMedium),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
