import 'package:app/core/domain/token/entities/token_entities.dart';
import 'package:app/core/presentation/widgets/hero_image_viewer_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ProfileNftItem extends StatelessWidget {
  final Either<TokenComplex, TokenSimple> nftToken;
  const ProfileNftItem({super.key, 
    required this.nftToken,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String? imageUrl = nftToken.fold(
      (complex) => complex.metadata?.image,
      (simple) => simple.metadata?.image,
    );
    String? animationUrl = nftToken.fold(
      (complex) => complex.metadata?.animation_url,
      (simple) => simple.metadata?.animation_url,
    );
    String? id = nftToken.fold(
      (complex) => complex.id,
      (simple) => simple.id,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder(
            future: MediaUtils.getNftMedia(imageUrl, animationUrl),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final media = snapshot.data;
                if (media!.type == MediaType.image) {
                  return HeroImageViewer(
                    tag: id ?? '',
                    imageUrl: media.url ?? '',
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                        child: CachedNetworkImage(
                          imageUrl: media.url ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (ctx, _, __) => ImagePlaceholder.defaultPlaceholder(),
                          placeholder: (ctx, _) => ImagePlaceholder.defaultPlaceholder(),
                        ),
                      ),
                    ),
                  );
                }
              }
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                ),
                child: ImagePlaceholder.defaultPlaceholder(),
              );
            },
          ),
        ),
      ],
    );
  }
}
