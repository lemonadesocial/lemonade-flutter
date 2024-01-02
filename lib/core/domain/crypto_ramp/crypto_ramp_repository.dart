import 'package:app/core/domain/crypto_ramp/stripe_onramp/entities/stripe_onramp_session/stripe_onramp_session.dart';
import 'package:app/core/domain/crypto_ramp/stripe_onramp/input/create_stripe_onramp_session_input/create_stripe_onramp_session_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoRampRepository {
  Future<Either<Failure, StripeOnrampSession>> createStripeOnrampSession({
    required CreateStripeOnrampSessionInput input,
  });
}
