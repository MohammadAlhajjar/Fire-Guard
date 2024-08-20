import 'package:fire_guard_app/core/resource/strings_manager.dart';
import 'package:flutter/material.dart';

import '../resource/colors_manager.dart';
import '../resource/images_manager.dart';
import '../resource/styles_manager.dart';

class AppLogoAndNameWidget extends StatelessWidget {
  const AppLogoAndNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImagesManager.splashImage),
        Text(
          StringsManager.appNamText,
          style: StylesManager.interFontFamilyExtraBold(
            fontSize: 26,
            color: ColorsManager.primaryColor,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
