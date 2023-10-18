import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/profile/enum/user_report_reason.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_user_bloc.freezed.dart';

part 'report_user_state.dart';

class ReportUserBloc extends Cubit<ReportUserState> {
  ReportUserBloc(this._repository) : super(ReportUserState.initial());
  final UserRepository _repository;

  Future<void> reportUser({required String userId}) async {
    emit(state.copyWith(status: ReportUserStatus.loading));
    final response = await _repository.reportUser(
      userId: userId,
      reason: state.reason!.reason,
    );
    response.fold(
      (failure) => emit(state.copyWith(status: ReportUserStatus.error)),
      (success) => emit(state.copyWith(status: ReportUserStatus.success)),
    );
  }

  void onReasonChange(UserReportReason? reason) {
    emit(state.copyWith(reason: reason));
  }

  void onBlockUserToggle(bool value) {
    emit(state.copyWith(blockUser: value));
  }
}
