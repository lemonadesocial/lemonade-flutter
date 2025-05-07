import 'package:app/core/application/lens/create_lens_feed_bloc/create_lens_feed_bloc.dart';
import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/login_lens_account_bloc/login_lens_account_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/mutation/update_space.graphql.dart';
import 'package:app/graphql/lens/feed/query/lens_get_feed.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';

class CreateLensNewFeedBottomSheet extends StatelessWidget {
  final Space space;

  const CreateLensNewFeedBottomSheet({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginLensAccountBloc(
            lensRepository: getIt<LensRepository>(),
            walletConnectService: getIt<WalletConnectService>(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateLensFeedBloc(
            getIt<LensRepository>(),
            getIt<LensGroveService>(),
          ),
        ),
      ],
      child: _View(space: space),
    );
  }
}

class _View extends StatefulWidget {
  final Space space;

  const _View({required this.space});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _adminController = TextEditingController();
  List<String> _admins = [''];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.space.title ?? '';
    _descriptionController.text = widget.space.description ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _adminController.dispose();
    super.dispose();
  }

  void _addNewAdmin() {
    setState(() {
      _admins.add('');
    });
  }

  void _removeAdmin(int index) {
    if (_admins.length > 1) {
      setState(() {
        _admins.removeAt(index);
      });
    }
  }

  void _updateAdmin(int index, String value) {
    setState(() {
      _admins[index] = value;
    });
  }

  void reloginToAccountOwner(BuildContext context) async {
    // Get the wallet address
    final ownerAddress =
        (await getIt<WalletConnectService>().getActiveSession())?.address;
    if (ownerAddress == null) {
      SnackBarUtils.showError(
        message: "Please connect your wallet first",
      );
      return;
    }

    // Get the lens auth state
    final lensAuthState = context.read<LensAuthBloc>().state;
    final availableAccounts = lensAuthState.availableAccounts;
    final accountAddress = availableAccounts.isEmpty
        ? null
        : availableAccounts
            .where(
              (account) =>
                  account.owner?.toLowerCase() == ownerAddress.toLowerCase(),
            )
            .firstOrNull
            ?.address;

    // Use the existing LoginLensAccountBloc from context
    context.read<LoginLensAccountBloc>().add(
          LoginLensAccountEvent.login(
            ownerAddress: ownerAddress,
            accountAddress: accountAddress ?? ownerAddress,
            accountStatus: LensAccountStatus.accountOwner,
          ),
        );
  }

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
      _admins.any((admin) => admin.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, lensState) {
        if (_admins.length == 1 &&
            _admins[0].isEmpty &&
            lensState.availableAccounts.isNotEmpty) {
          _admins = [AppConfig.lensLemonadeAdminAddress];
          _adminController.text = _admins[0];
        }
        return MultiBlocListener(
          listeners: [
            BlocListener<LoginLensAccountBloc, LoginLensAccountState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (token, refreshToken, idToken, accountStatus) {
                    context.read<LensAuthBloc>().add(
                          LensAuthEvent.authorized(
                            token: token,
                            refreshToken: refreshToken,
                            idToken: idToken,
                          ),
                        );
                    if (accountStatus == LensAccountStatus.accountOwner) {
                      Navigator.of(context).pop(true);
                      SnackBarUtils.showSuccess(
                        message: "Relogin to account owner successfully",
                      );
                    }
                  },
                  failed: (failure) {
                    Navigator.of(context).pop();
                    SnackBarUtils.showError(message: failure.message);
                  },
                  orElse: () {},
                );
              },
            ),
            BlocListener<CreateLensFeedBloc, CreateLensFeedState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (txHash) async {
                    final feed = await getIt<LensRepository>().getFeed(
                      input: Variables$Query$LensGetFeed(
                        request: Input$FeedRequest(
                          txHash: txHash,
                        ),
                      ),
                    );
                    if (feed.isRight()) {
                      final feedData = feed.fold((l) => null, (r) => r);
                      if (feedData != null) {
                        final feedAddress = feedData.address;
                        await getIt<SpaceRepository>().updateSpace(
                          input: Variables$Mutation$UpdateSpace(
                            id: widget.space.id ?? '',
                            input: Input$SpaceInput(
                              lens_feed_id: feedAddress,
                            ),
                          ),
                        );
                        reloginToAccountOwner(context);
                      }
                    }
                  },
                  failed: (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(failure.message ?? 'Unknown error'),
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
            ),
          ],
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: LemonColor.atomicBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BottomSheetGrabber(),
                  LemonAppBar(
                    title: t.space.lens.createNewFeed,
                    backgroundColor: LemonColor.atomicBlack,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(Spacing.smMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name field
                          Text(
                            t.space.lens.name,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Spacing.xSmall),
                          LemonTextField(
                            controller: _nameController,
                            hintText: t.space.lens.name,
                            onChange: (_) => setState(() {}),
                          ),
                          SizedBox(height: Spacing.medium),

                          // Description field
                          Text(
                            t.space.lens.description,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Spacing.xSmall),
                          LemonTextField(
                            controller: _descriptionController,
                            hintText: t.space.lens.description,
                            maxLines: 3,
                            onChange: (_) => setState(() {}),
                          ),
                          SizedBox(height: Spacing.medium),

                          // Admins section
                          Text(
                            t.space.lens.admins,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: Spacing.xSmall),
                          Column(
                            children: [
                              ..._admins.asMap().entries.map(
                                    (entry) => Column(
                                      children: [
                                        _AdminField(
                                          value: entry.value,
                                          onChanged: (value) =>
                                              _updateAdmin(entry.key, value),
                                          onRemove: () =>
                                              _removeAdmin(entry.key),
                                          removable: _admins.length > 1,
                                        ),
                                        SizedBox(height: Spacing.xSmall),
                                      ],
                                    ),
                                  ),
                              SizedBox(height: Spacing.superExtraSmall),
                              _AddButton(
                                onPress: _addNewAdmin,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: LemonColor.atomicBlack,
                      border: Border(
                        top: BorderSide(color: colorScheme.outline),
                      ),
                    ),
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: SafeArea(
                      child: Opacity(
                        opacity: _isFormValid ? 1 : 0.5,
                        child: BlocBuilder<CreateLensFeedBloc,
                            CreateLensFeedState>(
                          builder: (context, state) {
                            return LinearGradientButton.primaryButton(
                              onTap: _isFormValid
                                  ? () {
                                      FocusScope.of(context).unfocus();
                                      context.read<CreateLensFeedBloc>().add(
                                            CreateLensFeedEvent.createFeed(
                                              name: _nameController.text,
                                              description:
                                                  _descriptionController.text,
                                              admins: _admins
                                                  .where(
                                                    (admin) => admin.isNotEmpty,
                                                  )
                                                  .toList(),
                                            ),
                                          );
                                    }
                                  : null,
                              label: t.space.lens.createFeed,
                              textColor: colorScheme.onPrimary,
                              loadingWhen: state.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
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
          ),
        );
      },
    );
  }
}

class _AdminField extends StatefulWidget {
  final String value;
  final Function(String) onChanged;
  final VoidCallback onRemove;
  final bool removable;

  const _AdminField({
    required this.value,
    required this.onChanged,
    required this.onRemove,
    required this.removable,
  });

  @override
  State<_AdminField> createState() => _AdminFieldState();
}

class _AdminFieldState extends State<_AdminField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(_AdminField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: LemonTextField(
              controller: _controller,
              hintText: t.space.lens.adminInputHint,
              onChange: widget.onChanged,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          InkWell(
            onTap: widget.removable ? widget.onRemove : null,
            child: Container(
              width: Sizing.large,
              height: Sizing.large,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.removable
                      ? Colors.transparent
                      : colorScheme.outline,
                ),
                color: widget.removable
                    ? LemonColor.atomicBlack
                    : colorScheme.background,
                borderRadius: BorderRadius.circular(LemonRadius.large * 2),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icClose.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPress;

  const _AddButton({required this.onPress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: onPress,
          child: Container(
            width: Sizing.xLarge,
            height: Sizing.xLarge,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.xLarge),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
