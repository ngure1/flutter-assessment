import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.text = 'Submit',
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ?? Colors.blue;
    final foregroundColor = widget.foregroundColor ?? Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width ?? double.infinity,
        height: widget.height ?? 48,
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isHovered
                ? backgroundColor.withValues(alpha: 0.9)
                : backgroundColor,
            foregroundColor: foregroundColor,
            elevation: _isHovered ? 6 : 3,
            shadowColor: backgroundColor.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: foregroundColor,
                    letterSpacing: 0.3
                  ),
                ),
        ),
      ),
    );
  }
}
