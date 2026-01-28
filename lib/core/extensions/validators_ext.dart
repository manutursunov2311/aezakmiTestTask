extension ValidatorsExtension on String {
  bool isEmailValid() {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(this);
  }

  bool isPasswordValid() {
    return length >= 8;
  }
}
