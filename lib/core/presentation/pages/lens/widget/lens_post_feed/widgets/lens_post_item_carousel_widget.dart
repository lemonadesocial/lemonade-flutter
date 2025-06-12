import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LensPostItemCarouselWidget extends StatelessWidget {
  LensPostItemCarouselWidget({
    super.key,
    required this.images,
  });

  final PageController controller = PageController();
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            LemonRadius.sm,
          ),
          child: SizedBox(
            height: 200.w,
            child: PageView.builder(
              controller: controller,
              padEnds: false,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];
                return LemonNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        if (images.length > 1) ...[
          SizedBox(height: Spacing.xSmall),
          SmoothPageIndicator(
            controller: controller,
            count: images.length,
            effect: ScrollingDotsEffect(
              dotWidth: 8.w,
              dotHeight: 8.w,
              activeDotColor: appColors.textPrimary,
              dotColor: appColors.textTertiary,
              activeDotScale: 1,
              smallDotScale: 1,
            ),
          ),
        ],
      ],
    );
  }
}
