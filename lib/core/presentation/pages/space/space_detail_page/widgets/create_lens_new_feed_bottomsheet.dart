import 'package:app/core/application/lens/create_lens_feed_bloc/create_lens_feed_bloc.dart';
import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/application/lens/login_lens_account_bloc/login_lens_account_bloc.dart';
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
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateLensNewFeedBottomSheet extends StatelessWidget {
  final Space space;
  final VoidCallback onSuccess;

  const CreateLensNewFeedBottomSheet({
    super.key,
    required this.space,
    required this.onSuccess,
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
      child: _View(space: space, onSuccess: onSuccess),
    );
  }
}

class _View extends StatefulWidget {
  final Space space;
  final VoidCallback onSuccess;

  const _View({required this.space, required this.onSuccess});

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
    _initializeAdmins();
  }

  Future<void> _initializeAdmins() async {
    final lensState = context.read<LensAuthBloc>().state;
    // Get the wallet address immediately when the sheet opens
    final ownerAddress =
        (await getIt<WalletConnectService>().getActiveSession())?.address;

    if (ownerAddress != null && lensState.availableAccounts.isNotEmpty) {
      final adminAndOwner = <String>{
        ownerAddress,
        ...(AppConfig.lensLemonadeAdminAddresses),
      }.toList();

      setState(() {
        _admins = adminAndOwner;
        _adminController.text = adminAndOwner.join(', ');
      });
    }
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

    // Use the new switching mechanism
    context.read<LensAuthBloc>().add(
          const LensAuthEvent.switchAccount(
            targetStatus: LensAccountStatus.accountOwner,
          ),
        );
  }

  bool get _isFormValid => _nameController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, lensState) {
        return MultiBlocListener(
          listeners: [
            BlocListener<LensAuthBloc, LensAuthState>(
              listener: (context, state) {
                if (state.loggedIn &&
                    state.accountStatus == LensAccountStatus.accountOwner) {
                  Navigator.of(context).pop(true);
                  widget.onSuccess();
                } else if (!state.loggedIn && !state.isFetching) {
                  Navigator.of(context).pop();
                }
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
                    title: '',
                    backgroundColor: LemonColor.atomicBlack,
                    onPressBack: () {
                      reloginToAccountOwner(context);
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.lens.setUpYourTimeline,
                                  style: Typo.large.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontSize: 24.sp,
                                  ),
                                ),
                                SizedBox(height: Spacing.extraSmall),
                                Text(
                                  t.lens.fillInTheDetailsBelowToCompleteSetup,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(height: Spacing.medium),
                                // Name field
                                Text(
                                  t.lens.nameOfTheFeed,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: Spacing.extraSmall),
                                LemonTextField(
                                  controller: _nameController,
                                  hintText: t.lens.nameOfTheFeed,
                                  onChange: (_) => setState(() {}),
                                ),
                                SizedBox(height: Spacing.smMedium),
                                // Description field
                                Text(
                                  t.lens.description,
                                  style: Typo.medium.copyWith(
                                    color: colorScheme.onSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: Spacing.extraSmall),
                                LemonTextField(
                                  controller: _descriptionController,
                                  hintText: t.lens.description,
                                  maxLines: 5,
                                  minLines: 5,
                                  inputHeight: 120.w,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Spacing.smMedium,
                            ),
                            child: Divider(
                              color: colorScheme.outline,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.smMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            t.lens.admins,
                                            style: Typo.mediumPlus.copyWith(
                                              color: colorScheme.onPrimary,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(height: 2.w),
                                          Text(
                                            t.lens.defineRulesForYourFeed,
                                            style: Typo.medium.copyWith(
                                              color: colorScheme.onSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _AddButton(onPress: _addNewAdmin),
                                  ],
                                ),
                                SizedBox(height: Spacing.medium),
                                ..._admins.asMap().entries.map(
                                      (entry) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: Spacing.small,
                                        ),
                                        child: _AdminField(
                                          value: entry.value,
                                          onChanged: (value) =>
                                              _updateAdmin(entry.key, value),
                                          onRemove: () =>
                                              _removeAdmin(entry.key),
                                          removable: _admins.length > 1,
                                        ),
                                      ),
                                    ),
                              ],
                            ),
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55.w,
            decoration: BoxDecoration(
              color: LemonColor.white06,
              border: Border.all(color: LemonColor.white03),
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Spacing.small),
                  child: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icWalletLine.svg(
                      width: Sizing.small,
                      height: Sizing.small,
                      colorFilter: colorFilter,
                    ),
                  ),
                ),
                Expanded(
                  child: LemonTextField(
                    inputHeight: 50.w,
                    controller: _controller,
                    hintText: t.lens.walletAddress,
                    placeholderStyle: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                    onChange: widget.onChanged,
                    borderColor: Colors.transparent,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.removable)
          InkWell(
            onTap: widget.onRemove,
            child: Container(
              width: 50.w,
              height: 50.w,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: LemonColor.white06,
                border: Border.all(color: LemonColor.white03),
                borderRadius: BorderRadius.circular(LemonRadius.small),
              ),
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icClose.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    colorFilter: colorFilter,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onPress;

  const _AddButton({required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: LemonColor.white06,
          border: Border.all(color: LemonColor.white03),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Center(
          child: ThemeSvgIcon(
            builder: (colorFilter) => Assets.icons.icPlus.svg(
              width: Sizing.mSmall,
              height: Sizing.mSmall,
            ),
          ),
        ),
      ),
    );
  }
}
