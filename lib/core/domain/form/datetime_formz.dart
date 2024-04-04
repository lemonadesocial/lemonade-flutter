import 'package:app/core/utils/validators/datetime_validators.dart';
import 'package:formz/formz.dart';

enum DateTimeValidationError {
  mustBeFuture;

  String getMessage(fieldName) {
    switch (this) {
      case mustBeFuture:
        return '$fieldName must be in future';
      default:
        return '$fieldName is a required field';
    }
  }
}

final class DateTimeFormz
    extends FormzInput<DateTime?, DateTimeValidationError> {
  const DateTimeFormz.pure() : super.pure(null);
  const DateTimeFormz.dirty(DateTime super.dateTime) : super.pure();

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
