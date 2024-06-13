import 'package:app/core/config.dart';
import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FarcasterFrameWidget extends StatefulWidget {
  final AirstackFrame initialFrame;
  const FarcasterFrameWidget({
    super.key,
    required this.initialFrame,
  });

  @override
  State<FarcasterFrameWidget> createState() => _FarcasterFrameWidgetState();
}

class _FarcasterFrameWidgetState extends State<FarcasterFrameWidget> {
  late AirstackFrame currentFrame;
  bool frameLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentFrame = widget.initialFrame;
    });
  }

  Future<void> getNextFrame({required String targetUrl}) async {
    setState(() {
      frameLoading = true;
    });
    final result = await getIt<FarcasterRepository>().getNextFrame(
      targetUrl: targetUrl,
    );
    result.fold(
      (l) {},
      (newFrame) {
        setState(() {
          currentFrame = newFrame;
        });
      },
    );
    setState(() {
      frameLoading = false;
    });
  }

  Future<void> handleLinkTap(String url) async {
    final eventRegex = RegExp('${AppConfig.webUrl}/event/?([^/]*)');
    final match = eventRegex.firstMatch(url);
    final eventId = match?.group(1);
    if (eventId != null) {
      AutoRouter.of(context).push(EventDetailRoute(eventId: eventId));
    } else {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void handleFrameButtonTap(AirstackFrameButton button) async {
    final t = Translations.of(context);
    if (button.action == AirstackFrameButtonAction.unknown ||
        button.target?.isEmpty == true) {
      SnackBarUtils.showError(message: t.farcaster.frame.loadFrameError);
      return;
    }

    if (button.action == AirstackFrameButtonAction.link) {
      await handleLinkTap(button.target ?? '');
      return;
    }
    if (button.action == AirstackFrameButtonAction.post) {
      await getNextFrame(targetUrl: button.target ?? '');
      return;
    }
    //TODO: handle other actions like postRedirect, tx, mint;
    SnackBarUtils.showComingSoon();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(
        minHeight: 205.w,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(
          LemonRadius.small,
        ),
        border: Border.all(
          color: colorScheme.outline,
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {},
                child: LemonNetworkImage(
                  width: double.infinity,
                  height: 160.w,
                  imageUrl: currentFrame.imageUrl ?? '',
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(LemonRadius.small),
                    topLeft: Radius.circular(LemonRadius.small),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Spacing.superExtraSmall),
                child: Row(
                  children: (currentFrame.buttons ?? []).asMap().entries.map(
                    (entry) {
                      final isLast =
                          entry.key == (currentFrame.buttons ?? []).length - 1;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: isLast ? 0 : 3.w,
                          ),
                          child: Column(
                            children: [
                              LemonOutlineButton(
                                label: entry.value.label,
                                onTap: () {
                                  handleFrameButtonTap(entry.value);
                                },
                                textStyle:
                                    (currentFrame.buttons ?? []).length > 2
                                        ? Typo.xSmall.copyWith(
                                            color: colorScheme.onPrimary,
                                          )
                                        : Typo.small.copyWith(
                                            color: colorScheme.onPrimary,
                                          ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          if (frameLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                ),
                child: Center(
                  child: Loading.defaultLoading(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
