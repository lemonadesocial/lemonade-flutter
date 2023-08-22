import 'package:app/core/application/poap/claim_poap_bloc/claim_poap_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart' as badge_entities;
import 'package:app/core/utils/location_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoapClaimBuilder extends StatelessWidget {
  const PoapClaimBuilder({
    super.key,
    required this.badge,
    required this.builder,
  });
  final badge_entities.Badge badge;
  final Widget Function(BuildContext context, ClaimPoapState state, bool locationEnabled) builder;

  @override
  Widget build(BuildContext context) {
    return _PoapClaimBuilderView(
      builder: builder,
    );
  }
}

class _PoapClaimBuilderView extends StatelessWidget {
  const _PoapClaimBuilderView({
    required this.builder,
  });
  final Widget Function(BuildContext context, ClaimPoapState state, bool locationEnabled) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getIt<LocationUtils>().checkPermission(),
      builder: (context, snapshot) {
        final locationEnabled = snapshot.data ?? false;
        return BlocBuilder<ClaimPoapBloc, ClaimPoapState>(
          builder: (context, state) => builder(context, state, locationEnabled),
        );
      },
    );
  }
}
