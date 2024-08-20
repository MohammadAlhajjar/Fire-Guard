import 'package:flutter/material.dart';

import '../../../../../core/resource/images_manager.dart';
import '../../../../../core/resource/strings_manager.dart';
import '../../../../../core/resource/styles_manager.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    super.key,
    required this.fontSize,
    required this.imageSize,
  });
  final double fontSize;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: StringsManager.welcomeHeroesText,
            style: StylesManager.interFontFamilyBold(
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(
              width: 5,
            ),
          ),
          WidgetSpan(
            child: Image.asset(
              height: imageSize,
              ImagesManager.waveSymbolImage,
            ),
          ),
        ],
      ),
    );
  }
}
