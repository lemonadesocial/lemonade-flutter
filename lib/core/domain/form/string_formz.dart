import 'package:app/core/utils/validators/string_validators.dart';
import 'package:formz/formz.dart';

enum StringValidationError {
  empty;

  String getMessage(fieldName) {
    switch (this) {
      case empty:
        return '$fieldName is a required field';
      default:
        return '$fieldName is a required field';
    }
  }
}

final class StringFormz extends FormzInput<String, StringValidationError> {
  const StringFormz.pure([super.value = '']) : super.pure();
  const StringFormz.dirty([super.value = '']) : super.dirty();

  @override
  StringValidationError? validator(String value) {
    if (!NonEmptyStringValidator().isValid(value)) {
      return StringValidationError.empty;
    }
    return null;
  }
}

final class OptionalStringFormz
    extends FormzInput<String, StringValidationError> {
  const OptionalStringFormz.pure([super.value = '']) : super.pure();
  const OptionalStringFormz.dirty([super.value = '']) : super.dirty();

  @override
  StringValidationError? validator(String value) {
    return null;
  }
}
