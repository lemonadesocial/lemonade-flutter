import 'package:app/core/application/event/scan_qr_code_bloc/scan_qr_code_bloc.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ClaimRewardsPage extends StatelessWidget {
  const ClaimRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.rewards,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: const SizedBox.shrink(),
              collapsedHeight: kToolbarHeight,
              pinned: true,
              flexibleSpace: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ScanQRCodeBloc, ScanQRCodeState>(
                    builder: (context, state) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                        child: Text(
                          state.scannedUserDetail?.name ?? '',
                          style: Typo.large.copyWith(
                            color: colorScheme.onPrimary,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: FontFamily.nohemiVariable,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, sectionIndex) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Section $sectionIndex'),
                      ),
                      const HorizontalListWidget(),
                    ],
                  );
                },
                childCount: 5,
              ),
            ),
          ],
        ),
        // child: CustomScrollView(
        //   physics: const BouncingScrollPhysics(),
        //   slivers: [],
        // ),
      ),
    );
  }
}

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Replace with your actual number of items
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: SizedBox(
              width: 80,
              child: Center(
                child: Text('Item $index'),
              ),
            ),
          );
        },
      ),
    );
  }
}
