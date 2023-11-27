import 'package:app/core/utils/validators/datetime_validators.dart';
import 'package:formz/formz.dart';

enum DateTimeValidationError {
  mustBeFuture;
}

final class DateTimeFormz
    extends FormzInput<DateTime?, DateTimeValidationError> {
  const DateTimeFormz.pure() : super.pure(null);
  const DateTimeFormz.dirty(DateTime dateTime) : super.pure(dateTime);

  @override
  DateTimeValidationError? validator(DateTime? value) {
    if (value == null) {
      return null;
    }
    if (!MustBeFutureValidator().isValid(value)) {
      return DateTimeValidationError.mustBeFuture;
    }
    return null;
  }
}
