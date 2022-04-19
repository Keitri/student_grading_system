class Validator {
  static String? requiredValidator(String? value) {
    if (value == null) {
      return 'Required';
    }

    return value.isEmpty ? 'Required' : null;
  }

  static String? passwordValidator(String? value) {
    if (value == null) {
      return 'Required';
    }

    if (value.isEmpty) {
      return 'Required';
    }

    final regex = RegExp(
        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&])[A-Za-z\\d@\$!%*?&]{10,}\$");
    final valid = regex.hasMatch(value);

    if (!valid) {
      return 'Password should be at least 10 characters and must contain lowercase, \nuppercase, number and special character.';
    }
    return null;
  }
}
