import 'package:app/core/domain/report/input/report_input.dart';
import 'package:app/core/domain/report/report_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_bloc.freezed.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportState.initial()) {
    on<ReportEventReportPost>(_onReportPost);
    on<ReportEventReportEvent>(_onReportEvent);
  }

  final reportRepository = getIt<ReportRepository>();

  Future<void> _onReportPost(ReportEventReportPost event, Emitter emit) async {
    emit(ReportState.loading());
    final result = await reportRepository.reportPost(input: event.input);
    result.fold(
      (l) => emit(
        ReportState.failure(),
      ),
      (r) => emit(
        ReportState.success(),
      ),
    );
  }

  Future<void> _onReportEvent(
    ReportEventReportEvent event,
    Emitter emit,
  ) async {
    emit(ReportState.loading());
    final result = await reportRepository.reportEvent(input: event.input);
    result.fold(
      (l) => emit(
        ReportState.failure(),
      ),
      (r) => emit(
        ReportState.success(),
      ),
    );
  }
}

@freezed
class ReportEvent with _$ReportEvent {
  factory ReportEvent.reportEvent({
    required ReportInput input,
  }) = ReportEventReportEvent;
  factory ReportEvent.reportPost({
    required ReportInput input,
  }) = ReportEventReportPost;
}

@freezed
class ReportState with _$ReportState {
  factory ReportState.initial() = ReportStateInitial;
  factory ReportState.loading() = ReportStateLoading;
  factory ReportState.success() = ReportStateSuccess;
  factory ReportState.failure() = ReportStateFailure;
}
