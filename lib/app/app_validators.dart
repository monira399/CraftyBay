class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    return null;
  }

  static String? name (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    return null;
  }

  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  static String? signUpPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String? password) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if(value != password) {
      return 'Confirm password does\'nt match';
    }
    return null;
  }

  static String? phoneNumber(
      String? value,
      ) {
    final phone = value?.trim() ?? '';

    if(phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(phone)) {
      return 'Enter a valid Bangladeshi phone number';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    final description = value!.trim();

    if (description.isEmpty) {
      return 'Please describe the problem.';
    }

    if (description.length < 10) {
      return 'Please enter at least 10 characters.';
    }

    if (description.length > 500) {
      return 'Description cannot exceed 500 characters.';
    }

    return null;
  }

}