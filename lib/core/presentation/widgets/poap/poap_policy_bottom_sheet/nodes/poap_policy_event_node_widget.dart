import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_event_detail_input.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoapPolicyEventNodeWidget extends StatelessWidget {
  const PoapPolicyEventNodeWidget({
    super.key,
    required this.node,
    required this.result,
  });

  final PoapPolicyNode node;
  final bool result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final eventId = node.children?[0].value ?? '';

    return FutureBuilder(
      future: getIt<EventRepository>()
          .getEventDetail(input: GetEventDetailInput(id: eventId)),
      builder: (context, snapshot) {
        final event = snapshot.data?.fold((l) => null, (event) => event);
        return InkWell(
          onTap: () {
            AutoRouter.of(context).navigate(
              EventDetailRoute(eventId: event?.id ?? ''),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Sizing.medium,
                height: Sizing.medium,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  child: CachedNetworkImage(
                    imageUrl: event != null
                        ? EventUtils.getEventThumbnailUrl(event: event)
                        : "",
                    placeholder: (_, __) =>
                        ImagePlaceholder.defaultPlaceholder(),
                    errorWidget: (_, __, ___) =>
                        ImagePlaceholder.defaultPlaceholder(),
                  ),
                ),
              ),
              SizedBox(width: Spacing.xSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.nft.poapPolicy.eventPolicy
                        .title(event: event?.title ?? ''),
                    style: Typo.small.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    !result
                        ? t.nft.poapPolicy.eventPolicy.nonQualified
                        : t.nft.poapPolicy.eventPolicy.qualified,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              if (result) ...[
                const Spacer(),
                Assets.icons.icInvitedFilled.svg(),
              ],
            ],
          ),
        );
      },
    );
  }
}
