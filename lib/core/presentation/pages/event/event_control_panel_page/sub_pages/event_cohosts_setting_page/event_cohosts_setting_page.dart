import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/manage_event_cohost_requests_bloc/manage_event_cohost_requests_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_cohost_request.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_cohosts_setting_page/widgets/event_manage_cohosts_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/update_event.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventCohostsSettingPage extends StatelessWidget {
  const EventCohostsSettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (eventDetail) => eventDetail,
          orElse: () => null,
        );
    return EventCohostsSettingPageView(event: event);
  }
}

class EventCohostsSettingPageView extends StatefulWidget {
  const EventCohostsSettingPageView({
    super.key,
    this.event,
  });
  final Event? event;

  @override
  State<EventCohostsSettingPageView> createState() =>
      _EventCohostsSettingPageViewState();
}

class _EventCohostsSettingPageViewState
    extends State<EventCohostsSettingPageView> {
  Future<void> _updateCohostsOrder(List<String> newCohostsOrder) async {
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        await getIt<AppGQL>().client.mutate$UpdateEvent(
              Options$Mutation$UpdateEvent(
                variables: Variables$Mutation$UpdateEvent(
                  id: widget.event?.id ?? '',
                  input: Input$EventInput(
                    visible_cohosts: newCohostsOrder,
                  ),
                ),
              ),
            );
        context.read<GetEventDetailBloc>().add(
              GetEventDetailEvent.fetch(
                eventId: widget.event?.id ?? '',
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    List<EventCohostRequest> eventCohostsRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              fetched: (eventCohostsRequests) => eventCohostsRequests,
              orElse: () => [],
            );
    final loadingEventCohostsRequests =
        context.watch<GetEventCohostRequestsBloc>().state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
    final loadingManageEventCohostRequests =
        context.watch<ManageEventCohostRequestsBloc>().state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
    return Scaffold(
      appBar: LemonAppBar(
        backgroundColor: appColors.pageBg,
        title: t.event.configuration.coHosts,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Spacing.small),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).navigate(
                  const EventAddCohostsRoute(),
                );
              },
              child: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Spacing.small),
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).navigate(
                  EventReorderingCohostsRoute(
                    event: widget.event,
                    onDone: (newCohostsOrder) async {
                      await _updateCohostsOrder(newCohostsOrder);
                      AutoRouter.of(context).pop();
                    },
                  ),
                );
              },
              child: ThemeSvgIcon(
                color: appColors.textTertiary,
                builder: (filter) => Assets.icons.icReorder.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: appColors.pageBg,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ManageEventCohostRequestsBloc,
          ManageEventCohostRequestsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () => null,
            success: () async {
              context.read<GetEventCohostRequestsBloc>().add(
                    GetEventCohostRequestsEvent.fetch(
                      eventId: widget.event?.id ?? '',
                    ),
                  );
              context.read<GetEventDetailBloc>().add(
                    GetEventDetailEvent.fetch(
                      eventId: widget.event?.id ?? '',
                    ),
                  );
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.small,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: loadingEventCohostsRequests ||
                        loadingManageEventCohostRequests
                    ? Loading.defaultLoading(context)
                    : EventManageCohostsList(
                        eventCohostsRequests: eventCohostsRequests,
                        event: widget.event,
                      ),
              ),
              BlocBuilder<EditEventDetailBloc, EditEventDetailState>(
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: LinearGradientButton.primaryButton(
                        label: t.event.cohosts.addCohosts,
                        onTap: () {
                          AutoRouter.of(context)
                              .navigate(const EventAddCohostsRoute());
                        },
                        loadingWhen:
                            state.status == EditEventDetailBlocStatus.loading,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
