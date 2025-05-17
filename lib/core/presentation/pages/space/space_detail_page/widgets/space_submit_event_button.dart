import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/space/pin_existing_event_to_space_page/pin_existing_event_to_space_page.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/pin_event_options_bottomsheet.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceSubmitEventButton extends StatelessWidget {
  final Space space;
  // final Function(SpaceTag?) onTagChange;
  // final Function(SpaceTag?) onRefresh;

  const SpaceSubmitEventButton({
    super.key,
    required this.space,
    // required this.onTagChange,
    // required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;

    final userId = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user.userId,
        );

    return InkWell(
      onTap: () async {
        final spaceDetailBloc = context.read<GetSpaceDetailBloc>();
        final option = await showCupertinoModalBottomSheet<PinEventOptions>(
          context: context,
          backgroundColor: LemonColor.atomicBlack,
          barrierColor: Colors.black.withOpacity(0.5),
          expand: false,
          builder: (innerContext) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: spaceDetailBloc,
              ),
            ],
            child: const PinEventOptionsBottomsheet(),
          ),
        );
        if (option == PinEventOptions.newEvent) {
          // Allow create event if space is admin or ambassador
          if (space.isAdmin(userId: userId ?? '') ||
              space.isAmbassador == true) {
            await AutoRouter.of(context).push(
              CreateEventRoute(
                spaceId: space.id,
              ),
            );
          }
          // Otherwise, need submit to space
          else {
            await AutoRouter.of(context).push(
              CreateEventRoute(
                spaceId: null,
                submittingToSpaceId: space.id,
              ),
            );
          }
        }
        if (option == PinEventOptions.existingEvent) {
          final value = await PinExistingEventToSpacePage.show(
            context,
            space: space,
          );
          if (value != null) {
            // refetch?.call();
            // onRefresh(value);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.full),
          color: appColors.buttonSecondaryBg,
        ),
        width: Sizing.s14,
        height: Sizing.s14,
        child: Center(
          child: ThemeSvgIcon(
            color: appColors.buttonSecondary,
            builder: (colorFilter) => Assets.icons.icAdd.svg(
              height: Sizing.s8,
              width: Sizing.s8,
              colorFilter: colorFilter,
            ),
          ),
        ),
      ),
    );
  }
}
