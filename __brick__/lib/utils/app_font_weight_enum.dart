import 'dart:ui';

enum FontWeightEnum {
  thin,
  extraLight,
  light,
  regular,
  medium,
  semiBold,
  bold,
  extraBold,
  black,
}

extension FontWeightEnumExtension on FontWeightEnum? {
  FontWeight? get fontWeight {
    switch (this) {
      case FontWeightEnum.thin:
        return FontWeight.w100;
      case FontWeightEnum.extraLight:
        return FontWeight.w200;
      case FontWeightEnum.light:
        return FontWeight.w300;
      case FontWeightEnum.regular:
        return FontWeight.w400;
      case FontWeightEnum.medium:
        return FontWeight.w500;
      case FontWeightEnum.semiBold:
        return FontWeight.w600;
      case FontWeightEnum.bold:
        return FontWeight.w700;
      case FontWeightEnum.extraBold:
        return FontWeight.w800;
      case FontWeightEnum.black:
        return FontWeight.w900;
      default:
        return null;
    }
  }

  String? get description {
    switch (this) {
      case FontWeightEnum.thin:
        return 'Thin';
      case FontWeightEnum.extraLight:
        return 'ExtraLight';
      case FontWeightEnum.light:
        return 'Light';
      case FontWeightEnum.regular:
        return 'Regular';
      case FontWeightEnum.medium:
        return 'Medium';
      case FontWeightEnum.semiBold:
        return 'SemiBold';
      case FontWeightEnum.bold:
        return 'Bold';
      case FontWeightEnum.extraBold:
        return 'ExtraBold';
      case FontWeightEnum.black:
        return 'Black';
      default:
        return null;
    }
  }
}
