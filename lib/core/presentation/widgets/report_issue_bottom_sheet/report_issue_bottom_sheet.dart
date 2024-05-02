import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/custom_error_widget.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';

class ReportIssueBottomSheet extends StatelessWidget {
  const ReportIssueBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
      ),
      body: const CustomError(),
    );
  }
}
