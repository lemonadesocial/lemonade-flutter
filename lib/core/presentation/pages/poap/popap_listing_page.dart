import 'package:app/core/presentation/pages/poap/popap_detail_page.dart';
import 'package:app/core/presentation/pages/poap/views/popap_filter_bottom_sheet_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_claim_item.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PoapListingPage extends StatelessWidget {
  PoapListingPage({super.key});

  final DraggableScrollableController dragController = DraggableScrollableController();
  final List<double> snapSizes = [.2, .77, 1];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.extraSmall,
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: SizedBox.shrink(),
                  expandedHeight: 60,
                  collapsedHeight: 60,
                  floating: true,
                  flexibleSpace: LemonAppBar(
                    title: StringUtils.capitalize(t.nft.badges),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          dragController.animateTo(
                            snapSizes[1],
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                        child: Assets.icons.icFilterOutline.svg(),
                      ),
                    ],
                  ),
                ),
                SliverList.separated(
                  itemCount: 30,
                  separatorBuilder: (context, i) => SizedBox(height: 12),
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      BottomSheetUtils.showSnapBottomSheet(
                        context,
                        builder: (context) => PopapDetailPage(),
                      );
                    },
                    child: POAPClaimItem(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                )
              ],
            ),
            SafeArea(
              bottom: false,
              child: PoapFilterBottomSheetView(
                dragController: dragController,
                snapSizes: snapSizes,
              ),
            )
          ],
        ),
      ),
    );
  }
}
