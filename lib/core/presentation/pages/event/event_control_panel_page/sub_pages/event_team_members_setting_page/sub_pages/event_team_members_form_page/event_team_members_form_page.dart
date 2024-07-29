import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

@RoutePage()
class EventTeamMembersFormPage extends StatelessWidget {
  final _scrollController = ScrollController();

  EventTeamMembersFormPage({super.key});

  scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Spacing.smMedium,
                right: Spacing.smMedium,
                top: Spacing.xSmall,
              ),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.teamMembers.addTeamMember,
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w800,
                            fontFamily: FontFamily.nohemiVariable,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: Spacing.superExtraSmall),
                        Text(
                          t.event.teamMembers.addTeamMemberDescription,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.large),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              children: [_CircleNumber(label: '1')],
                            ),
                            SizedBox(
                              width: Spacing.small,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.event.teamMembers.chooseRole,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: Spacing.xSmall,
                                ),
                                // const ChooseRoleDropdown(ticketTypes: []),
                                Container(
                                  width: 300,
                                  height: 60,
                                  padding: const EdgeInsets.all(18),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.white
                                            .withOpacity(0.09000000357627869),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ThemeSvgIcon(
                                        color: colorScheme.onPrimary,
                                        builder: (colorFilter) =>
                                            Assets.icons.icEyeOutline.svg(
                                          colorFilter: colorFilter,
                                          width: 18.w,
                                          height: 18.w,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Expanded(
                                        child: SizedBox(
                                          height: 18,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Visible on event',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'Switzer Variable',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Spacing.xSmall),
                                      FlutterSwitch(
                                        inactiveColor: colorScheme.outline,
                                        inactiveToggleColor:
                                            colorScheme.onSurfaceVariant,
                                        activeColor: LemonColor.switchActive,
                                        activeToggleColor:
                                            colorScheme.onPrimary,
                                        height: 24.h,
                                        width: 42.w,
                                        value: true,
                                        padding: 3.w,
                                        onToggle: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              children: [_CircleNumber(label: '2')],
                            ),
                            SizedBox(
                              width: Spacing.small,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.event.teamMembers.selectTeamMembers,
                                    style: Typo.medium.copyWith(
                                      color: colorScheme.onSecondary,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Spacing.xSmall,
                                  ),
                                  LemonTextField(
                                    borderColor: LemonColor.white09,
                                    hintText: t.event.teamMembers
                                        .searchProfileOrEnterEmail,
                                    contentPadding:
                                        EdgeInsets.all(Spacing.smMedium),
                                    onChange: (value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(Spacing.smMedium),
                child: SafeArea(
                  child: Opacity(
                    opacity: 0.5,
                    child: LinearGradientButton.primaryButton(
                      onTap: () {},
                      label: t.common.actions.sendInvite,
                      textColor: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleNumber extends StatelessWidget {
  const _CircleNumber({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: Sizing.medium,
      height: Sizing.medium,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2.w,
            color: LemonColor.white09,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
