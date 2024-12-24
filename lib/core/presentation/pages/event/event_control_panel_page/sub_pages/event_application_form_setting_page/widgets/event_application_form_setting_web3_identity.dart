import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:collection/collection.dart';

class EventApplicationFormSettingWeb3Identity extends StatefulWidget {
  const EventApplicationFormSettingWeb3Identity({
    super.key,
  });

  @override
  State<EventApplicationFormSettingWeb3Identity> createState() =>
      _EventApplicationFormSettingWeb3IdentityState();
}

class _EventApplicationFormSettingWeb3IdentityState
    extends State<EventApplicationFormSettingWeb3Identity> {
  Future<void> _updateWeb3Identity({
    required Enum$BlockchainPlatform platform,
    required int action,
    Event? event,
  }) async {
    List<Input$ApplicationBlokchainPlatformInput> currentPlatformsInput =
        (event?.rsvpWalletPlatforms ?? [])
            .map(
              (e) => Input$ApplicationBlokchainPlatformInput(
                platform: e.platform!,
                required: e.isRequired,
              ),
            )
            .toList();
    final hasPlatform =
        currentPlatformsInput.any((e) => e.platform == platform);

    // field is required
    if (action == 1) {
      if (hasPlatform) {
        currentPlatformsInput = currentPlatformsInput
            .map((e) => e.platform == platform ? e.copyWith(required: true) : e)
            .toList();
      } else {
        currentPlatformsInput.add(
          Input$ApplicationBlokchainPlatformInput(
            platform: platform,
            required: true,
          ),
        );
      }
    }
    // field is optional
    if (action == 0) {
      if (hasPlatform) {
        currentPlatformsInput = currentPlatformsInput
            .map(
              (e) => e.platform == platform ? e.copyWith(required: false) : e,
            )
            .toList();
      } else {
        currentPlatformsInput.add(
          Input$ApplicationBlokchainPlatformInput(
            platform: platform,
            required: false,
          ),
        );
      }
    }
    // field is off
    if (action == -1) {
      currentPlatformsInput.removeWhere((e) => e.platform == platform);
    }

    final result = await getIt<EventRepository>().updateEvent(
      id: event?.id ?? '',
      input: Input$EventInput(
        rsvp_wallet_platforms: currentPlatformsInput,
      ),
    );
    if (result.isLeft()) return;
    SnackBarUtils.showSuccess(
      message: t.event.applicationForm.updateApplicationFormSuccessfully,
    );
    context.read<GetEventDetailBloc>().add(
          GetEventDetailEvent.fetch(
            eventId: event?.id ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final ethereumPlatform = event?.rsvpWalletPlatforms?.firstWhereOrNull(
      (element) => element.platform == Enum$BlockchainPlatform.ethereum,
    );

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            t.event.applicationForm.web3Identity.web3IdentityTitle,
            style: Typo.extraMedium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.small,
          ),
        ),
        SliverToBoxAdapter(
          child: _IdentityItem(
            blockChainPlatform: Enum$BlockchainPlatform.ethereum,
            label: t.event.applicationForm.web3Identity.ethAddress,
            icon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCurrencyEth.svg(
                colorFilter: filter,
              ),
            ),
            isRequired: ethereumPlatform?.isRequired ?? false,
            isOff: ethereumPlatform == null,
            onChange: (value) {
              _updateWeb3Identity(
                platform: Enum$BlockchainPlatform.ethereum,
                action: value,
                event: event,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _IdentityItem extends StatefulWidget {
  final Enum$BlockchainPlatform blockChainPlatform;
  final String label;
  final Widget icon;
  final bool isRequired;
  final bool isOff;
  final Function(int) onChange;

  const _IdentityItem({
    required this.blockChainPlatform,
    required this.label,
    required this.icon,
    required this.isRequired,
    required this.isOff,
    required this.onChange,
  });

  @override
  State<_IdentityItem> createState() => _IdentityItemState();
}

class _IdentityItemState extends State<_IdentityItem> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<GetEventDetailBloc, GetEventDetailState>(
      listener: (context, state) {
        if (state is GetEventDetailStateFetched) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          color: LemonColor.atomicBlack,
          border: Border.all(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            widget.icon,
            SizedBox(width: Spacing.small),
            Text(
              widget.label,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            const Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                value: widget.isOff
                    ? -1
                    : widget.isRequired
                        ? 1
                        : 0,
                onChanged: (value) {
                  if (value == -2) {
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });
                  widget.onChange.call(value ?? 0);
                },
                customButton: Row(
                  children: [
                    if (isLoading) Loading.defaultLoading(context),
                    if (!isLoading) ...[
                      Text(
                        widget.isOff
                            ? t.event.applicationForm.off
                            : widget.isRequired
                                ? t.event.applicationForm.required
                                : t.event.applicationForm.optional,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) =>
                            Assets.icons.icDoubleArrowUpDown.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ],
                  ],
                ),
                items: isLoading
                    ? []
                    : [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.small,
                            ),
                            child: Text(
                              t.event.applicationForm.required,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.small,
                            ),
                            child: Text(
                              t.event.applicationForm.optional,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: -1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.small,
                            ),
                            child: Text(
                              t.event.applicationForm.off,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: -2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                color: colorScheme.outline,
                                thickness: 1.w,
                                height: 1.w,
                              ),
                              SizedBox(height: Spacing.xSmall),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: Spacing.small),
                                  ThemeSvgIcon(
                                    color: colorScheme.onSecondary,
                                    builder: (filter) =>
                                        Assets.icons.icInfo.svg(
                                      colorFilter: filter,
                                      width: 16.w,
                                      height: 16.w,
                                    ),
                                  ),
                                  SizedBox(width: Spacing.xSmall),
                                  Flexible(
                                    child: Text(
                                      t.event.applicationForm.web3Identity
                                          .web3IdentityDescription,
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                dropdownStyleData: DropdownStyleData(
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(LemonRadius.small),
                    color: colorScheme.secondaryContainer,
                  ),
                  offset: Offset(0, -Spacing.superExtraSmall),
                ),
                menuItemStyleData: MenuItemStyleData(
                  padding: EdgeInsets.zero,
                  overlayColor: const MaterialStatePropertyAll(
                    LemonColor.darkBackground,
                  ),
                  selectedMenuItemBuilder: (context, child) => Row(
                    children: [
                      child,
                      const Spacer(),
                      ThemeSvgIcon(
                        color: colorScheme.onPrimary,
                        builder: (filter) => Assets.icons.icDone.svg(
                          colorFilter: filter,
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                    ],
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
