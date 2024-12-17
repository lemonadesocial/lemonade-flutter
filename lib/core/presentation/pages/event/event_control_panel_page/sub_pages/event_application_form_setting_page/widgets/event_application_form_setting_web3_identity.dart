import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
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

class _IdentityItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
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
          icon,
          SizedBox(width: Spacing.small),
          Text(
            label,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton2<int>(
              value: isOff
                  ? -1
                  : isRequired
                      ? 1
                      : 0,
              onChanged: (value) {
                onChange.call(value ?? 0);
              },
              customButton: Row(
                children: [
                  Text(
                    isOff
                        ? t.event.applicationForm.off
                        : isRequired
                            ? t.event.applicationForm.required
                            : t.event.applicationForm.optional,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
                      colorFilter: filter,
                    ),
                  ),
                ],
              ),
              items: [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text(
                    t.event.applicationForm.required,
                  ),
                ),
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text(
                    t.event.applicationForm.optional,
                  ),
                ),
                DropdownMenuItem<int>(
                  value: -1,
                  child: Text(
                    t.event.applicationForm.off,
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
              menuItemStyleData: const MenuItemStyleData(
                overlayColor: MaterialStatePropertyAll(
                  LemonColor.darkBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
