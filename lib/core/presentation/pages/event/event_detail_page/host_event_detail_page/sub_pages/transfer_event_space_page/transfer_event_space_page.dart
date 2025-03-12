import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/transfer_event_space_page/widgets/select_space_to_transfer_dropdown.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TransferEventSpacePage extends StatefulWidget {
  static Future<String?> show(
    BuildContext context, {
    required String spaceId,
  }) {
    return showCupertinoModalBottomSheet<String?>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: LemonColor.atomicBlack,
      builder: (context) => BlocProvider(
        create: (context) => GetSpaceDetailBloc(
          getIt<SpaceRepository>(),
        )..add(
            GetSpaceDetailEvent.fetch(
              spaceId: spaceId,
            ),
          ),
        child: TransferEventSpacePage(spaceId: spaceId),
      ),
    );
  }

  const TransferEventSpacePage({
    super.key,
    required this.spaceId,
  });

  final String spaceId;

  @override
  State<TransferEventSpacePage> createState() => _TransferEventSpacePageState();
}

class _TransferEventSpacePageState extends State<TransferEventSpacePage> {
  String? selectedSpaceId;

  @override
  void initState() {
    super.initState();
    selectedSpaceId = widget.spaceId;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return BlocBuilder<GetSpaceDetailBloc, GetSpaceDetailState>(
      builder: (context, state) {
        final space = state.maybeWhen(
          orElse: () => null,
          success: (space) => space,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: BottomSheetGrabber(),
            ),
            Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LemonNetworkImage(
                    imageUrl: space?.imageAvatar?.url ?? '',
                    width: Sizing.medium,
                    height: Sizing.medium,
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    placeholder: ImagePlaceholder.spaceThumbnail(),
                  ),
                  SizedBox(height: Spacing.small),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.space.transferEventSpace.eventManagedBy,
                        style: Typo.extraMedium.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        space?.title ?? '',
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.medium),
                  Text(
                    t.space.transferEventSpace.whenYouTransferEvent,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.small),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icHostOutline.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Expanded(
                        child: Text(
                          t.space.transferEventSpace
                              .transferEventSpaceDescription1,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.small),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icRefundDollar.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Expanded(
                        child: Text(
                          t.space.transferEventSpace
                              .transferEventSpaceDescription2,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Spacing.medium),
                  SelectSpaceToTransferDropdown(
                    initialSpaceId: null,
                    onChange: (spaceId) {
                      setState(() {
                        selectedSpaceId = spaceId;
                      });
                    },
                  ),
                  SizedBox(height: Spacing.medium),
                  SafeArea(
                    top: false,
                    child: LinearGradientButton.secondaryButton(
                      mode: GradientButtonMode.light,
                      label: t.space.transferEventSpace.transfer,
                      onTap: () {
                        Navigator.pop(context, selectedSpaceId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
