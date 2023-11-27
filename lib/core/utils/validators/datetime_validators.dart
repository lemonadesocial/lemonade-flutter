abstract class DateTimeValidator {
  bool isValid(DateTime value);
}

class MustBeFutureValidator extends DateTimeValidator {
  MustBeFutureValidator();

  @override
  bool isValid(DateTime value) {
    return value.isBefore(DateTime.now());
  }
}
