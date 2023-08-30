import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
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

    if (node?.children != null && node!.children!.isNotEmpty) {
      final excludedResultNodes = <PoapPolicyNode>[];

      for (final nodeItem in node!.children!) {
        if (nodeItem.value == PoapNodeValueType.result.value) {
          if (nodeItem.children == null || nodeItem.children!.isEmpty) {
            result = false;
          } else {
            result = nodeItem.children![0].value == 'true';
          }
        } else {
          excludedResultNodes.add(nodeItem);
        }
      }

      if (node!.value == PoapNodeValueType.and.value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: excludedResultNodes.asMap().entries.map((entry) {
            final index = entry.key;
            final nodeItem = entry.value;
            final isLast = index == excludedResultNodes.length - 1;

            if (nodeItem.value == PoapNodeValueType.or.value) {
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

      if (node!.value == PoapNodeValueType.or.value) {
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

    final isNodeChildrenEmpty = node!.children == null || node!.children!.isEmpty;

    if (node!.value == PoapNodeValueType.userGeolocation.value && !isNodeChildrenEmpty) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyLocationNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.eventAccess.value && !isNodeChildrenEmpty) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyEventNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.twitterFollow.value && !isNodeChildrenEmpty) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyTwitterNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userFollow.value && !isNodeChildrenEmpty) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyUserNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userEmailVerified.value) {
      return _NodeContainer(
        wrap: wrap,
        child: PoapPolicyEmailNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userPhoneVerified.value) {
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
