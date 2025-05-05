import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/domain/lens/entities/lens_auth.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/graphql/lens/auth/mutation/authenticate.graphql.dart';
import 'package:app/graphql/lens/auth/mutation/authentication_challenge.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_lens_account_bloc.freezed.dart';

@freezed
class LoginLensAccountEvent with _$LoginLensAccountEvent {
  const factory LoginLensAccountEvent.login({
    required String ownerAddress,
    required String accountAddress,
    required LensAccountStatus accountStatus,
  }) = _Login;
}

@freezed
class LoginLensAccountState with _$LoginLensAccountState {
  const factory LoginLensAccountState.initial() = _Initial;
  const factory LoginLensAccountState.loading() = _Loading;
  const factory LoginLensAccountState.success({
    required String token,
    required String refreshToken,
    String? idToken,
    required LensAccountStatus accountStatus,
  }) = _Success;
  const factory LoginLensAccountState.failed({
    required Failure failure,
  }) = _Failed;
}

class LoginLensAccountBloc
    extends Bloc<LoginLensAccountEvent, LoginLensAccountState> {
  final LensRepository _lensRepository;
  final WalletConnectService _walletConnectService;

  LoginLensAccountBloc({
    required LensRepository lensRepository,
    required WalletConnectService walletConnectService,
  })  : _lensRepository = lensRepository,
        _walletConnectService = walletConnectService,
        super(const LoginLensAccountState.initial()) {
    on<LoginLensAccountEvent>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginLensAccountEvent event,
    Emitter<LoginLensAccountState> emit,
  ) async {
    await event.map(
      login: (e) async {
        emit(const LoginLensAccountState.loading());
        try {
          final authChallenge = switch (e.accountStatus) {
            LensAccountStatus.onboarding => await _lensRepository.challenge(
                input: Variables$Mutation$LensAuthenticationChallenge(
                  request: Input$ChallengeRequest(
                    onboardingUser: Input$OnboardingUserChallengeRequest(
                      wallet: e.ownerAddress,
                    ),
                  ),
                ),
              ),
            LensAccountStatus.builder => await _lensRepository.challenge(
                input: Variables$Mutation$LensAuthenticationChallenge(
                  request: Input$ChallengeRequest(
                    builder: Input$BuilderChallengeRequest(
                      address: e.ownerAddress,
                    ),
                  ),
                ),
              ),
            LensAccountStatus.accountOwner => await _lensRepository.challenge(
                input: Variables$Mutation$LensAuthenticationChallenge(
                  request: Input$ChallengeRequest(
                    accountOwner: Input$AccountOwnerChallengeRequest(
                      owner: e.ownerAddress,
                      account: e.accountAddress,
                    ),
                  ),
                ),
              ),
          };
          if (authChallenge.isLeft()) {
            throw Exception("Failed to get auth challenge");
          }
          final challengeId = authChallenge.fold((l) => '', (r) => r.id ?? '');
          final message = authChallenge.fold((l) => '', (r) => r.text ?? '');

          final signedMessage = await _walletConnectService.personalSign(
            wallet: e.ownerAddress,
            message: Web3Utils.toHex(message),
          );

          if (signedMessage?.isEmpty == true) {
            throw Exception("Failed to sign message");
          }
          // Example:
          final result = await _lensRepository.authenticate(
            input: Variables$Mutation$LensAuthenticate(
              request: Input$SignedAuthChallenge(
                id: challengeId,
                signature: signedMessage!,
              ),
            ),
          );

          if (result.isLeft()) {
            throw Exception("Failed to authenticate");
          }

          final authenticationResult = result.fold((l) => null, (r) => r);

          if (authenticationResult is LensAuthenticationTokens) {
            emit(
              LoginLensAccountState.success(
                token: authenticationResult.accessToken ?? '',
                refreshToken: authenticationResult.refreshToken ?? '',
                accountStatus: e.accountStatus,
              ),
            );
          } else if (authenticationResult is LensWrongSignerError) {
            throw Exception("Wrong signer");
          } else if (authenticationResult is LensExpiredChallengeError) {
            throw Exception("Expired challenge");
          } else if (authenticationResult is LensForbiddenError) {
            throw Exception("Forbidden");
          } else {
            throw Exception("Failed to authenticate");
          }
        } catch (error) {
          emit(
            LoginLensAccountState.failed(
              failure: Failure(
                message: error.toString(),
              ),
            ),
          );
        }
      },
    );
  }
}
