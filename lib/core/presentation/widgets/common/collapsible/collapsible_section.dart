import 'package:app/core/mock_model/chat_room.dart';
import 'package:app/theme/theme.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollapsibleSection extends StatefulWidget {
  final String title;
  final List<ChatRoom> chatRooms;
  final List<Widget> children;

  CollapsibleSection(
      {required this.title, required this.chatRooms, required this.children});

  @override
  _CollapsibleSectionState createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Theme(
        data:
            lemonadeAppDarkThemeData.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Text(widget.title,
                style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary, fontWeight: FontWeight.w600)),
            children: [
              ...widget.children, // Include custom children here
            ],
            trailing: _isExpanded
                ? Icon(
                    Icons.keyboard_arrow_up,
                    color: colorScheme.onPrimary,
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onPrimary,
                  )));
  }
}
