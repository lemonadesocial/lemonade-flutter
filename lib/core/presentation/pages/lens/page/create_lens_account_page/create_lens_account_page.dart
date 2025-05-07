import 'package:app/core/application/lens/create_lens_account_bloc/create_lens_account_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_account_page/widgets/creaet_lens_account_success_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/lens/account/query/lens_get_username.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reown_appkit/modal/utils/debouncer.dart';

@RoutePage()
class CreateLensAccountPage extends StatelessWidget {
  const CreateLensAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLensAccountBloc(
        getIt<LensRepository>(),
        getIt<LensGroveService>(),
      ),
      child: const CreateLensAccountPageView(),
    );
  }
}

class CreateLensAccountPageView extends StatefulWidget {
  const CreateLensAccountPageView({
    super.key,
  });

  @override
  State<CreateLensAccountPageView> createState() =>
      _CreateLensAccountPageViewState();
}

class _CreateLensAccountPageViewState extends State<CreateLensAccountPageView> {
  bool userExisted = false;
  bool isValid = false;
  final regex = RegExp(
    r'^[a-zA-Z0-9_-]{1,26}$',
  );
  bool touched = false;

  final TextEditingController _usernameController = TextEditingController();
  final debouncer = Debouncer(milliseconds: 300);

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  _validate(String username) {
    if (!touched) {
      setState(() {
        touched = true;
      });
    }

    if (username.trim().isEmpty) {
      setState(() {
        userExisted = false;
        isValid = false;
      });
      return;
    }

    if (!regex.hasMatch(username)) {
      setState(() {
        isValid = false;
      });
      return;
    }

    debouncer.run(() async {
      final result = await getIt<LensGQL>().client.query$LensUsername(
            Options$Query$LensUsername(
              variables: Variables$Query$LensUsername(
                request: Input$UsernameRequest(
                  username: Input$UsernameInput(
                    localName: username,
                  ),
                ),
              ),
            ),
          );
      setState(() {
        isValid = true;
        userExisted = result.parsedData?.username != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    return BlocConsumer<CreateLensAccountBloc, CreateLensAccountState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (token, refreshToken, account, idToken) async {
            await showCupertinoModalBottomSheet(
              context: context,
              isDismissible: false,
              expand: false,
              barrierColor: Colors.black.withOpacity(0.5),
              backgroundColor: LemonColor.atomicBlack,
              builder: (context) => CreateLensAccountSuccessBottomSheet(
                username: _usernameController.text,
              ),
            );
            context.read<LensAuthBloc>().add(
                  LensAuthEvent.accountCreated(
                    token: token,
                    refreshToken: refreshToken,
                    account: account,
                  ),
                );
            AutoRouter.of(context).pop(true);
          },
          failed: (failure) {
            SnackBarUtils.showError(message: failure.message);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isCreating = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        final showError = touched && (userExisted || !isValid);
        final canSubmit = isValid && !userExisted;
        return Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: const LemonAppBar(),
                backgroundColor: theme.colorScheme.primary,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.onboarding.pickUsername,
                              style: Typo.extraLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: Spacing.extraSmall),
                            Text(
                              t.lens.claimUsernameDescription,
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: Spacing.medium),
                            LemonTextField(
                              onChange: _validate,
                              controller: _usernameController,
                              hintText: t.onboarding.username,
                              borderColor:
                                  showError ? LemonColor.errorRedBg : null,
                              statusWidget: touched
                                  ? statusWidget(
                                      context,
                                      userExisted,
                                      isValid,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Opacity(
                              opacity: canSubmit ? 1 : 0.5,
                              child: LinearGradientButton.primaryButton(
                                onTap: canSubmit
                                    ? () async {
                                        context
                                            .read<CreateLensAccountBloc>()
                                            .add(
                                              CreateLensAccountEvent
                                                  .requestCreateLensAccount(
                                                username:
                                                    _usernameController.text,
                                              ),
                                            );
                                      }
                                    : null,
                                label: t.onboarding.claim,
                              ),
                            ),
                            SizedBox(height: Spacing.xSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.common.poweredBy,
                                  style: Typo.small.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(width: Spacing.extraSmall),
                                Assets.icons.icLens.svg(),
                              ],
                            ),
                            SizedBox(height: Spacing.xSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isCreating)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Loading.defaultLoading(context),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget statusWidget(
    BuildContext context,
    bool usernameExisted,
    bool isValid,
  ) {
    final color = usernameExisted || !isValid
        ? LemonColor.errorRedBg
        : LemonColor.usernameApproved;
    final t = Translations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          usernameExisted || !isValid ? Icons.info_outline : Icons.check_circle,
          color: color,
        ),
        SizedBox(width: Spacing.superExtraSmall),
        Flexible(
          child: Text(
            usernameExisted
                ? t.onboarding.usernameTaken
                : isValid
                    ? t.onboarding.usernameAvailable
                    : t.lens.usernameValidationRules,
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
