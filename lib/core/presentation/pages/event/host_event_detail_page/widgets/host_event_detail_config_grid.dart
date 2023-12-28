import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/view_model/event_config_grid_view_model.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostEventDetailConfigGrid extends StatelessWidget {
  const HostEventDetailConfigGrid({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final List<EventConfigGridViewModel?> listData = [
      EventConfigGridViewModel(
        title: t.event.configuration.invite,
        subTitle: '12/48 confirmed',
        showProgressBar: true,
        progressBarColors: [
          const Color(0xFFBCF9CE),
          const Color(0xFF68F28F),
        ],
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icUserAddGradient.svg(),
        ),
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.tickets,
        subTitle: '4 ticket types \n\$12.9K total sales',
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icTicketGradient.svg(),
        ),
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.checkIn,
        subTitle: '1.2k checked in',
        showProgressBar: true,
        progressBarColors: [const Color(0xFFF9D3BC), const Color(0xFFF29A68)],
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icCheckin.svg(),
        ),
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.coHosts,
        subTitle: '',
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icHostGradient.svg(),
        ),
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.controlPanel,
        subTitle: t.event.configuration.controlPanelDescription,
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icSettingGradient.svg(),
        ),
      ),
      EventConfigGridViewModel(
        title: t.event.configuration.dashboard,
        subTitle: t.event.configuration.dashboardDescription,
        icon: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icDashboardGradient.svg(),
        ),
      ),
    ];
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.95,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GridItemWidget(
            item: listData[index],
          );
        },
        childCount: listData.length,
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final EventConfigGridViewModel? item;

  const GridItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        top: 1.h,
        left: 1.w,
        right: 1.w,
        bottom: Spacing.superExtraSmall,
      ),
      decoration: ShapeDecoration(
        color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [colorScheme.secondaryContainer, Colors.black],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item?.icon ?? const SizedBox(),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      item?.title ?? '',
                      style: Typo.small.copyWith(
                        fontFamily: FontFamily.nohemiVariable,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  item!.showProgressBar == true
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Container(
                            width: 80.w,
                            height: 2.h,
                            decoration: ShapeDecoration(
                              color: colorScheme.outline,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: -0,
                                  top: 0,
                                  child: Container(
                                    width: 57.w,
                                    height: 2.h,
                                    decoration: ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(1.00, 0.00),
                                        end: const Alignment(-1, 0),
                                        colors: item?.progressBarColors ?? [],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 2.h),
                  SizedBox(
                    child: Text(
                      item?.subTitle ?? '',
                      style: Typo.xSmall.copyWith(
                        fontSize: 9,
                        color: colorScheme.onSecondary,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
