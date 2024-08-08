import 'package:app/core/application/event/event_team_members_form_bloc/event_team_members_form_bloc.dart';
import 'package:app/core/application/user/get_users_bloc/get_users_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_team_members_setting_page/sub_pages/event_team_members_form_page/widgets/event_team_member_item.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventSearchMembersInput extends StatefulWidget {
  EventSearchMembersInput({super.key});

  @override
  _EventSearchMembersInputState createState() =>
      _EventSearchMembersInputState();
}

class _EventSearchMembersInputState extends State<EventSearchMembersInput> {
  final _controller = TextEditingController();
  bool _showUsers = false;

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
              _showUsers = true;
            });
          },
          onFieldSubmitted: (newValue) {
            context.read<EventTeamMembersFormBloc>().add(
                  EventTeamMembersFormBlocEventAddNewEmail(email: newValue),
                );
            _controller.clear();
            setState(() {
              _showUsers = false;
            });
          },
          autocorrect: false,
          enableSuggestions: false,
        ),
        SizedBox(
          height: Spacing.xSmall,
        ),
        if (_showUsers == true)
          BlocBuilder<GetUsersBloc, GetUsersState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () => const SizedBox(),
                success: (users) {
                  if (users.isEmpty) {
                    return const SizedBox();
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
                                _showUsers = false;
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
        if (_showUsers == false)
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
    super.key,
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
