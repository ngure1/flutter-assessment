String? validateEmail(String? email) {
  RegExp emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  bool isValid = emailRegex.hasMatch(email ?? "");
  if (!isValid) {
    return "Please enter a valid email";
  }
  return null;
}
