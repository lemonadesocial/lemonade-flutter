import 'package:app/core/application/event/invite_event_bloc/invite_event_bloc.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_invite_setting_page/sub_pages/event_invite_form_page/widgets/event_invite_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventInviteFormPage extends StatelessWidget {
  final _scrollController = ScrollController();

  EventInviteFormPage({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.inviteEvent.inviteEventTitle,
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                        ),
                        SizedBox(height: Spacing.superExtraSmall),
                        Text(
                          t.event.inviteEvent.inviteEventDescription,
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.large),
                  ),
                  // ticket dropdown
                  SliverToBoxAdapter(
                    child: Focus(
                      onFocusChange: (isFocused) {
                        if (isFocused) {
                          scrollToEnd();
                        } else {
                          scrollToTop();
                        }
                      },
                      child: EventInviteForm(
                        onAddButtonPressed: scrollToEnd,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 350.w),
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
                  child: BlocBuilder<InviteEventBloc, InviteEventBlocState>(
                    builder: (context, state) => Opacity(
                      opacity: state.isValid ? 1 : 0.5,
                      child: LinearGradientButton.primaryButton(
                        onTap: () {
                          if (!state.isValid) return;
                          AutoRouter.of(context)
                              .replace(const EventInviteProcessingRoute());
                        },
                        label: t.common.next,
                        textColor: colorScheme.onPrimary,
                      ),
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
