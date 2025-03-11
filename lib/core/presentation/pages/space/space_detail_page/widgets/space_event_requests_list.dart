import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceEventRequestsList extends StatefulWidget {
  final List<SpaceEventRequest> requests;
  const SpaceEventRequestsList({
    super.key,
    required this.requests,
  });

  @override
  State<SpaceEventRequestsList> createState() => _SpaceEventRequestsListState();
}

class _SpaceEventRequestsListState extends State<SpaceEventRequestsList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.normal),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpanded,
            child: Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.space
                              .pendingEventsApproval(n: widget.requests.length),
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          t.space.eventWillShowAfterApproval,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icArrowDown.svg(
                        colorFilter: filter,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Animated Divider
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.outline,
                ),
                // Animated List
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.requests.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.outline,
                  ),
                  itemBuilder: (context, index) {
                    final request = widget.requests[index];
                    return _EventRequestItem(request: request);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventRequestItem extends StatelessWidget {
  final SpaceEventRequest request;

  const _EventRequestItem({
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final eventData = request.eventExpanded;

    if (eventData == null) {
      return const SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        if (eventData.id == null) {
          return;
        }
        AutoRouter.of(context).push(
          EventDetailRoute(eventId: eventData.id!),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            LemonNetworkImage(
              imageUrl: EventUtils.getEventThumbnailUrl(event: eventData),
              width: 24.w,
              height: 24.w,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              border: Border.all(color: colorScheme.outline),
              placeholder: ImagePlaceholder.eventCard(),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData.title ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
                width: 18.w,
                height: 18.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
