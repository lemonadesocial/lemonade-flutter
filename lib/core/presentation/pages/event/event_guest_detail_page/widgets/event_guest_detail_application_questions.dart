import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/applicant/query/get_applicants_info.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:matrix/matrix.dart' as matrix;
import 'package:url_launcher/url_launcher.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/core/utils/social_utils.dart';

class EventGuestDetailApplicationQuestionsWidget extends StatelessWidget {
  final EventGuestDetail eventGuestDetail;

  const EventGuestDetailApplicationQuestionsWidget({
    super.key,
    required this.eventGuestDetail,
  });

  Future<User?> _getUserInfo(BuildContext context) async {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (data) => data,
        );

    final isNonLoginUser = eventGuestDetail.user.id == null;

    final data = await getIt<AppGQL>().client.query$GetApplicantsInfo(
          Options$Query$GetApplicantsInfo(
            variables: Variables$Query$GetApplicantsInfo(
              emails:
                  isNonLoginUser ? [eventGuestDetail.user.email ?? ''] : null,
              users: isNonLoginUser ? null : [eventGuestDetail.user.id ?? ''],
              event: event?.id ?? '',
            ),
          ),
        );

    final userInfo = data.parsedData?.getApplicantsInfo.firstOrNull?.toJson();
    return userInfo != null ? User.fromDto(UserDto.fromJson(userInfo)) : null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final applications = eventGuestDetail.application ?? [];
    final t = Translations.of(context);
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (data) => data,
        );
    List<String> profileRequiredFields = (event?.applicationProfileFields ?? [])
        .map((item) => item.field ?? '')
        .map(StringUtils.snakeToCamel)
        .toList();

    return FutureBuilder<User?>(
      future: _getUserInfo(context),
      builder: (context, snapshot) {
        final userInfo = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.event.eventGuestDetail.applicationQuestions,
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Profile Fields
            if (profileRequiredFields.isNotEmpty && userInfo != null) ...[
              ...List.generate(profileRequiredFields.length, (index) {
                final userInfoJson = userInfo.toJson();
                final value = userInfoJson.tryGet(profileRequiredFields[index]);
                final isSocialFieldName = SocialUtils.isSocialFieldName(
                  fieldName: profileRequiredFields[index],
                );
                String? finalValue;
                if (value is String) {
                  final isValidDate =
                      date_utils.DateUtils.isValidDateTime(value);
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

                return _QuestionAnswerItem(
                  question: ProfileFieldKey.getFieldLabel(
                    (event?.applicationProfileFields ?? [])[index].field ?? '',
                  ),
                  answer: finalValue ?? '--',
                  answers: const [],
                );
              }),
            ],
            // Application Questions
            ...applications.map(
              (qa) => _QuestionAnswerItem(
                question: qa.question,
                answer: qa.answer ?? '--',
                answers: qa.answers ?? [],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QuestionAnswerItem extends StatelessWidget {
  final String question;
  final String answer;
  final List<String> answers;

  const _QuestionAnswerItem({
    required this.question,
    required this.answer,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: Spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          if (answer.isNotEmpty)
            Linkify(
              text: answer,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
              linkStyle: Typo.medium.copyWith(
                color: LemonColor.paleViolet,
                decoration: TextDecoration.none,
              ),
              onOpen: (link) async {
                await launchUrl(Uri.parse(link.url));
              },
            )
          else if (answers.isNotEmpty)
            Linkify(
              text: answers.join(', '),
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
              linkStyle: Typo.medium.copyWith(
                color: LemonColor.paleViolet,
                decoration: TextDecoration.none,
              ),
              onOpen: (link) async {
                await launchUrl(Uri.parse(link.url));
              },
            ),
        ],
      ),
    );
  }
}
