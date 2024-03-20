import 'package:app/core/data/event/dtos/event_application_answer_dto/event_application_answer_dto.dart';
import 'package:app/core/domain/applicant/entities/applicant.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_application_answer.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_application_answers.graphql.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class EventJoinRequestApplicationForm extends StatelessWidget {
  final Applicant? applicant;
  final Event? event;
  const EventJoinRequestApplicationForm({
    super.key,
    this.applicant,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    List<String> profileRequiredFields = (event?.applicationProfileFields ?? [])
        .map((item) => item.field ?? '')
        .toList();

    List<String> formattedFieldNames =
        profileRequiredFields.map(StringUtils.underToWords).toList();

    return MultiSliver(
      children: [
        SliverList.separated(
          itemCount: profileRequiredFields.length,
          itemBuilder: (context, index) {
            final applicantJson = applicant?.toJson();
            final value = applicantJson?.tryGet(profileRequiredFields[index]);
            final isSocialFieldName = SocialUtils.isSocialFieldName(
              fieldName: profileRequiredFields[index],
            );
            String? finalValue = null;
            if (value is String) {
              if (date_utils.DateUtils.isValidDateTime(value)) {

              }
              if (isSocialFieldName) {
                finalValue = SocialUtils.buildSocialLinkBySocialFieldName(
                  socialFieldName: profileRequiredFields[index],
                  socialUserName: value,
                );
              } else {
                finalValue = value;
              }
            }
            return _FormField(
              label: StringUtils.capitalize(formattedFieldNames[index]),
              value: finalValue,
            );
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: Spacing.medium),
        ),
        SizedBox(height: Spacing.medium),
        Query$GetEventApplicationAnswers$Widget(
          options: Options$Query$GetEventApplicationAnswers(
            variables: Variables$Query$GetEventApplicationAnswers(
              event: event?.id ?? '',
              user: applicant?.id ?? '',
            ),
          ),
          builder: (
            result, {
            refetch,
            fetchMore,
          }) {
            final applicationAnswers =
                (result.parsedData?.getEventApplicationAnswers ?? [])
                    .map(
                      (item) => EventApplicationAnswer.fromDto(
                        EventApplicationAnswerDto.fromJson(
                          item.toJson(),
                        ),
                      ),
                    )
                    .toList();
            return SliverList.separated(
              itemCount: applicationAnswers.length,
              itemBuilder: (context, index) {
                return _FormField(
                  label: applicationAnswers[index].questionExpanded?.question ??
                      '',
                  value: applicationAnswers[index].answer ?? '',
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.medium),
            );
          },
        ),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String? value;
  const _FormField({
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Linkify(
                      text: value ?? '',
                      style: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      linkStyle: Typo.mediumPlus.copyWith(
                        color: colorScheme.onPrimary,
                        decoration: TextDecoration.none,
                      ),
                      onOpen: (link) async {
                        await launchUrl(
                          Uri.parse(link.url),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (StringUtils.isUrl(value ?? ''))
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final match =
                              StringUtils.urlRegx.firstMatch(value ?? '');
                          if (match != null) {
                            final url = match.group(0);
                            launchUrl(Uri.parse(url ?? ''));
                          }
                        },
                        child: Assets.icons.icExpand.svg(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
