import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.onPressed,
    this.buttonStyle,
    this.alignment,
    this.buttonTextStyle,
    this.margin,
    this.isDisabled,
    this.height,
    this.width,
    this.buttonRowMainAxisAlignment,
    required this.text,
  });

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final Alignment? alignment;
  final TextStyle? buttonTextStyle;
  final EdgeInsets? margin;
  final bool? isDisabled;
  final double? height;
  final double? width;
  final String text;
  final MainAxisAlignment? buttonRowMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget)
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: height ?? AppDimens.dimensButtonHeight.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle ?? AppButtonStyles().outlinedButtonTheme.style,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment:
                buttonRowMainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Text(
                text,
                style: buttonTextStyle ??
                    AppButtonStyles()
                        .outlinedButtonTheme
                        .style
                        ?.textStyle
                        ?.resolve(
                          WidgetState.values.toSet(),
                        ),
              ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
