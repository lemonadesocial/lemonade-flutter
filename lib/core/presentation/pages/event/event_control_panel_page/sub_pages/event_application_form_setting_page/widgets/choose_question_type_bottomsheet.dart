import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_profile_setting_page/event_application_form_profile_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_select_question_setting_page/event_application_form_select_question_setting_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_application_form_setting_page/sub_pages/event_application_form_text_question_setting_page/event_application_form_text_question_setting_page.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ApplicationFormQuestionTypeItem {
  final String title;
  final String description;
  final SvgGenImage icon;
  final Function onTap;

  ApplicationFormQuestionTypeItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}

class ChooseQuestionTypeBottomSheet extends StatefulWidget {
  const ChooseQuestionTypeBottomSheet({
    super.key,
  });

  static show(BuildContext context) {
    final applicationFormSettingBloc =
        context.read<EventApplicationFormSettingBloc>();
    showCupertinoModalBottomSheet(
      context: context,
      topRadius: Radius.circular(LemonRadius.medium),
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: LemonColor.atomicBlack,
      builder: (context) => BlocProvider.value(
        value: applicationFormSettingBloc,
        child: const ChooseQuestionTypeBottomSheet(),
      ),
    );
  }

  @override
  State<ChooseQuestionTypeBottomSheet> createState() =>
      _ChooseQuestionTypeBottomSheetState();
}

class _ChooseQuestionTypeBottomSheetState
    extends State<ChooseQuestionTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    final applicationFormSettingBloc =
        context.read<EventApplicationFormSettingBloc>();
    final items = [
      ApplicationFormQuestionTypeItem(
        title: t.event.applicationForm.questionType.personalInfo,
        description:
            t.event.applicationForm.questionType.personalInfoDescription,
        icon: Assets.icons.icInfo,
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            topRadius: Radius.circular(LemonRadius.medium),
            builder: (context) => EventApplicationFormProfileSettingPage(
              event: event,
              profileType: ApplicationFormProfileType.basicInfo,
            ),
          );
        },
      ),
      ApplicationFormQuestionTypeItem(
        title: t.event.applicationForm.questionType.socialProfile,
        description:
            t.event.applicationForm.questionType.socialProfileDescription,
        icon: Assets.icons.icAccountBox,
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            topRadius: Radius.circular(LemonRadius.medium),
            builder: (context) => EventApplicationFormProfileSettingPage(
              event: event,
              profileType: ApplicationFormProfileType.socialMediaInfo,
            ),
          );
        },
      ),
      ApplicationFormQuestionTypeItem(
        title: t.event.applicationForm.questionType.text,
        description: t.event.applicationForm.questionType.textDescription,
        icon: Assets.icons.icInsertTextOutline,
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            topRadius: Radius.circular(LemonRadius.medium),
            builder: (context) => BlocProvider.value(
              value: applicationFormSettingBloc,
              child: EventApplicationFormTextQuestionSettingPage(
                event: event,
              ),
            ),
          );
        },
      ),
      ApplicationFormQuestionTypeItem(
        title: t.event.applicationForm.questionType.singleSelect,
        description:
            t.event.applicationForm.questionType.singleSelectDescription,
        icon: Assets.icons.icSingleSelect,
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            topRadius: Radius.circular(LemonRadius.medium),
            builder: (context) => BlocProvider.value(
              value: applicationFormSettingBloc,
              child: EventApplicationFormSelectQuestionSettingPage(
                event: event,
                selectType: Enum$SelectType.single,
              ),
            ),
          );
        },
      ),
      ApplicationFormQuestionTypeItem(
        title: t.event.applicationForm.questionType.multipleSelect,
        description:
            t.event.applicationForm.questionType.multipleSelectDescription,
        icon: Assets.icons.icMultiSelect,
        onTap: () {
          showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            topRadius: Radius.circular(LemonRadius.medium),
            builder: (context) => BlocProvider.value(
              value: applicationFormSettingBloc,
              child: EventApplicationFormSelectQuestionSettingPage(
                event: event,
                selectType: Enum$SelectType.multi,
              ),
            ),
          );
        },
      ),
    ];

    return Container(
      color: LemonColor.atomicBlack,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetGrabber(),
            LemonAppBar(
              title: t.event.applicationForm.chooseQuestionType,
              backgroundColor: LemonColor.atomicBlack,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final questionTypeItem = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    questionTypeItem.onTap();
                  },
                  child: Container(
                    padding: EdgeInsets.all(Spacing.small),
                    decoration: BoxDecoration(
                      color: LemonColor.chineseBlack,
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                    ),
                    child: Row(
                      children: [
                        ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => questionTypeItem.icon.svg(
                            colorFilter: filter,
                          ),
                        ),
                        SizedBox(width: Spacing.small),
                        Text(
                          questionTypeItem.title,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: Spacing.xSmall);
              },
              itemCount: items.length,
            ),
            // SizedBox(height: Spacing.small),
          ],
        ),
      ),
    );
  }
}
