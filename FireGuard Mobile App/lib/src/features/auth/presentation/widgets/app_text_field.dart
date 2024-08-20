import 'package:flutter/material.dart';

import '../../../../../core/resource/colors_manager.dart';
import '../../../../../core/resource/styles_manager.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hinText,
    this.hasPrefix = false, required this.controller,
  });
  final String hinText;
  final bool hasPrefix;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: StylesManager.interFontFamilyRegular(
        fontSize: 15,
        color: ColorsManager.darkBlueColor,
      ),
      cursorColor: ColorsManager.darkBlueColor,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: StylesManager.interFontFamilyRegular(
          fontSize: 12,
          color: ColorsManager.grayColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.grayColor,
            width: 1.5,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorsManager.grayColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
