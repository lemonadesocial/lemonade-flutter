import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_rewards_bloc.freezed.dart';

class ClaimRewardsBloc extends Bloc<ClaimRewardsEvent, ClaimRewardsState> {
  final String? eventId;
  ClaimRewardsBloc(this.eventId) : super(ClaimRewardsState()) {
    on<_ClaimRewardsEventGetUserDetail>(_onGetUserDetail);
  }
  final _userRepository = getIt<UserRepository>();

  void _onGetUserDetail(
    _ClaimRewardsEventGetUserDetail event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: ScanQRCodeStatus.loading));
    final result = await _userRepository.getUser(
      userId: event.userId ?? '',
    );
    result.fold(
      (failure) => emit(state.copyWith(status: ScanQRCodeStatus.error)),
      (user) {
        emit(state.copyWith(status: ScanQRCodeStatus.success));
        emit(state.copyWith(scannedUserDetail: user));
      },
    );
  }
}

@freezed
class ClaimRewardsEvent with _$ClaimRewardsEvent {
  factory ClaimRewardsEvent.getUserDetail({
    required String? userId,
  }) = _ClaimRewardsEventGetUserDetail;
}

@freezed
class ClaimRewardsState with _$ClaimRewardsState {
  factory ClaimRewardsState({
    @Default(ScanQRCodeStatus.initial) ScanQRCodeStatus status,
    User? scannedUserDetail,
  }) = _ClaimRewardsState;
}

enum ScanQRCodeStatus {
  initial,
  loading,
  success,
  error,
}
