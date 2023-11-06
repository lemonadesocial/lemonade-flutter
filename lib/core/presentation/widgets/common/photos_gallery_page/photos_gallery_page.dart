import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_back_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class PhotosGalleryPage extends StatefulWidget {
  PhotosGalleryPage({
    super.key,
    required this.photos,
    this.initialIndex = 0,
    this.title,
  });

  final List<String> photos;
  final int initialIndex;
  final Widget? title;

  late final PageController pageController =
      PageController(initialPage: initialIndex);

  @override
  State<PhotosGalleryPage> createState() => _PhotosGalleryPageState();
}

class _PhotosGalleryPageState extends State<PhotosGalleryPage> {
  int currentIndex = 0;
  AutoScrollController scrollController = AutoScrollController(
    axis: Axis.horizontal,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.initialIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        title: widget.title,
        centerTitle: true,
        leading: LemonBackButton(
          color: colorScheme.onPrimary,
        ),
        actions: [
          InkWell(
            onTap: () async {
              final file = await ImageUtils.urlToFile(photos[currentIndex]);
              Share.shareXFiles([file]);
            },
            child: ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) =>
                  Assets.icons.icShare.svg(colorFilter: filter),
            ),
          ),
          SizedBox(width: Spacing.smMedium),
        ],
      ),
      body: Dismissible(
        key: const Key('photo_gallery'),
        direction: DismissDirection.down,
        onDismissed: (direction) {
          AutoRouter.of(context).pop();
        },
        child: Column(
          children: [
            Expanded(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(photos[index]),
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.contained * 3,
                    heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
                  );
                },
                itemCount: photos.length,
                loadingBuilder: (context, event) =>
                    ImagePlaceholder.defaultPlaceholder(),
                backgroundDecoration: BoxDecoration(
                  color: colorScheme.primary,
                ),
                pageController: widget.pageController,
                onPageChanged: (index) {
                  scrollController.scrollToIndex(
                    index,
                    preferPosition: AutoScrollPosition.middle,
                  );
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            SafeArea(
              child: Container(
                height: 80.w,
                color: colorScheme.primary,
                padding: EdgeInsets.symmetric(vertical: Spacing.small),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isActive = currentIndex == index;
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: scrollController,
                      index: index,
                      child: InkWell(
                        onTap: () {
                          widget.pageController.jumpToPage(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            border: Border.all(
                              width: isActive ? 2.w : 1.w,
                              color: isActive
                                  ? colorScheme.onPrimary
                                  : colorScheme.outline,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3.r),
                            child: CachedNetworkImage(
                              imageUrl: photos[index],
                              width: 42.w,
                              height: 42.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    width: Spacing.superExtraSmall,
                  ),
                  itemCount: photos.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
