import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_spotlight_events/widgets/collaborator_add_sppotlight_events_bottomsheet/collaborator_add_sppotlight_events_bottomsheet.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/remove_icon_wrapper.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorEditSpotlightEvents extends StatelessWidget {
  const CollaboratorEditSpotlightEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final spotlightEvents = loggedInUser?.eventsExpanded ?? [];
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            StringUtils.capitalize(t.collaborator.editProfile.spotlightEvents),
            style: appText.md,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        SliverPadding(
          padding: EdgeInsets.only(right: Spacing.superExtraSmall),
          sliver: SliverGrid.builder(
            itemCount: spotlightEvents.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: Spacing.xSmall,
              crossAxisSpacing: Spacing.xSmall,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () => showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    backgroundColor: appColors.pageBg,
                    builder: (mContext) =>
                        const CollaboratorAddSpotlightEventBottomSheet(),
                  ),
                  child: DottedBorder(
                    color: appColors.pageDivider,
                    borderType: BorderType.RRect,
                    dashPattern: [6.w, 6.w],
                    strokeWidth: 2.w,
                    radius: Radius.circular(LemonRadius.medium),
                    child: Center(
                      child: ThemeSvgIcon(
                        color: appColors.textTertiary,
                        builder: (filter) => Assets.icons.icAdd.svg(
                          colorFilter: filter,
                        ),
                      ),
                    ),
                  ),
                );
              }
              final event = spotlightEvents[index - 1];
              return _SpotlightItem(
                event: event,
                onTapRemove: () async {
                  List<Event> newSpotlightEvents = List.from(spotlightEvents);
                  newSpotlightEvents
                      .removeWhere((element) => element.id == event.id);
                  List<String> newSpotlightEventsIds =
                      newSpotlightEvents.map((e) => e.id ?? '').toList();
                  await showFutureLoadingDialog(
                    context: context,
                    future: () {
                      return getIt<UserRepository>().updateUser(
                        input: Input$UserInput(
                          events: newSpotlightEventsIds,
                        ),
                      );
                    },
                  );
                  context.read<AuthBloc>().add(const AuthEvent.refreshData());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SpotlightItem extends StatelessWidget {
  final Event? event;
  final Function()? onTapRemove;
  const _SpotlightItem({required this.event, required this.onTapRemove});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: appColors.pageDivider,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
      ),
      child: RemoveIconWrapper(
        onTap: () async {
          onTapRemove?.call();
        },
        child: Stack(
          children: [
            LemonNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              imageUrl: ImageUtils.generateUrl(
                file: event?.newNewPhotosExpanded?.firstOrNull,
                imageConfig: ImageConfig.eventPhoto,
              ),
              border: Border.all(color: appColors.pageDivider),
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              placeholder: ImagePlaceholder.eventCard(),
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                  vertical: Spacing.xSmall,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event?.title ?? '',
                      style: appText.sm.copyWith(
                        color: appColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormatUtils.dateWithTimezone(
                        dateTime: event?.start ?? DateTime.now(),
                        timezone: event?.timezone ?? '',
                        pattern: DateFormatUtils.dateOnlyFormat,
                      ),
                      style: appText.xs.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
