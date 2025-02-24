import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/payment/mutation/disconnect_stripe_account_mutation.graphql.dart';
import 'package:app/graphql/backend/payment/mutation/generate_stripe_account_link_mutation.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupStripePaymentAccountBuilder extends StatefulWidget {
  final Widget Function(
    // ignore: library_private_types_in_public_api
    _SetupStripePaymentAccountBuilderState state,
  ) builder;
  final Function(PaymentAccount)? onPaymentAccountCreated;
  const SetupStripePaymentAccountBuilder({
    super.key,
    required this.builder,
    this.onPaymentAccountCreated,
  });

  @override
  State<SetupStripePaymentAccountBuilder> createState() =>
      _SetupStripePaymentAccountBuilderState();
}

class _SetupStripePaymentAccountBuilderState
    extends State<SetupStripePaymentAccountBuilder>
    with WidgetsBindingObserver {
  bool stripePaymentAccountCreated = false;
  bool stripeConnected = false;
  bool isCreatingPaymentAccount = false;

  bool hasStripePaymentAccount(Event? event) {
    final eventPaymentAccountsExpanded = event?.paymentAccountsExpanded ?? [];
    final hasStripePaymentAccount = eventPaymentAccountsExpanded.any(
      (item) => item.provider == PaymentProvider.stripe,
    );
    return hasStripePaymentAccount;
  }

  bool hasStripeConnected(User? loggedInUser) {
    final hasStripeConnected = loggedInUser?.stripeConnectedAccount != null &&
        loggedInUser?.stripeConnectedAccount?.connected == true;
    return hasStripeConnected;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
            orElse: () => null,
            authenticated: (user) => user,
          );
      final event = context.read<GetEventDetailBloc>().state.maybeWhen(
            orElse: () => null,
            fetched: (event) => event,
          );

      setState(() {
        stripeConnected = hasStripeConnected(loggedInUser);
        stripePaymentAccountCreated = hasStripePaymentAccount(event);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );

    final hasStripeConnected = loggedInUser?.stripeConnectedAccount != null &&
        loggedInUser?.stripeConnectedAccount?.connected == true;
    if (!hasStripeConnected) {
      context.read<AuthBloc>().add(const AuthEvent.refreshData());
    }
  }

  PaymentAccount? getStripePaymentAccount() {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    final eventPaymentAccountsExpanded = event?.paymentAccountsExpanded ?? [];
    final stripePaymentAccount = eventPaymentAccountsExpanded
        .firstWhere((item) => item.provider == PaymentProvider.stripe);
    return stripePaymentAccount;
  }

  Future<void> createStripePaymentAccount() async {
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    setState(() {
      isCreatingPaymentAccount = true;
    });
    final createPaymentAccountResult =
        await getIt<PaymentRepository>().createPaymentAccount(
      input: CreatePaymentAccountInput(
        type: PaymentAccountType.digital,
        provider: PaymentProvider.stripe,
      ),
    );

    if (createPaymentAccountResult.isLeft()) {
      setState(() {
        isCreatingPaymentAccount = false;
      });
      return;
    }

    final newPaymentAccount =
        createPaymentAccountResult.getOrElse(() => PaymentAccount());

    final updatedEvent = (await getIt<EventRepository>().updateEvent(
      input: Input$EventInput(
        payment_accounts_new: [
          ...event?.paymentAccountsNew ?? [],
          newPaymentAccount.id ?? '',
        ],
      ),
      id: event?.id ?? '',
    ))
        .fold((l) => null, (r) => r);

    if (updatedEvent == null) {
      setState(() {
        isCreatingPaymentAccount = false;
      });
      return;
    }

    stripePaymentAccountCreated = true;

    setState(() {
      isCreatingPaymentAccount = false;
    });
    context.read<GetEventDetailBloc>().add(
          GetEventDetailEvent.replace(event: updatedEvent),
        );
    widget.onPaymentAccountCreated?.call(newPaymentAccount);
  }

  Future<void> connectStripe() async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<AppGQL>().client.mutate$GenerateStripeAccountLink(
            Options$Mutation$GenerateStripeAccountLink(
              variables: Variables$Mutation$GenerateStripeAccountLink(
                returnUrl: AppConfig.webUrl,
                refreshUrl: AppConfig.webUrl,
              ),
            ),
          ),
    );
    final url = response.result?.parsedData?.generateStripeAccountLink.url;
    if (url != null) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> disconnectStripe() async {
    final response = await showFutureLoadingDialog(
      context: context,
      future: () => getIt<AppGQL>().client.mutate$disconnectStripeAccount(),
    );
    if (response.result?.parsedData?.disconnectStripeAccount == true) {
      context.read<AuthBloc>().add(const AuthEvent.refreshData());
    }
    setState(() {
      stripeConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        final loggedInUser = state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
        final event = context
            .read<GetEventDetailBloc>()
            .state
            .maybeWhen(orElse: () => null, fetched: (event) => event);
        if (hasStripeConnected(loggedInUser)) {
          setState(() {
            stripeConnected = true;
          });
          if (!hasStripePaymentAccount(event)) {
            createStripePaymentAccount();
          } else {
            setState(() {
              stripePaymentAccountCreated = true;
            });
            widget.onPaymentAccountCreated?.call(getStripePaymentAccount()!);
          }
        }
      },
      builder: (context, state) {
        return widget.builder(this);
      },
    );
  }
}
