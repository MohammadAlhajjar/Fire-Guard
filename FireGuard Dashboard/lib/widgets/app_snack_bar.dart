import '../core/colors.dart';
import 'package:flutter/material.dart';

SnackBar appSnackBar({
  required double screenWidth,
  required String title,
  required bool isSuccess,
}) {
  return SnackBar(
    margin: EdgeInsets.only(left: screenWidth / 1.7),
    behavior: SnackBarBehavior.floating,
    // width: 600,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSuccess ? Colors.green : primaryColor,
          border: Border.all(
            color: isSuccess ? Colors.green : primaryColor,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              width: 80,
              height: 80,
              'assets/images/snack bar logo.png',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
          ],
        )),
  );
}
