import '../core/colors.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    super.key,
    required this.errorMessage,
  });
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error: $errorMessage',
        style: const TextStyle(
          color: primaryColor,
        ),
      ),
    );
  }
}
