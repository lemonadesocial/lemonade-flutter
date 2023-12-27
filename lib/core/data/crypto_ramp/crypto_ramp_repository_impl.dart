import 'package:app/core/data/crypto_ramp/stripe_onramp/dtos/stripe_onramp_session_dto/stripe_onramp_session_dto.dart';
import 'package:app/core/data/crypto_ramp/stripe_onramp/mutation/stripe_onramp_mutation.dart';
import 'package:app/core/domain/crypto_ramp/crypto_ramp_repository.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/entities/stripe_onramp_session/stripe_onramp_session.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/input/create_stripe_onramp_session_input/create_stripe_onramp_session_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CryptoRampRepositoryImpl implements CryptoRampRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, StripeOnrampSession>> createStripeOnrampSession({
    required CreateStripeOnrampSessionInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createStripeOnrampSessionMutation,
        variables: {
          'input': input.toJson(),
        },
        parserFn: (data) => StripeOnrampSession.fromDto(
          StripeOnrampSessionDto.fromJson(data['createStripeOnrampSession']),
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }

    return Right(result.parsedData!);
  }
}
