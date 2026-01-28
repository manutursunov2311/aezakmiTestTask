abstract final class AppAssets {
  static const _assetsPath = 'assets';

  static const backgroundImage ='$_assetsPath/images/background_image.png';

  static const icons = _Icons();
}

class _Icons {
  const _Icons();
  String get assetsPath => AppAssets._assetsPath;

  String get iconArrowBack => '$assetsPath/icons/ic_arrow_back.svg';
  String get iconCheck => '$assetsPath/icons/ic_check.svg';
  String get iconDownload => '$assetsPath/icons/ic_download.svg';
  String get iconErase => '$assetsPath/icons/ic_erase.svg';
  String get iconGallery => '$assetsPath/icons/ic_gallery.svg';
  String get iconLogout => '$assetsPath/icons/ic_logout.svg';
  String get iconPaintRoller => '$assetsPath/icons/ic_paint_roller.svg';
  String get iconPalette => '$assetsPath/icons/ic_palette.svg';
  String get iconPencil => '$assetsPath/icons/ic_pencil.svg';
}