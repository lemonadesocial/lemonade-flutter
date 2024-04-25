import 'package:flutter/material.dart';

class CollaboratorDiscoverSocialGridSection extends StatelessWidget {
  const CollaboratorDiscoverSocialGridSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CustomGridItem(
            title: index == 0 ? 'Farcaster' : 'Twitter',
            iconUrl: 'https://via.placeholder.com/10x9', // Placeholder URL
          );
        },
        childCount: 2,
      ),
    );
  }
}

class CustomGridItem extends StatelessWidget {
  final String title;
  final String iconUrl;

  const CustomGridItem({
    super.key,
    required this.title,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.all(18),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.05999999865889549),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 18,
            height: 18,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.blue, // Placeholder for icon background color
            ),
            child: const Icon(
              Icons.account_circle, // Placeholder for icon
              color: Colors.white, // Placeholder for icon color
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: SizedBox(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Switzer Variable',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Container(
            width: 12,
            height: 12,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.blue, // Placeholder for icon background color
            ),
            child: const Icon(
              Icons.account_circle, // Placeholder for icon
              color: Colors.white, // Placeholder for icon color
            ),
          ),
        ],
      ),
    );
  }
}
