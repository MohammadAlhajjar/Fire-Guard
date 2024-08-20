class ImagesManager {
  //--------------<<Base Asset Paths>>--------------
  static const String _baseImagesPath = 'assets/images';
  static const String _pngImagesPath = '$_baseImagesPath/png';
  static const String _svgImagesPath = '$_baseImagesPath/svg';
  static const String _iconsPath = '$_baseImagesPath/icons';

  // --------------<<Splash View Asset Paths>>--------------
  // PNG
  static const String splashImage = '$_baseImagesPath/app_logo.png';

  // --------------<<Sign In View Asset Paths>>--------------
  // PNG
  static const String waveSymbolImage = '$_pngImagesPath/wave_symbol.png';

  // --------------<<Home View Asset Paths>>--------------
  // PNG
  static const String mapImage = '$_pngImagesPath/map.png';
  // SVG
  static const String flameVectorSvg = '$_svgImagesPath/flame_vector.svg';
  static const String arrowForwardVectorSvg =
      '$_svgImagesPath/arrow_forward_vector.svg';

  // --------------<<Fire Location View Asset Paths>>--------------

  // SVG
  static const String arrowBackwardVectorSvg =
      '$_svgImagesPath/arrow_backward_vector.svg';

  // --------------<<History View Asset Paths>>--------------
  // PNG
  static const String historyHeaderImage = '$_pngImagesPath/history_header.png';

  // --------------<<Profile View Asset Paths>>--------------
  // PNG
  static const String profileHeaderImage = '$_pngImagesPath/profile_header.png';
  static const String profileImage = '$_pngImagesPath/profile.png';
}
