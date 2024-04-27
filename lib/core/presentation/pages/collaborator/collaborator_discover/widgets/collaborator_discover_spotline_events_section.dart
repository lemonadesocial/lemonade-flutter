import 'package:flutter/material.dart';

class CollaboratorDiscoverSpotlineEventsSection extends StatelessWidget {
  const CollaboratorDiscoverSpotlineEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 351,
        height: 200,
        padding: const EdgeInsets.all(18),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.05999999865889549),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                  ),
                  const SizedBox(width: 9),
                  const Expanded(
                    child: SizedBox(
                      child: Text(
                        'Spotlight events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Switzer Variable',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 150.0,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: Colors.blueGrey[100 * (index % 9)],
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
