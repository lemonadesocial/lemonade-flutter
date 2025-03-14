import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/space/query/get_space.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventSubmittingToSpaceCard extends StatelessWidget {
  final String? submittingToSpaceId;
  const CreateEventSubmittingToSpaceCard({super.key, this.submittingToSpaceId});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (submittingToSpaceId == null) {
      return const SizedBox.shrink();
    }
    return BlocBuilder<CreateEventBloc, CreateEventState>(
      builder: (context, state) {
        return Query$GetSpace$Widget(
          options: Options$Query$GetSpace(
            variables: Variables$Query$GetSpace(
              id: submittingToSpaceId!,
            ),
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.isLoading) {
              return Loading.defaultLoading(context);
            }

            if (result.hasException || result.parsedData == null) {
              return const SizedBox.shrink();
            }

            final space = result.parsedData!.getSpace;
            if (space == null) {
              return const SizedBox.shrink();
            }

            final colorScheme = Theme.of(context).colorScheme;

            return Container(
              margin: EdgeInsets.only(
                top: Spacing.xSmall,
                left: Spacing.small,
                right: Spacing.small,
              ),
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: LemonColor.chineseBlack,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              child: Row(
                children: [
                  LemonNetworkImage(
                    imageUrl: space.image_avatar_expanded?.url ?? '',
                    width: Sizing.medium,
                    height: Sizing.medium,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    placeholder: ImagePlaceholder.avatarPlaceholder(),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.space.submittingTo,
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          space.title,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<CreateEventBloc>().add(
                            const CreateEventEvent
                                .createEventSubmittingToSpaceIdChanged(
                              spaceId: null,
                            ),
                          );
                    },
                    child: ThemeSvgIcon(
                      color: colorScheme.onSurface,
                      builder: (filter) => Assets.icons.icClose.svg(
                        colorFilter: filter,
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
