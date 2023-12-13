import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/presentation/pages/setting/widgets/setting_tile_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

enum EventPrivacy { public, private }

@RoutePage()
class EventGuestSettingsPage extends StatefulWidget {
  const EventGuestSettingsPage({Key? key}) : super(key: key);

  @override
  State<EventGuestSettingsPage> createState() => _EventGuestSettingsPageState();
}

class _EventGuestSettingsPageState extends State<EventGuestSettingsPage> {
  final TextEditingController guestLimitPerController = TextEditingController();
  final TextEditingController guestLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final createEventBloc = context.read<CreateEventBloc>().state;
    guestLimitPerController.text = createEventBloc.guestLimitPer ?? "";
    guestLimitController.text = createEventBloc.guestLimit ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: LemonAppBar(
          backgroundColor: colorScheme.onPrimaryContainer,
          title: t.event.eventCreation.guestSettings,
        ),
        backgroundColor: colorScheme.onPrimaryContainer,
        body: SingleChildScrollView(child: _buildContent(colorScheme)),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildSegmentedButton(colorScheme, state),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
                vertical: Spacing.xSmall,
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    title: t.event.guestSettings.autoApprove,
                    subTitle: t.event.guestSettings.autoApproveDescription,
                    value: state.verify,
                    onChanged: (value) {
                      Vibrate.feedback(FeedbackType.light);
                      context
                          .read<CreateEventBloc>()
                          .add(VerifyChanged(verify: value));
                    },
                  ),
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
                  _buildContainer(
                    _buildSettingTile(
                      title: t.event.guestSettings.guestUnlockLimit,
                      subTitle:
                          t.event.guestSettings.guestUnlockLimitDescription,
                      value: state.guestLimitPer == null,
                      onChanged: (value) =>
                          _onGuestLimitPerToggle(value, state),
                      trailing: SizedBox(
                        width: 60.w,
                        child: LemonTextField(
                          textInputType: TextInputType.number,
                          controller: guestLimitPerController,
                          contentPadding: EdgeInsets.all(Spacing.small),
                          onChange: (value) => context
                              .read<CreateEventBloc>()
                              .add(GuestLimitPerChanged(guestLimitPer: value)),
                          readOnly: state.guestLimitPer == null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
                  _buildContainer(
                    _buildSettingTile(
                      title: t.event.guestSettings.noUnlockLimit,
                      value: state.guestLimitPer == null,
                      onChanged: (value) =>
                          _onNoGuestLimitPerToggle(value, state),
                      subTitle: '',
                    ),
                  ),
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
                  _buildContainer(
                    _buildSettingTile(
                      title: t.event.guestSettings.totalGuestLimit,
                      subTitle:
                          t.event.guestSettings.totalGuestLimitDescription,
                      value: state.guestLimit == null,
                      onChanged: (value) => _onGuestLimitToggle(value, state),
                      trailing: SizedBox(
                        width: 60.w,
                        child: LemonTextField(
                          textInputType: TextInputType.number,
                          controller: guestLimitController,
                          contentPadding: EdgeInsets.all(Spacing.small),
                          onChange: (value) => context
                              .read<CreateEventBloc>()
                              .add(GuestLimitChanged(guestLimit: value)),
                          readOnly: state.guestLimit == null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
                  _buildContainer(
                    _buildSettingTile(
                      title: t.event.guestSettings.noGuestLimit,
                      value: state.guestLimit == null,
                      onChanged: (value) => _onNoGuestLimitToggle(value, state),
                      subTitle: '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSegmentedButton(
    ColorScheme colorScheme,
    CreateEventState state,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      width: double.maxFinite,
      child: SegmentedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? LemonColor.lavender18
                : LemonColor.chineseBlack;
          }),
          foregroundColor:
              MaterialStateColor.resolveWith((Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? LemonColor.lavender
                : LemonColor.black33;
          }),
          textStyle: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              return const TextStyle(
                fontFamily: FontFamily.nohemiVariable,
                fontWeight: FontWeight.w700,
              );
            },
          ),
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(
            value: false,
            label: Text("Public"),
            icon: Icon(Icons.visibility_off_outlined),
          ),
          ButtonSegment(
            value: true,
            label: Text("Private"),
            icon: Icon(Icons.visibility_outlined),
          ),
        ],
        selected: {state.private},
        onSelectionChanged: (Set<bool> newSelection) {
          context.read<CreateEventBloc>().add(
                PrivateChanged(private: newSelection.first),
              );
        },
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subTitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Widget? trailing,
  }) {
    return SettingTileWidget(
      title: title,
      subTitle: subTitle,
      onTap: () => {},
      trailing: trailing ??
          FlutterSwitch(
            inactiveColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.12),
            inactiveToggleColor:
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.18),
            activeColor: LemonColor.switchActive,
            activeToggleColor: Theme.of(context).colorScheme.onPrimary,
            height: 24.h,
            width: 42.w,
            value: value,
            onToggle: onChanged,
          ),
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }

  void _onGuestLimitPerToggle(bool isGuestLimitPer, CreateEventState state) {
    guestLimitPerController.text =
        isGuestLimitPer ? '' : EventConstants.defaultEventGuestLimitPer;
    context.read<CreateEventBloc>().add(
          GuestLimitPerChanged(
            guestLimitPer: isGuestLimitPer
                ? null
                : EventConstants.defaultEventGuestLimitPer,
          ),
        );
  }

  void _onNoGuestLimitPerToggle(
    bool isNoGuestLimitPer,
    CreateEventState state,
  ) {
    guestLimitPerController.text =
        isNoGuestLimitPer ? '' : EventConstants.defaultEventGuestLimitPer;
    context.read<CreateEventBloc>().add(
          GuestLimitPerChanged(
            guestLimitPer: isNoGuestLimitPer
                ? null
                : EventConstants.defaultEventGuestLimitPer,
          ),
        );
  }

  void _onGuestLimitToggle(bool isGuestLimit, CreateEventState state) {
    guestLimitController.text =
        isGuestLimit ? '' : EventConstants.defaultEventGuestLimit;
    context.read<CreateEventBloc>().add(
          GuestLimitChanged(
            guestLimit:
                isGuestLimit ? null : EventConstants.defaultEventGuestLimit,
          ),
        );
  }

  void _onNoGuestLimitToggle(bool isNoGuestLimit, CreateEventState state) {
    guestLimitController.text =
        isNoGuestLimit ? '' : EventConstants.defaultEventGuestLimit;
    context.read<CreateEventBloc>().add(
          GuestLimitChanged(
            guestLimit:
                isNoGuestLimit ? null : EventConstants.defaultEventGuestLimit,
          ),
        );
  }
}
