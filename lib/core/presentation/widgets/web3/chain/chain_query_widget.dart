import 'package:app/core/data/web3/dtos/chain_dto.dart';
import 'package:app/core/data/web3/web3_query.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:collection/collection.dart';

class ChainQuery extends StatelessWidget {
  final String chainId;
  final Widget Function(
    Chain? chain, {
    required bool isLoading,
  }) builder;
  final Widget Function()? errorBuilder;

  const ChainQuery({
    super.key,
    required this.chainId,
    required this.builder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: getChainsListQuery,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        pollInterval: const Duration(days: 30),
        parserFn: (data) => List.from(data['listChains'] ?? [])
            .map(
              (item) => Chain.fromDto(
                ChainDto.fromJson(item),
              ),
            )
            .toList(),
      ),
      builder: (
        result, {
        fetchMore,
        refetch,
      }) {
        if (result.hasException) {
          return builder.call(null, isLoading: false);
        }

        final chain = result.parsedData?.firstWhereOrNull(
          (chainItem) => chainItem.chainId == chainId,
        );

        return builder(chain, isLoading: result.isLoading);
      },
    );
  }
}
