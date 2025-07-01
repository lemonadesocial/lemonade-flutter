import 'package:app/core/application/event/create_event_discount_bloc/create_event_discount_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_payment_ticket_discount.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_discount_setting_page/sub_pages/event_discount_form_setting_page/widgets/discount_limit_setting_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_discount_setting_page/sub_pages/event_discount_form_setting_page/widgets/discount_percentage_picker.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/text_formatter/upper_case_text_formatter.dart';
import 'package:app/graphql/backend/event/mutation/create_event_ticket_discount.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDiscountFormSettingPage extends StatelessWidget {
  final EventPaymentTicketDiscount? discount;
  const EventDiscountFormSettingPage({
    super.key,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEventDiscountBloc(
        discount: discount,
      ),
      child: _EventDiscountFormSettingPageView(
        discount: discount,
      ),
    );
  }
}

class _EventDiscountFormSettingPageView extends StatelessWidget {
  final EventPaymentTicketDiscount? discount;
  const _EventDiscountFormSettingPageView({
    this.discount,
  });

  Future<void> _createDiscount(
    BuildContext context, {
    required CreateEventDiscountData data,
    required String eventId,
  }) async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<EventTicketRepository>().createEventDiscounts(
        input: Variables$Mutation$CreateEventTicketDiscounts(
          event: eventId,
          inputs: [
            Input$EventPaymentTicketDiscountInput(
              code: data.code!,
              ratio: data.ratio!,
              ticket_limit: data.ticketLimit,
              ticket_limit_per: data.ticketLimitPer,
            ),
          ],
        ),
      ),
    );
    response.result?.fold((l) => null, (r) {
      context.read<GetEventDetailBloc>().add(
            GetEventDetailEvent.fetch(eventId: eventId),
          );
      SnackBarUtils.showSuccess(
        message: t.event.eventPromotions.promotionCreatedSuccess,
      );
      AutoRouter.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final readOnly = discount != null;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );

    final createEventDiscountBloc = context.read<CreateEventDiscountBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: LemonAppBar(
        title: readOnly
            ? t.event.eventPromotions.promotionDetailsTitle
            : t.event.eventPromotions.newPromotion,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LemonTextField(
                      readOnly: readOnly,
                      initialText: createEventDiscountBloc.state.data.code,
                      onChange: (value) {
                        context.read<CreateEventDiscountBloc>().add(
                              CreateEventDiscountEvent.onCodeChanged(
                                code: value,
                              ),
                            );
                      },
                      inputFormatters: [
                        // allow alphabet and numeric
                        FilteringTextInputFormatter.deny(
                          RegExp(r'[^a-zA-Z0-9]'),
                        ),
                        UpperCaseTextFormatter(),
                      ],
                      hintText: t.event.eventPromotions.accessCode,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.large,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DiscountPercentagePicker(
                      readOnly: readOnly,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.large,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DiscountLimitSettingForm(
                      readOnly: readOnly,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ),
                ],
              ),
            ),
            if (!readOnly)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  decoration: BoxDecoration(
                    color: appColors.pageBg,
                    border: Border(
                      top: BorderSide(color: appColors.pageDivider),
                    ),
                  ),
                  child: SafeArea(
                    child: BlocBuilder<CreateEventDiscountBloc,
                        CreateEventDiscountState>(
                      builder: (context, state) {
                        return Opacity(
                          opacity: state.isValid ? 1 : 0.5,
                          child: LinearGradientButton.primaryButton(
                            onTap: () {
                              if (!state.isValid || event == null) {
                                return;
                              }
                              _createDiscount(
                                context,
                                data: state.data,
                                eventId: event.id ?? '',
                              );
                            },
                            label: t.common.actions.add,
                          ),
                        );
                      },
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
