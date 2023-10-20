enum UserReportReason {
  uncomfortable('Made me uncomfortable'),
  inappropriateContent('Inappropriate profile'),
  stolen('Stolen photo / fake profile'),
  underAge('Under 18');

  final String reason;

  const UserReportReason(this.reason);
}
