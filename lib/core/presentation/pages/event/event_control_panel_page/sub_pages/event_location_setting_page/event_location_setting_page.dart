import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_location_setting_page/widgets/location_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
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
  const EventLocationSettingPage({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventLocationSettingPage> createState() =>
      _EventLocationSettingPageState();
}

class _EventLocationSettingPageState extends State<EventLocationSettingPage> {
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
      resizeToAvoidBottomInset: true,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    List<Address> addresses = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.addresses ?? [],
          orElse: () => [],
        );
    return BlocListener<EditEventDetailBloc, EditEventDetailState>(
      listener: (context, state) {
        if (state.status == EditEventDetailBlocStatus.success) {
          AutoRouter.of(context).pop();
        }
      },
      child: BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
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
                            t.event.locationSetting.addNew.toUpperCase(),
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
                  child: AddressList(addresses: addresses, event: widget.event),
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
    AutoRouter.of(context).navigate(EventLocationSettingDetailRoute());
  }

  _buildSaveButton() {
    return BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
      builder: (context, state) {
        return LinearGradientButton(
          label: t.common.save,
          height: 48.h,
          radius: BorderRadius.circular(24),
          textStyle: Typo.medium.copyWith(),
          mode: GradientButtonMode.lavenderMode,
          onTap: () {
            if (widget.event != null) {
              context.read<EditEventDetailBloc>().add(
                    EditEventDetailEvent.update(
                      eventId: widget.event?.id ?? '',
                      address: context
                          .read<EventLocationSettingBloc>()
                          .state
                          .selectedAddress,
                    ),
                  );
            } else {
              AutoRouter.of(context).pop();
            }
          },
          loadingWhen: state.status == EditEventDetailBlocStatus.loading,
        );
      },
    );
  }
}

class AddressList extends StatelessWidget {
  final Event? event;
  const AddressList({
    super.key,
    required this.addresses,
    this.event,
  });

  final List<Address> addresses;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventLocationSettingBloc, EventLocationSettingState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: Spacing.medium),
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Vibrate.feedback(FeedbackType.light);
            },
            child: LocationItem(
              location: addresses[index],
              onPressEdit: () {
                Vibrate.feedback(FeedbackType.light);
                _onTapEdit(addresses[index], context);
              },
              onPressDelete: () {
                Vibrate.feedback(FeedbackType.light);
                context
                    .read<EventLocationSettingBloc>()
                    .add(DeleteLocation(id: addresses[index].id));
              },
              onPressItem: () {
                Vibrate.feedback(FeedbackType.light);
                context
                    .read<EventLocationSettingBloc>()
                    .add(SelectAddress(address: addresses[index]));
              },
              selected: state.selectedAddress != null
                  ? state.selectedAddress?.id == addresses[index].id
                  : event?.address?.title == addresses[index].title,
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 10.h,
          ),
          itemCount: addresses.length,
        );
      },
    );
  }

  _onTapEdit(Address address, BuildContext context) {
    Vibrate.feedback(FeedbackType.light);
    AutoRouter.of(context)
        .navigate(EventLocationSettingDetailRoute(address: address));
  }
}
