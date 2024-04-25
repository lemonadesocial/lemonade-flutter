import 'package:app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final IMAGE_SIZE = 351.w;

class UserDiscoveryPhotoGallery extends StatefulWidget {
  const UserDiscoveryPhotoGallery({super.key});

  @override
  UserDiscoveryPhotoGalleryState createState() =>
      UserDiscoveryPhotoGalleryState();
}

class UserDiscoveryPhotoGalleryState extends State<UserDiscoveryPhotoGallery> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      6,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          height: IMAGE_SIZE,
          child: Center(
            child: Text(
              "Page $index",
              style: const TextStyle(color: Colors.indigo),
            ),
          ),
        ),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: IMAGE_SIZE,
          child: PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pages.length,
          effect: ExpandingDotsEffect(
            dotHeight: 3,
            dotWidth: Sizing.small,
            // type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }
}
