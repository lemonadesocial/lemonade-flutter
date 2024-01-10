import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class GetChainsListBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, List<Chain> currencies) builder;
  const GetChainsListBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, List<Chain>>>(
      future: getIt<Web3Repository>().getChainsList(),
      builder: (context, snapshot) {
        final chains = snapshot.data?.getOrElse(() => []) ?? [];
        return builder(context, chains);
      },
    );
  }
}
