import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_email_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_event_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_location_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_phone_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_twitter_node_widget.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_bottom_sheet/nodes/poap_policy_user_node_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    ),
                ],
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NodeContainer(
                  result: result,
                  wrap: false,
                  child: PoapPolicyNodeWidget(node: nodeItem),
                ),
                if (!isLast)
                  SizedBox(
                    height: Spacing.xSmall,
                  ),
              ],
            );
          }).toList(),
        );
      }

      if (node!.value == PoapNodeValueType.or.value) {
        return _NodeContainer(
          result: result,
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
                    const NodeDivider(text: "OR"),
                ],
              );
            }).toList(),
          ),
        );
      }
    }

    final isNodeChildrenEmpty =
        node!.children == null || node!.children!.isEmpty;

    if (node!.value == PoapNodeValueType.userGeolocation.value &&
        !isNodeChildrenEmpty) {
      return _NodeContainer(
        result: result,
        wrap: wrap,
        child: PoapPolicyLocationNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.eventAccess.value &&
        !isNodeChildrenEmpty) {
      return _NodeContainer(
        result: result,
        wrap: wrap,
        child: PoapPolicyEventNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.twitterFollow.value &&
        !isNodeChildrenEmpty) {
      return _NodeContainer(
        result: result,
        wrap: wrap,
        child: PoapPolicyTwitterNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userFollow.value &&
        !isNodeChildrenEmpty) {
      return _NodeContainer(
        result: result,
        wrap: wrap,
        child: PoapPolicyUserNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userEmailVerified.value) {
      return _NodeContainer(
        wrap: wrap,
        result: result,
        child: PoapPolicyEmailNodeWidget(node: node!, result: result),
      );
    }

    if (node!.value == PoapNodeValueType.userPhoneVerified.value) {
      return _NodeContainer(
        wrap: wrap,
        result: result,
        child: PoapPolicyPhoneNodeWidget(node: node!, result: result),
      );
    }

    return const SizedBox.shrink();
  }
}

class _NodeContainer extends StatelessWidget {
  const _NodeContainer({
    required this.child,
    required this.result,
    // ignore: unused_element
    this.wrap = true,
  });

  final Widget child;
  final bool result;
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
                  color: result
                      ? Colors.transparent
                      : colorScheme.onPrimary.withOpacity(0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(
                      color: result ? colorScheme.outline : Colors.transparent,
                    ),
                  ),
                ),
          child: child,
        ),
      ],
    );
  }
}

class NodeDivider extends StatelessWidget {
  const NodeDivider({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: Spacing.xSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Divider(
              height: 1.w,
              thickness: 1.w,
              color: colorScheme.onPrimary.withOpacity(0.09),
            ),
          ),
          Container(
            width: Sizing.regular,
            height: Sizing.small,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.normal),
              color: colorScheme.onPrimary.withOpacity(0.09),
            ),
            child: Center(
              child: Text(
                text,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 1.w,
              thickness: 1.w,
              color: colorScheme.onPrimary.withOpacity(0.09),
            ),
          ),
        ],
      ),
    );
  }
}
