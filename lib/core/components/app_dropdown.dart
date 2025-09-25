import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.controller,
    required this.hintText,
    required this.dropdownMenuEntries,
    required this.onSelected,
    this.prefixIcon,
    this.validator,
    this.width,
    this.menuWidth,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hintText;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final void Function(T?) onSelected;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final double? width;
  final double? menuWidth;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      controller: controller,
      width: width ?? double.infinity,
      enabled: enabled,
      hintText: hintText,
      requestFocusOnTap: true,
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
      leadingIcon: prefixIcon,
      menuStyle: MenuStyle(
        maximumSize: WidgetStateProperty.all(
          Size(menuWidth ?? double.infinity, 300),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8),
        ),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        prefixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return Colors.blue;
          }
          return Colors.grey.shade600;
        }),
      ),
      menuHeight: 300,
      trailingIcon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey.shade600,
      ),
      selectedTrailingIcon: const Icon(
        Icons.keyboard_arrow_up,
        color: Colors.blue,
      ),
    );
  }
}
