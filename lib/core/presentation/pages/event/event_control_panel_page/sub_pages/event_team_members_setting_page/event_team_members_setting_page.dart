import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTeamMembersSettingPage extends StatelessWidget {
  const EventTeamMembersSettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventTeamMembersSettingPageView(event: event);
  }
}

class EventTeamMembersSettingPageView extends StatefulWidget {
  const EventTeamMembersSettingPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventTeamMembersSettingPageView> createState() =>
      _EventTeamMembersSettingPageViewState();
}

class _EventTeamMembersSettingPageViewState
    extends State<EventTeamMembersSettingPageView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.background,
        title: t.event.teamMembers.title,
      ),
      backgroundColor: colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.xSmall,
              right: Spacing.xSmall,
              top: Spacing.xSmall,
              bottom: Spacing.superExtraSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 42.w,
                    child: TextField(
                      controller: _textController,
                      onChanged: (v) {},
                      cursorColor: colorScheme.onSecondary,
                      decoration: InputDecoration(
                        fillColor: LemonColor.atomicBlack,
                        hintStyle: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: StringUtils.capitalize(t.common.search),
                        filled: true,
                        isDense: true,
                        enabledBorder: border,
                        focusedBorder: border,
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ThemeSvgIcon(
                              color: colorScheme.onSecondary,
                              builder: (filter) => Assets.icons.icSearch.svg(
                                colorFilter: filter,
                                width: Sizing.mSmall,
                                height: Sizing.mSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Spacing.xSmall,
                ),
                _AddTeamMemberButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTeamMemberButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizing.medium,
      height: Sizing.medium,
      padding: EdgeInsets.all(LemonRadius.xSmall),
      decoration: ShapeDecoration(
        color: LemonColor.acidGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Sizing.xSmall,
            height: Sizing.xSmall,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: ThemeSvgIcon(
              color: LemonColor.paleViolet,
              builder: (filter) => Assets.icons.icAdd.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
