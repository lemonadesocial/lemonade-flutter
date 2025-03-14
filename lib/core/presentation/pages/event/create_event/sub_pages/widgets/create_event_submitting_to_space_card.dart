import 'package:app/core/application/event/create_event_bloc/create_event_bloc.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/space/query/get_space.graphql.dart';
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
              margin: EdgeInsets.all(Spacing.small),
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Row(
                children: [
                  LemonNetworkImage(
                    imageUrl: space.image_avatar_expanded?.url ?? '',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(LemonRadius.normal),
                    placeholder: ImagePlaceholder.avatarPlaceholder(),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Submitting to',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          space.title,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onSurface,
                      size: 20,
                    ),
                    onPressed: () {
                      context.read<CreateEventBloc>().add(
                            const CreateEventEvent
                                .createEventSubmittingToSpaceIdChanged(
                              spaceId: null,
                            ),
                          );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
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
