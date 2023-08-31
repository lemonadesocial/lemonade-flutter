import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/presentation/widgets/poap/poap_policy_popup/poap_policy_node_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class PoapPolicyPopup extends StatelessWidget {
  const PoapPolicyPopup({super.key, required this.policyResult});

  final PoapPolicyResult policyResult;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: colorScheme.primary,
      insetPadding: EdgeInsets.symmetric(horizontal: Spacing.medium),
      child: Container(
        decoration: ShapeDecoration(
          color: colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              LemonRadius.small,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall, horizontal: Spacing.medium),
        width: double.infinity,
        child: PoapPolicyNodeWidget(node: policyResult.node),
      ),
    );
  }
}
