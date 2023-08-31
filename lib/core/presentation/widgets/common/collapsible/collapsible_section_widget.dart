import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollapsibleSection extends StatefulWidget {

  const CollapsibleSection({super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  _CollapsibleSectionState createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Text(widget.title,
                style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary, fontWeight: FontWeight.w600,),),
            trailing: _isExpanded
                ? Icon(
                    Icons.keyboard_arrow_up,
                    color: colorScheme.onPrimary,
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onPrimary,
                  ),
            children: [
              ...widget.children, // Include custom children here
            ],),);
  }
}
