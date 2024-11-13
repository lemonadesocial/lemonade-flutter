import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/rewards_view_model.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SelectRewardIconForm extends StatefulWidget {
  final Function(String iconUrl) onConfirm;
  final Reward? initialReward;

  const SelectRewardIconForm({
    super.key,
    required this.onConfirm,
    this.initialReward,
  });

  @override
  SelectRewardIconFormState createState() => SelectRewardIconFormState();
}

class SelectRewardIconFormState extends State<SelectRewardIconForm> {
  late String selectedIconUrl;

  @override
  void initState() {
    super.initState();
    selectedIconUrl = '';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LemonAppBar(
            backgroundColor: LemonColor.atomicBlack,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: RewardViewModel.staticRewards.length,
                  itemBuilder: (context, index) {
                    final reward = RewardViewModel.staticRewards[index];
                    final fullIconUrl =
                        '${AppConfig.assetPrefix}${reward.icon}';
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIconUrl = reward.icon;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.smMedium,
                          vertical: Spacing.extraSmall,
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: fullIconUrl,
                            ),
                            SizedBox(width: Spacing.smMedium),
                            Expanded(
                              child: Text(
                                reward.name,
                                style: Typo.mediumPlus
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                            ),
                            selectedIconUrl == reward.icon
                                ? Assets.icons.icChecked.svg()
                                : Assets.icons.icUncheck.svg(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            color: LemonColor.atomicBlack,
            padding: EdgeInsets.all(Spacing.smMedium),
            child: SafeArea(
              child: LinearGradientButton.primaryButton(
                onTap: () {
                  AutoRouter.of(context).pop();
                  widget.onConfirm(selectedIconUrl);
                },
                label: t.common.confirm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
