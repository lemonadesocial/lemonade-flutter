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

class QuestList extends StatelessWidget {
  const QuestList({super.key});

  Future<Either<Failure, List<PointConfigInfo>>> getMyPoints() async {
    return getIt<QuestRepository>()
        .getMyPoints(firstLevelGroup: null, secondLevelGroup: null);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return FutureBuilder<List<PointConfigInfo>>(
      future: getMyPoints().then(
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
                title: t.quest.pointCount(count: points),
                // TODO: Whenever backend ready, we change it to title
                subTitle: pointConfigInfo.type?.toString() ?? '',
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
  }
}
