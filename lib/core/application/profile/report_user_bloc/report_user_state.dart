part of 'report_user_bloc.dart';

@freezed
class ReportUserState with _$ReportUserState {
  const factory ReportUserState({
    @Default(ReportUserStatus.initial) ReportUserStatus status,
    @Default(false) bool blockUser,
    UserReportReason? reason,
  }) = _OnboardingState;

  factory ReportUserState.initial() => const ReportUserState();
}

enum ReportUserStatus {
  initial,
  loading,
  success,
  error,
}
