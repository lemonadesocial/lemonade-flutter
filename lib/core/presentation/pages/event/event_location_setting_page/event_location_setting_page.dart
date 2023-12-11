import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/pages/event/event_location_setting_page/widgets/location_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

@RoutePage()
class EventLocationSettingPage extends StatefulWidget {
  const EventLocationSettingPage({Key? key}) : super(key: key);

  @override
  State<EventLocationSettingPage> createState() =>
      _EventLocationSettingPageState();
}

class _EventLocationSettingPageState extends State<EventLocationSettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: colorScheme.onPrimaryContainer,
        title: t.event.eventLocation,
      ),
      backgroundColor: colorScheme.onPrimaryContainer,
      body: _buildContent(colorScheme),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    List<Address> addresses = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses ?? [],
          orElse: () => [],
        );
    return BlocListener<EventDateTimeSettingsBloc, EventDateTimeSettingsState>(
      listener: (context, state) async {},
      child: BlocBuilder<EventDateTimeSettingsBloc, EventDateTimeSettingsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.small,
              vertical: Spacing.small,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.locationSetting.description,
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () => _onTapAddNew(),
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          LemonColor.darkCharcoalGray,
                          LemonColor.darkCharcoalGray,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.event.locationSetting.addNew,
                            style: Typo.extraMedium.copyWith(
                              fontFamily: FontFamily.nohemiVariable,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(Icons.add_circle_outline_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  t.event.locationSetting.myPlaces,
                  style: Typo.extraMedium,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Expanded(
                  child: AddressList(
                    addresses: addresses,
                  ),
                ),
                _buildSaveButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  _onTapAddNew() {
    Vibrate.feedback(FeedbackType.light);
  }

  _buildSaveButton() {
    return LinearGradientButton(
      label: t.common.save,
      height: 48.h,
      radius: BorderRadius.circular(24),
      textStyle: Typo.medium.copyWith(),
      mode: GradientButtonMode.lavenderMode,
      onTap: () {},
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({
    super.key,
    required this.addresses,
  });

  final List<Address> addresses;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
        },
        // child:  Container(height: 100, color: Colors.red,),
        child: LocationItem(
          location: addresses[index],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      itemCount: addresses.length,
    );
  }
}
