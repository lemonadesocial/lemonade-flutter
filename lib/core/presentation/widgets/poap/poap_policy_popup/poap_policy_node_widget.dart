// ignore_for_file: use_if_null_to_convert_nulls_to_bools, avoid_bool_literals_in_conditional_expressions

import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_email_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_event_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_location_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_phone_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_twitter_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/nodes/poap_policy_user_node_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class PoapPolicyNodeWidget extends StatelessWidget {
  const PoapPolicyNodeWidget({
    super.key,
    this.node,
    this.wrap = true,
  });

  final PoapPolicyNode? node;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    var result = false;

    if (node == null) return const SizedBox.shrink();

    if (node?.children?.isNotEmpty == true) {
      final excludedResultNodes = <PoapPolicyNode>[];

      for (final nodeItem in node!.children!) {
        if (nodeItem.value == 'result') {
          result = nodeItem.children!.isNotEmpty ? nodeItem.children![0].value == 'true' : false;
        } else {
          excludedResultNodes.add(nodeItem);
        }
      }

      if (node!.value == 'and') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: excludedResultNodes.asMap().entries.map((entry) {
            final index = entry.key;
            final nodeItem = entry.value;
            final isLast = index == excludedResultNodes.length - 1;

            if (nodeItem.value == 'or') {
              return Column(
                children: [
                  PoapPolicyNodeWidget(node: nodeItem),
                  if (!isLast)
                    SizedBox(
                      height: Spacing.xSmall,
                    )
                ],
              );
            }
            return Column(
              children: [
                _NodeContainer(
                  wrap: false,
                  child: PoapPolicyNodeWidget(node: nodeItem),
                ),
                if (!isLast)
                  SizedBox(
                    height: Spacing.xSmall,
                  )
              ],
            );
          }).toList(),
        );
      }

      if (node!.value == 'or') {
        return _NodeContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: excludedResultNodes.asMap().entries.map((entry) {
              final index = entry.key;
              final nodeItem = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PoapPolicyNodeWidget(
                    node: nodeItem,
                    wrap: false,
                  ),
                  if (index + 1 < excludedResultNodes.length)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text('OR'),
                    ),
                ],
              );
            }).toList(),
          ),
        );
      }
    }

    if (node!.value == 'user-geolocation' && node?.children?.isNotEmpty == true) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyLocationNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == 'event-access' && node?.children?.isNotEmpty == true) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyEventNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == 'twitter-follow' && node?.children?.isNotEmpty == true) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyTwitterNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == 'user-follow' && node?.children?.isNotEmpty == true) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyUserNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == 'user-email-verified') {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyEmailNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == 'user-phone-verified') {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyPhoneNodeWidget(node: node!, result: result),
      );
    }

    return const SizedBox.shrink();
  }
}

class _NodeContainer extends StatelessWidget {
  const _NodeContainer({
    required this.child,
    // ignore: unused_element
    this.wrap = true,
  });

  final Widget child;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: !wrap
              ? null
              : EdgeInsets.symmetric(
                  vertical: Spacing.xSmall,
                  horizontal: Spacing.medium,
                ),
          decoration: !wrap
              ? null
              : ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    side: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
          child: child,
        )
      ],
    );
  }
}
