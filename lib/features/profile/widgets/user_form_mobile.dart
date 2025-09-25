import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/components/app_dropdown.dart';
import 'package:flutter_assessment/core/components/button.dart';
import 'package:flutter_assessment/core/components/form_input_field.dart';
import 'package:flutter_assessment/core/types.dart';
import 'package:flutter_assessment/features/profile/provider/user_provider.dart';
import 'package:flutter_assessment/features/profile/utils.dart';
import 'package:provider/provider.dart';

class UserFormMobile extends StatefulWidget {
  const UserFormMobile({super.key});

  @override
  State<UserFormMobile> createState() => _UserFormMobileState();
}

class _UserFormMobileState extends State<UserFormMobile> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? category;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        return Form(
          key: provider.formKey,
          child: Column(
            spacing: 16,
            children: [
              FormInputField(
                controller: _fullNameController,
                hintText: "Enter your full name",
                prefixIcon: const Icon(Icons.person_outline),
                validator: (value) {
                  return validateFullName(value);
                },
              ),
              FormInputField(
                controller: _emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
                validator: (value) {
                  return validateEmailField(value);
                },
              ),
              FormInputField(
                controller: _passwordController,
                hintText: "Enter your password",
                obscureText: _obscurePassword,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  return validatePassword(value);
                },
                onChanged: (value) => onPasswordChanged(
                  value,
                  provider,
                  _confirmPasswordController.text,
                ),
                forceErrorText: !provider.isPasswordMatch
                    ? "Passwords do not match"
                    : null,
              ),
              FormInputField(
                controller: _confirmPasswordController,
                hintText: "Confirm your password",
                obscureText: _obscureConfirmPassword,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  return validateConfirmPassword(
                    value,
                    password: _passwordController.text,
                  );
                },
                onChanged: (value) => onConfirmPasswordChanged(
                  value,
                  provider,
                  _passwordController.text,
                ),
                forceErrorText: !provider.isPasswordMatch
                    ? "Passwords do not match"
                    : null,
              ),
              AppDropdown<CategoryOptions>(
                controller: _categoryController,
                width: double.infinity,
                menuWidth: 250,
                hintText: "Select a category",
                onSelected: (CategoryOptions? value) {
                  setState(() {
                    category = value!.value;
                  });
                },
                dropdownMenuEntries: CategoryOptions.entries,
              ),
              const SizedBox(height: 8),
              AppButton(
                onPressed: () => onSubmit(
                  context: context,
                  provider: provider,
                  fullName: _fullNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                  category: category,
                ),
                isLoading: provider.isLoading,
                text: 'Submit',
              ),
            ],
          ),
        );
      },
    );
  }
}
