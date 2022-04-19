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

    //TODO Add Password Check Here

    return null;
  }
}
