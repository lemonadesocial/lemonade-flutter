import 'package:app/core/data/event/dtos/event_application_answer_dto/event_application_answer_dto.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_application_answer.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/social_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_application_answers.graphql.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

class EventJoinRequestApplicationForm extends StatelessWidget {
  final User? userInfo;
  final Event? event;
  final EventJoinRequest? eventJoinRequest;

  const EventJoinRequestApplicationForm({
    super.key,
    this.userInfo,
    this.event,
    this.eventJoinRequest,
  });

  bool get _isNonLoginUser => eventJoinRequest?.user == null;

  @override
  Widget build(BuildContext context) {
    List<String> profileRequiredFields = (event?.applicationProfileFields ?? [])
        .map((item) => item.field ?? '')
        .map(StringUtils.snakeToCamel)
        .toList();
    return MultiSliver(
      children: [
        if (profileRequiredFields.isNotEmpty) ...[
          SizedBox(height: Spacing.medium),
          SliverList.separated(
            itemCount: profileRequiredFields.length,
            itemBuilder: (context, index) {
              final userInfoJson = userInfo?.toJson();
              final value = userInfoJson?.tryGet(profileRequiredFields[index]);
              final isSocialFieldName = SocialUtils.isSocialFieldName(
                fieldName: profileRequiredFields[index],
              );
              String? finalValue;
              if (value is String) {
                final isValidDate = date_utils.DateUtils.isValidDateTime(value);
                if (isValidDate) {
                  finalValue =
                      date_utils.DateUtils.formatDateTimeToDDMMYYYY(value);
                } else {
                  // If it's a social field name, build social link, otherwise return the value itself
                  finalValue = isSocialFieldName
                      ? SocialUtils.buildSocialLinkBySocialFieldName(
                          socialFieldName: profileRequiredFields[index],
                          socialUserName: value,
                        )
                      : value;
                }
              }
              return _FormField(
                label: ProfileFieldKey.getFieldLabel(
                  (event?.applicationProfileFields ?? [])[index].field ?? '',
                ),
                value: finalValue,
              );
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.medium),
          ),
        ],
        SizedBox(height: Spacing.medium),
        Query$GetEventApplicationAnswers$Widget(
          options: Options$Query$GetEventApplicationAnswers(
            variables: Variables$Query$GetEventApplicationAnswers(
              event: event?.id ?? '',
              user: _isNonLoginUser ? null : eventJoinRequest?.user,
              email: _isNonLoginUser
                  ? eventJoinRequest?.nonLoginUser?.email
                  : null,
            ),
          ),
          builder: (
            result, {
            refetch,
            fetchMore,
          }) {
            final eventApplicationQuestions = event?.applicationQuestions ?? [];
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
              itemCount: eventApplicationQuestions.length,
              itemBuilder: (context, index) {
                final answer = applicationAnswers.firstWhereOrNull(
                  (element) =>
                      element.question == eventApplicationQuestions[index].id,
                );
                return _FormField(
                  label: eventApplicationQuestions[index].question ?? '',
                  value: answer?.answer ?? '',
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
        Linkify(
          text: label,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
          ),
          linkStyle: Typo.mediumPlus.copyWith(
            color: LemonColor.paleViolet,
            decoration: TextDecoration.none,
          ),
          onOpen: (link) async {
            await launchUrl(Uri.parse(link.url));
          },
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
