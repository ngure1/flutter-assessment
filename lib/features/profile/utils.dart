import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/utils/validation.dart';
import 'package:flutter_assessment/features/profile/models/user_model.dart';
import 'package:flutter_assessment/features/profile/provider/user_provider.dart';

String? validateFullName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Full name is required";
  }
  if (value.trim().length < 2) {
    return "Name must be at least 2 characters";
  }
  if (value.trim().length > 50) {
    return "Name must be less than 50 characters";
  }
  return null;
}

String? validateEmailField(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Email is required";
  }
  return validateEmail(value.trim());
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }
  if (value.length > 128) {
    return "Password must be less than 128 characters";
  }
  return null;
}

String? validateConfirmPassword(String? value, {String? password}) {
  if (value == null || value.isEmpty) {
    return "Please confirm your password";
  }
  if (value != password) {
    return "Passwords do not match";
  }
  return null;
}

// Event handlers
void onPasswordChanged(
  String value,
  UserProvider provider,
  String confirmPasswordValue,
) {
  if (confirmPasswordValue.isNotEmpty) {
    provider.checkPasswordMatch(
      password: value,
      confirmPassword: confirmPasswordValue,
    );
  }
}

void onConfirmPasswordChanged(
  String value,
  UserProvider provider,
  String passwordValue,
) {
  provider.checkPasswordMatch(password: passwordValue, confirmPassword: value);
}

Future<void> onSubmit({
  required BuildContext context,
  required UserProvider provider,
  required String fullName,
  required String email,
  required String password,
  required String confirmPassword,
  String? category
}) async {
  if (!provider.validateForm()) return;

  provider.checkPasswordMatch(
    password: password,
    confirmPassword: confirmPassword,
  );

  if (!provider.isPasswordMatch) return;

  await provider.submitUserData(
    data: UserModel(
      fullName: fullName.trim(),
      email: email.trim(),
      password: password,
      category: category ?? "",
    ),
  );

  if (!context.mounted) return;

  showSubmissionResult(provider, context);
}

void showSubmissionResult(UserProvider provider, BuildContext context) {
  if (provider.id != null && !provider.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Submitted successfully! Id: ${provider.id}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  } else if (provider.hasError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(provider.errorMessage ?? 'An error occurred'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
