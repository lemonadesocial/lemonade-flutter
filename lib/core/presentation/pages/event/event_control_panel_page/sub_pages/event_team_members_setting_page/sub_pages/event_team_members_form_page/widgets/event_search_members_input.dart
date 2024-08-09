import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/event_team_member_item.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventSearchMembersInput extends StatefulWidget {
  const EventSearchMembersInput({super.key});

  @override
  EventSearchMembersInputState createState() => EventSearchMembersInputState();
}

class EventSearchMembersInputState extends State<EventSearchMembersInput> {
  final _controller = TextEditingController();
  bool _showRecommendationBox = false;
  String? _searchValue;

  void onConfirmInviteViaEmail() {
    context.read<EventTeamMembersFormBloc>().add(
          EventTeamMembersFormBlocEventAddNewEmail(email: _controller.text),
        );
    _controller.clear();
    setState(() {
      _showRecommendationBox = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LemonTextField(
          controller: _controller,
          borderColor: LemonColor.white09,
          hintText: t.event.teamMembers.searchProfileOrEnterEmail,
          contentPadding: EdgeInsets.all(Spacing.smMedium),
          onChange: (value) {
            if (value.isEmpty) {
              context.read<GetUsersBloc>().add(
                    GetUsersEvent.reset(),
                  );
              return;
            }
            context.read<GetUsersBloc>().add(
                  GetUsersEvent.fetch(
                    limit: 4,
                    skip: 0,
                    search: value,
                  ),
                );
            setState(() {
              _showRecommendationBox = true;
              _searchValue = value;
            });
          },
          onFieldSubmitted: (newValue) => onConfirmInviteViaEmail(),
          autocorrect: false,
          enableSuggestions: false,
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        if (_showRecommendationBox == true)
          BlocBuilder<GetUsersBloc, GetUsersState>(
            builder: (context, state) {
              final isInviteViaEmail = StringUtils.isValidEmail(_searchValue);
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () => const SizedBox(),
                success: (users) {
                  if (users.isEmpty || isInviteViaEmail == true) {
                    return _NoSuggestionsCard(
                      email: _searchValue ?? '',
                      isInviteViaEmail: isInviteViaEmail,
                      onTap: () {
                        if (isInviteViaEmail) {
                          onConfirmInviteViaEmail();
                        }
                      },
                    );
                  }
                  return Container(
                    decoration: ShapeDecoration(
                      color: colorScheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(LemonRadius.small),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var item in users)
                          InkWell(
                            onTap: () {
                              setState(() {
                                _showRecommendationBox = false;
                              });
                              _controller.clear();
                              context.read<EventTeamMembersFormBloc>().add(
                                    EventTeamMembersFormBlocEvent.addNewUser(
                                      user: item,
                                    ),
                                  );
                            },
                            child: _CustomUserItem(
                              user: item,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        if (_showRecommendationBox == false)
          BlocBuilder<EventTeamMembersFormBloc, EventTeamMembersFormBlocState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return EventTeamMemberItem(
                    userItem: state.users[index],
                    onRemove: () {
                      context.read<EventTeamMembersFormBloc>().add(
                            EventTeamMembersFormBlocEvent.removeUser(
                              index: index,
                            ),
                          );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: Spacing.superExtraSmall,
                  );
                },
              );
            },
          ),
      ],
    );
  }
}

class _CustomUserItem extends StatelessWidget {
  final User user;

  const _CustomUserItem({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
        vertical: Spacing.xSmall,
      ),
      child: Row(
        children: [
          LemonCircleAvatar(
            size: Sizing.medium,
            url: AvatarUtils.getAvatarUrl(user: user),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? '',
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimary,
                ),
              ),
              Text(
                user.username ?? '',
                style: Typo.small.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoSuggestionsCard extends StatelessWidget {
  const _NoSuggestionsCard({this.email, this.isInviteViaEmail, this.onTap});
  final String? email;
  final bool? isInviteViaEmail;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = isInviteViaEmail == true
        ? email
        : t.event.teamMembers.noSuggestionsFound;
    final subTitle = isInviteViaEmail == true
        ? t.event.teamMembers.inviteViaEmail
        : t.event.teamMembers.tryEnteringEmail;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap?.call();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xSmall,
          vertical: Spacing.smMedium,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: LemonColor.white06,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
        ),
        child: Row(
          children: [
            if (isInviteViaEmail == true)
              Container(
                width: Sizing.medium,
                height: Sizing.medium,
                margin: EdgeInsets.only(
                  right: Spacing.xSmall,
                ),
                decoration: ShapeDecoration(
                  color: colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LemonRadius.small * 2),
                  ),
                ),
                child: Center(
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icEmailAt.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary,
                    height: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                    height: 0,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
