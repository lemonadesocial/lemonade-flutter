import 'dart:async';

import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/shorebird_codepush_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:restart_app/restart_app.dart';

@RoutePage()
class ShorebirdUpdatePage extends StatefulWidget {
  const ShorebirdUpdatePage({Key? key}) : super(key: key);

  @override
  State<ShorebirdUpdatePage> createState() => _ShorebirdUpdatePageState();
}

class _ShorebirdUpdatePageState extends State<ShorebirdUpdatePage>
    with TickerProviderStateMixin {
  double value = 0;
  bool isDownloading = false;
  bool isDownloaded = false;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return WillPopScope(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(image: Assets.images.bgCircle.provider()),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  heightFactor: 0.25,
                  child: Image(
                    image: Assets.images.icComingSoon.provider(),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.common.shorebird_update_title,
                      textAlign: TextAlign.center,
                      style: Typo.large.copyWith(
                        color: colorScheme.onPrimary,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: FontFamily.spaceGrotesk,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      t.common.shorebird_update_description,
                      textAlign: TextAlign.center,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 42.h),
                    _buildButton(context),
                    SizedBox(height: 42.h),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onWillPop: () async => false,
    );
  }

  Widget _buildButton(BuildContext context) {
    final t = Translations.of(context);
    if (isDownloaded) {
      return LinearGradientButton(
        label: t.common.restart,
        mode: GradientButtonMode.lavenderMode,
        height: 48.h,
        radius: BorderRadius.circular(24),
        textStyle: Typo.medium.copyWith(),
        onTap: () {
          Vibrate.feedback(FeedbackType.light);
          Restart.restartApp();
        },
      );
    }
    if (isDownloading) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 10.h,
          child: LinearProgressIndicator(
            value: controller.value,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            backgroundColor: const Color(0xFFFFDAB8),
            minHeight: 10.h,
          ),
        ),
      );
    }
    return LinearGradientButton(
      label: t.common.update_now,
      mode: GradientButtonMode.lavenderMode,
      height: 48.h,
      radius: BorderRadius.circular(24),
      textStyle: Typo.medium.copyWith(),
      onTap: () => onPressUpdateNow(),
    );
  }

  void onPressUpdateNow() async {
    Vibrate.feedback(FeedbackType.light);
    await getIt<ShorebirdCodePushService>().downloadUpdateIfAvailable();
    value = 0;
    downloadData();
    setState(() {
      isDownloading = true;
    });
  }

  void downloadData() {
    debugPrint("downloadData");
    // Running 40 seconds
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      bool isNewPatchReadyToInstall =
          await getIt<ShorebirdCodePushService>().isNewPatchReadyToInstall();
      debugPrint("isNewPatchReadyToInstall : $isNewPatchReadyToInstall");
      if (isNewPatchReadyToInstall == true) {
        controller.duration = const Duration(milliseconds: 1000);
        controller.animateTo(1);
        await Future.wait(
          [Future<void>.delayed(const Duration(milliseconds: 1000))],
        );
        setState(() {
          timer.cancel();
          value = 1;
          isDownloaded = true;
        });
        return;
      }
      setState(() {
        if (value == 1) {
          timer.cancel();
        } else {
          value = value + 0.025;
        }
      });
    });
  }
}
