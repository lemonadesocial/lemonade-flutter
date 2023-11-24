import 'package:formz/formz.dart';

enum IntValidationError {
  empty;
}

final class IntFormz extends FormzInput<int, IntValidationError> {
  const IntFormz.pure([super.value = 0]) : super.pure();
  const IntFormz.dirty([super.value = 0]) : super.dirty();

  @override
  IntValidationError? validator(int value) {
    return null;
  }
}
