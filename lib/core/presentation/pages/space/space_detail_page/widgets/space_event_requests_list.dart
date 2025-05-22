import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(
          LemonRadius.md,
        ),
        border: Border.all(color: appColors.cardBorder),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpanded,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: appColors.cardBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(LemonRadius.md),
                  topRight: Radius.circular(LemonRadius.md),
                  bottomLeft: _isExpanded
                      ? Radius.zero
                      : Radius.circular(LemonRadius.md),
                  bottomRight: _isExpanded
                      ? Radius.zero
                      : Radius.circular(LemonRadius.md),
                ),
              ),
              padding: EdgeInsets.all(Spacing.s2_5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.space
                              .pendingEventsApproval(n: widget.requests.length),
                          style: appText.md,
                        ),
                      ],
                    ),
                  ),
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icArrowDown.svg(
                        colorFilter: filter,
                        width: Sizing.s5,
                        height: Sizing.s5,
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
                  color: appColors.pageDivider,
                ),
                // Animated List
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.requests.length,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.s3),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: appColors.pageDivider,
                    ),
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
    final appText = context.theme.appTextTheme;
    final appColors = context.theme.appColors;
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
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.s3,
          vertical: Spacing.s2_5,
        ),
        child: Expanded(
          child: Text(
            eventData.title ?? '',
            style: appText.md.copyWith(
              color: appColors.textTertiary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
