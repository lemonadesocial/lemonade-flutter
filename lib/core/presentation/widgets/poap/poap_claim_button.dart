import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart' as badge_entities;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoapClaimButton extends StatelessWidget {
  const PoapClaimButton({
    super.key,
    required this.badge,
    required this.builder,
  });
  final badge_entities.Badge badge;
  final Widget Function(BuildContext context, ClaimPoapState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClaimPoapBloc(badge: badge)..add(const ClaimPoapEvent.checkHasClaimed()),
      child: _PoapClaimButtonView(
        builder: builder,
      ),
    );
  }
}

class _PoapClaimButtonView extends StatelessWidget {
  const _PoapClaimButtonView({
    required this.builder,
  });
  final Widget Function(BuildContext context, ClaimPoapState state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClaimPoapBloc, ClaimPoapState>(
      builder: builder,
    );
  }
}
