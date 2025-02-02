import "package:alpha_flutter_project/login/login.dart";

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure("");
  const Username.dirty([super.value = ""]) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
