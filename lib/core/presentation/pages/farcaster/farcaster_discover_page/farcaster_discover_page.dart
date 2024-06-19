import 'package:app/core/presentation/pages/farcaster/farcaster_discover_page/widgets/farcaster_discover_users_tab.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_discover_page/widgets/farcaster_disocver_channels_tab.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FarcasterDiscoverPage extends StatefulWidget {
  const FarcasterDiscoverPage({super.key});

  @override
  State<FarcasterDiscoverPage> createState() => _FarcasterDiscoverPageState();
}

class _FarcasterDiscoverPageState extends State<FarcasterDiscoverPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _textController.clear();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    final t = Translations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.xSmall,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const LemonBackButton(),
                  SizedBox(width: Spacing.extraSmall),
                  Expanded(
                    child: SizedBox(
                      height: Sizing.medium,
                      child: TextField(
                        controller: _textController,
                        onChanged: (v) {},
                        cursorColor: colorScheme.onSecondary,
                        decoration: InputDecoration(
                          fillColor: LemonColor.atomicBlack,
                          hintStyle: Typo.medium.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText: StringUtils.capitalize(t.common.search),
                          filled: true,
                          isDense: true,
                          enabledBorder: border,
                          focusedBorder: border,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ThemeSvgIcon(
                                color: colorScheme.onSecondary,
                                builder: (filter) => Assets.icons.icSearch.svg(
                                  colorFilter: filter,
                                  width: Sizing.mSmall,
                                  height: Sizing.mSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelStyle: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(text: t.farcaster.discover.discoverTabs.users),
                Tab(text: t.farcaster.discover.discoverTabs.channels),
              ],
              indicatorColor: LemonColor.paleViolet,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FarcasterDiscoverUsersTab(
                    textController: _textController,
                  ),
                  FarcasterDiscoverChannelsTab(
                    textController: _textController,
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
