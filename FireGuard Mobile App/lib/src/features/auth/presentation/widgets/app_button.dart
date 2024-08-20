import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.buttonText, required this.onPressed,
  });
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsManager.secondaryColor,
        backgroundColor: ColorsManager.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              6,
            ),
          ),
        ),
        minimumSize: const Size(353, 56),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
      ),
    );
  }
}
