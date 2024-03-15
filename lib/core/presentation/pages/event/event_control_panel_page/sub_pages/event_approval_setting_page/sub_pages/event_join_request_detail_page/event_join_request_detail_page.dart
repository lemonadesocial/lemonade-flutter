import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_application_page/event_join_request_application_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_status_history.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/sub_pages/event_join_request_detail_page/widgets/event_join_request_tickets_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/event/query/get_event_join_request.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class EventJoinRequestDetailPage extends StatefulWidget {
  final EventJoinRequest eventJoinRequest;
  final Function()? onPressApprove;
  final Function()? onPressDecline;
  final Function()? onRefetchList;

  const EventJoinRequestDetailPage({
    super.key,
    required this.eventJoinRequest,
    this.onPressApprove,
    this.onPressDecline,
    this.onRefetchList,
  });

  @override
  State<EventJoinRequestDetailPage> createState() =>
      _EventJoinRequestDetailPageState();
}

class _EventJoinRequestDetailPageState
    extends State<EventJoinRequestDetailPage> {
  late EventJoinRequest _eventJoinRequest;

  @override
  initState() {
    super.initState();
    setState(() {
      _eventJoinRequest = widget.eventJoinRequest;
    });
  }

  Future<void> _refreshEventJoinRequest(Event? event) async {
    final data = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<EventRepository>().getEventJoinRequest(
        input: Variables$Query$GetEventJoinRequest(
          event: event?.id ?? '',
          id: _eventJoinRequest.id ?? '',
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (data.result == null) {
      return;
    }
    data.result?.fold((l) => null, (eventJoinRequest) {
      setState(() {
        _eventJoinRequest = eventJoinRequest;
      });
    });
    await widget.onRefetchList?.call();
  }

  bool get isPending =>
      _eventJoinRequest.approvedBy == null &&
      _eventJoinRequest.declinedBy == null;

  Future<dynamic> openApplication(BuildContext context, Event? event) {
    return showCupertinoModalBottomSheet(
      expand: true,
      useRootNavigator: true,
      backgroundColor: LemonColor.atomicBlack,
      context: context,
      builder: (context) => EventJoinRequestApplicationPage(
        eventJoinRequest: _eventJoinRequest,
        event: event,
        onPressApprove: () async {
          await widget.onPressApprove?.call();
          Navigator.of(context, rootNavigator: true).pop();
          await _refreshEventJoinRequest(event);
        },
        onPressDecline: () async {
          await widget.onPressDecline?.call();
          Navigator.of(context, rootNavigator: true).pop();
          await _refreshEventJoinRequest(event);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (eventDetail) => eventDetail,
        );
    final totalApplicationQuestionCount =
        (event?.applicationQuestions ?? []).length +
            (event?.applicationProfileFields ?? []).length;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventApproval.guestDetail,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: EventJoinRequestStatusHistory(
                    // TODO: For testing purpose, will remove when PR done
                    // eventJoinRequest: mockEscrowJoinRequest(_eventJoinRequest),
                    eventJoinRequest: _eventJoinRequest,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.xSmall * 3),
                  sliver: SliverToBoxAdapter(
                    child: ListTile(
                      onTap: () {
                        openApplication(context, event);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(LemonRadius.medium),
                      ),
                      dense: true,
                      tileColor: LemonColor.atomicBlack,
                      title: Text(
                        t.event.eventApproval.viewApplication,
                        style: Typo.small.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      subtitle: Text(
                        t.event.eventApproval.applicationQuestions(
                          n: totalApplicationQuestionCount,
                          count: totalApplicationQuestionCount,
                        ),
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      leading: Container(
                        height: Sizing.medium,
                        width: Sizing.medium,
                        decoration: BoxDecoration(
                          color: LemonColor.darkBackground,
                          borderRadius: BorderRadius.circular(Sizing.medium),
                        ),
                        child: Center(
                          child: ThemeSvgIcon(
                            color: colorScheme.onSurfaceVariant,
                            builder: (filter) => Assets.icons.icApplication.svg(
                              colorFilter: filter,
                            ),
                          ),
                        ),
                      ),
                      trailing: ThemeSvgIcon(
                        color: colorScheme.onSurfaceVariant,
                        builder: (filter) => Assets.icons.icArrowRight.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                ),
                EventJoinRequestTickesList(
                  eventJoinRequest: _eventJoinRequest,
                  event: event,
                ),
              ],
            ),
          ),
          // Floating section for decline/approve join request
          if (isPending)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.smMedium,
                    horizontal: Spacing.xSmall,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearGradientButton(
                          onTap: () async {
                            await widget.onPressDecline?.call();
                            await _refreshEventJoinRequest(event);
                          },
                          radius: BorderRadius.circular(LemonRadius.small * 2),
                          height: Sizing.large,
                          label: t.common.actions.decline,
                          textStyle: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                          leading: ThemeSvgIcon(
                            color: LemonColor.errorRedBg,
                            builder: (filter) => Assets.icons.icClose.svg(
                              colorFilter: filter,
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Expanded(
                        child: LinearGradientButton(
                          onTap: () async {
                            await widget.onPressApprove?.call();
                            await _refreshEventJoinRequest(event);
                          },
                          radius: BorderRadius.circular(LemonRadius.small * 2),
                          height: Sizing.large,
                          label: t.common.actions.accept,
                          textStyle: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                          leading: ThemeSvgIcon(
                            color: LemonColor.paleViolet,
                            builder: (filter) => Assets.icons.icDone.svg(
                              colorFilter: filter,
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
