import 'package:app/core/application/report/report_bloc/report_bloc.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/report/report_submitted_popup.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportBottomSheet extends StatefulWidget {
  final String title;
  final String description;
  final String placeholder;
  final Function(String reportReasion) onPressReport;

  const ReportBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.placeholder,
    required this.onPressReport,
  });

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  String reportReason = '';
  final dragController = DraggableScrollableController();

  bool get isValid => reportReason.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(
        width: 1.w,
        color: colorScheme.outline,
      ),
    );
    return LemonSnapBottomSheet(
      controller: dragController,
      backgroundColor: LemonColor.atomicBlack,
      defaultSnapSize: 0.55,
      snapSizes: const [0.55, 0.95],
      maxSnapSize: 0.95,
      minSnapSize: 0.55,
      builder: (scrollController) {
        return Focus(
          onFocusChange: (focused) {
            if (focused) {
              dragController.animateTo(
                0.95,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            } else {
              dragController.animateTo(
                0.55,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LemonBackButton(
                    color: colorScheme.onSecondary,
                  ),
                  SizedBox(height: Spacing.smMedium),
                  Text(
                    widget.title,
                    style: Typo.extraLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    widget.description,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                  SizedBox(
                    height: 123.w,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          reportReason = value;
                        });
                      },
                      maxLines: 5,
                      cursorColor: colorScheme.onPrimary,
                      decoration: InputDecoration(
                        focusedBorder: border,
                        border: border,
                        hintText: widget.placeholder,
                        hintStyle: Typo.mediumPlus
                            .copyWith(color: colorScheme.outlineVariant),
                        enabledBorder: border,
                      ),
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall * 3),
                  BlocConsumer<ReportBloc, ReportState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        failure: () => Navigator.of(context).pop(),
                        success: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (_) => const ReportSubmittedPopup(),
                          );
                        },
                        orElse: () => null,
                      );
                    },
                    builder: (context, state) {
                      final isLoading = state is ReportStateLoading;
                      return Opacity(
                        opacity: isValid && !isLoading ? 1 : 0.5,
                        child: LinearGradientButton(
                          onTap: () async {
                            if (!isValid || isLoading) return;
                            widget.onPressReport(reportReason);
                          },
                          height: 50.w,
                          radius: BorderRadius.circular(LemonRadius.small * 2),
                          label: isLoading
                              ? t.common.processing
                              : t.common.actions.report,
                          textStyle: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                          mode: GradientButtonMode.lavenderMode,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
