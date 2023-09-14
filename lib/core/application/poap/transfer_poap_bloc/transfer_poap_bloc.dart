import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_poap_bloc.freezed.dart';

class TransferPoapBloc extends Bloc<TransferPoapEvent, TransferPoapState> {
  TransferPoapBloc() : super(TransferPoapState.initial()) {
    on<TransferPoapEventTransfer>(_onTransfer);
  }

  final _poapRepository = getIt<PoapRepository>();

  Future<void> _onTransfer(
    TransferPoapEventTransfer event,
    Emitter emit,
  ) async {
    emit(TransferPoapState.loading());
    final result = await _poapRepository.transfer(input: event.input);
    result.fold(
      (failure) => emit(TransferPoapState.failure(message: failure.message)),
      (transfer) => emit(
        TransferPoapState.success(transfer: transfer),
      ),
    );
  }
}

@freezed
class TransferPoapEvent with _$TransferPoapEvent {
  factory TransferPoapEvent.transfer({
    required TransferInput input,
  }) = TransferPoapEventTransfer;
}

@freezed
class TransferPoapState with _$TransferPoapState {
  factory TransferPoapState.initial() = TransferPoapStateInitial;
  factory TransferPoapState.loading() = TransferPoapStateLoading;
  factory TransferPoapState.success({
    required Transfer transfer,
  }) = TransferPoapStateSuccess;
  factory TransferPoapState.failure({
    String? message,
  }) = TransferPoapStateFailure;
}
