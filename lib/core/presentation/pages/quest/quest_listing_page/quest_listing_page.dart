import 'package:app/core/presentation/pages/quest/quest_listing_page/views/quest_listing_page_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class QuestListingPage extends StatefulWidget {
  const QuestListingPage({super.key});

  @override
  State<QuestListingPage> createState() => _QuestListingPageState();
}

class _QuestListingPageState extends State<QuestListingPage> {
  @override
  Widget build(BuildContext context) {
    return const QuestListingPageView();
  }
}
