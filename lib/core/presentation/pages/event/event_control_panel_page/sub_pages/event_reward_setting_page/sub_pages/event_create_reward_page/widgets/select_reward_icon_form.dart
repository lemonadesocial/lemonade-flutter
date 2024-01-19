import 'package:app/core/application/event_tickets/modify_reward_bloc/modify_reward_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_reward_setting_page/sub_pages/event_create_reward_page/widgets/rewards_view_model.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/bottomsheet/lemon_snap_bottom_sheet_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectRewardIconForm extends StatefulWidget {
  final Function(String iconUrl) onConfirm;

  const SelectRewardIconForm({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

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
    return BlocProvider(
      create: (context) => ModifyRewardBloc(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LemonSnapBottomSheet(
          defaultSnapSize: 1,
          backgroundColor: LemonColor.atomicBlack,
          resizeToAvoidBottomInset: false,
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonAppBar(
                title: "",
                backgroundColor: LemonColor.atomicBlack,
              ),
              SizedBox(
                height: 0.7.sh,
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
                                        .copyWith(fontWeight: FontWeight.w800),
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
            ],
          ),
          footerBuilder: () => Container(
            color: LemonColor.atomicBlack,
            padding: EdgeInsets.all(Spacing.smMedium),
            child: SafeArea(
              child: LinearGradientButton(
                onTap: () {
                  AutoRouter.of(context).pop();
                  widget.onConfirm(selectedIconUrl);
                },
                height: 42.w,
                radius: BorderRadius.circular(LemonRadius.small * 2),
                mode: GradientButtonMode.lavenderMode,
                label: t.common.confirm,
                textStyle: Typo.medium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
