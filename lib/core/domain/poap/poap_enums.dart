enum ClaimState {
  PENDING,
  CONFIRMED,
  FAILED,
}

enum TransferState {
  PENDING,
  CONFIRMED,
  FAILED,
}

enum PoapNodeValueType {
  and(value: 'and'),
  or(value: 'or'),
  result(value: 'result'),
  userGeolocation(value: 'user-geolocation'),
  eventAccess(value: 'event-access'),
  twitterFollow(value: 'twitter-follow'),
  userFollow(value: 'user-follow'),
  userEmailVerified(value: 'user-email-verified'),
  userPhoneVerified(value: 'user-phone-verified');

  const PoapNodeValueType({required this.value});

  final String value;
}

enum ClaimErrorDescriptionName { AllClaimed, AlreadyClaimed, Forbidden }
