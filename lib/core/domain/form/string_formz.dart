import 'package:app/core/utils/string_validators.dart';
import 'package:formz/formz.dart';

enum StringValidationError {
  empty;

  String getMessage() {
    switch (this) {
      case empty:
        return 'Can\'t be empty';
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
