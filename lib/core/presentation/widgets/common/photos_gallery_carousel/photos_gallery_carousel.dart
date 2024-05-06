import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final IMAGE_HEIGHT = 351.w;

class PhotoGalleryCarousel extends StatefulWidget {
  PhotoGalleryCarousel({
    super.key,
    required this.photos,
    this.initialIndex = 0,
  });
  final List<String> photos;
  final int initialIndex;
  late final controller = PageController(
    viewportFraction: 1,
    keepPage: true,
    initialPage: initialIndex,
  );

  @override
  PhotoGalleryCarouselState createState() => PhotoGalleryCarouselState();
}

class PhotoGalleryCarouselState extends State<PhotoGalleryCarousel> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.initialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        SizedBox(
          height: IMAGE_HEIGHT,
          child: PageView.builder(
            controller: widget.controller,
            onPageChanged: (pageIndex) {
              setState(() {
                currentIndex = pageIndex;
              });
            },
            itemCount: widget.photos.length,
            padEnds: false,
            pageSnapping: true,
            itemBuilder: (_, index) {
              return Center(
                child: LemonNetworkImage(
                  imageUrl: widget.photos[index],
                  fit: BoxFit.cover,
                  height: IMAGE_HEIGHT,
                  placeholder: ImagePlaceholder.eventCard(),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: Spacing.small,
          right: Spacing.small,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.extraSmall,
              vertical: Spacing.superExtraSmall / 2,
            ),
            decoration: ShapeDecoration(
              color: LemonColor.chineseBlack,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${currentIndex + 1}/${widget.photos.length}',
                  textAlign: TextAlign.center,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: Spacing.small,
          child: Center(
            child: SmoothPageIndicator(
              controller: widget.controller,
              count: widget.photos.length,
              effect: ExpandingDotsEffect(
                activeDotColor: colorScheme.onPrimary,
                dotColor: colorScheme.onPrimary,
                expansionFactor: 3,
                dotWidth: 6.w,
                dotHeight: 3.w,
                spacing: 6.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
