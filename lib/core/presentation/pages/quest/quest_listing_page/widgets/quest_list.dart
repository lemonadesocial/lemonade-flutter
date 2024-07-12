import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/domain/quest/entities/point_config_info.dart';
import 'package:app/core/domain/quest/quest_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/quest/widgets/quest_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestList extends StatelessWidget {
  const QuestList({super.key});

  Future<Either<Failure, List<PointConfigInfo>>> getMyPoints({
    required String? firstLevelGroup,
    required String? secondLevelGroup,
  }) async {
    return getIt<QuestRepository>().getMyPoints(
      firstLevelGroup: firstLevelGroup,
      secondLevelGroup: secondLevelGroup,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<GetPointGroupsBloc, GetPointGroupsState>(
      builder: (context, state) {
        final selectedFirstLevelGroup = state.selectedFirstLevelGroup;
        final selectedSecondaryGroup = state.selectedSecondLevelGroup;
        return FutureBuilder<List<PointConfigInfo>>(
          future: getMyPoints(
            firstLevelGroup: selectedFirstLevelGroup,
            secondLevelGroup: selectedSecondaryGroup,
          ).then(
            (either) => either.fold(
              (failure) => [],
              (myPoints) => myPoints,
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError) {
              return const SliverToBoxAdapter(
                child: EmptyList(),
              );
            }

            List<PointConfigInfo> pointConfigInfos = snapshot.data ?? [];

            if (pointConfigInfos.isEmpty) {
              return const SliverToBoxAdapter(
                child: EmptyList(),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.small,
              ),
              sliver: SliverList.separated(
                itemCount: pointConfigInfos.length,
                itemBuilder: (context, index) {
                  final pointConfigInfo = pointConfigInfos[index];
                  final points = (pointConfigInfo.points ?? 0).toInt();
                  final repeatable = pointConfigInfo.firstTimeOnly == null ||
                      pointConfigInfo.firstTimeOnly == false;
                  final trackingCount = pointConfigInfo.trackings?.length;
                  return QuestItemWidget(
                    title: t.quest.pointsCount(n: points, count: points),
                    subTitle: pointConfigInfo.title ?? '',
                    onTap: () {},
                    repeatable: repeatable,
                    trackingCount: trackingCount,
                  );
                },
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.xSmall),
              ),
            );
          },
        );
      },
    );
  }
}
