import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_code_bloc.freezed.dart';

class ScanQRCodeBloc extends Bloc<ScanQRCodeEvent, ScanQRCodeState> {
  final String? eventId;
  ScanQRCodeBloc(this.eventId) : super(ScanQRCodeState()) {
    on<_ScanQRCodeEventGetUserDetail>(_onGetUserDetail);
  }
  final _userRepository = getIt<UserRepository>();

  void _onGetUserDetail(
    _ScanQRCodeEventGetUserDetail event,
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
class ScanQRCodeEvent with _$ScanQRCodeEvent {
  factory ScanQRCodeEvent.getUserDetail({
    required String? userId,
  }) = _ScanQRCodeEventGetUserDetail;
}

@freezed
class ScanQRCodeState with _$ScanQRCodeState {
  factory ScanQRCodeState({
    @Default(ScanQRCodeStatus.initial) ScanQRCodeStatus status,
    User? scannedUserDetail,
  }) = _ScanQRCodeState;
}

enum ScanQRCodeStatus {
  initial,
  loading,
  success,
  error,
}
