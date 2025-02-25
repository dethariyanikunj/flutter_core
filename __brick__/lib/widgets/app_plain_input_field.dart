import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';

class AppPlainInputField extends StatefulWidget {
  const AppPlainInputField({
    super.key,
    this.alignment,
    this.width,
    this.height,
    this.boxDecoration,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxChars,
    this.title,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.focusedFillColor,
    this.filled = true,
    this.validator,
    this.separateTitle = false,
    this.counterVisible,
    this.unFocusOnTapOutside = false,
    this.inputFormatters,
    this.textAlign,
    this.isDense = true,
    this.onTextChanged,
    this.onFieldSubmitted,
  });

  final Alignment? alignment;
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? maxChars;
  final String? title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final Color? focusedFillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final bool separateTitle;
  final bool? counterVisible;
  final bool unFocusOnTapOutside;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool isDense;
  final ValueChanged<String>? onTextChanged;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<AppPlainInputField> createState() => _AppPlainInputFieldState();
}

class _AppPlainInputFieldState extends State<AppPlainInputField> {
  bool isFieldFocused = false;

  @override
  void initState() {
    widget.focusNode?.addListener(() {
      if (mounted) {
        setState(() {
          isFieldFocused = widget.focusNode?.hasFocus ?? false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // dispose controller and focus node at widget side
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: separateTitleAllowed
                ? separateTitleTextFormFieldWidget
                : textFormFieldWidget,
          )
        : separateTitleAllowed
            ? separateTitleTextFormFieldWidget
            : textFormFieldWidget;
  }

  bool get separateTitleAllowed =>
      widget.separateTitle && (widget.title ?? '').trim().isNotEmpty;

  Widget get separateTitleTextFormFieldWidget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: widget.textStyle,
          ),
          SizedBox(
            height: AppDimens.dimensOutlinedInputFieldSeparateTitleSpacing.h,
          ),
          textFormFieldWidget,
        ],
      );

  Widget get textFormFieldWidget => Container(
        width: widget.width ?? double.maxFinite,
        height: widget.height,
        decoration: widget.boxDecoration,
        child: TextFormField(
          cursorColor: AppColors.primary,
          scrollPadding: EdgeInsets.only(
            bottom: Get.mediaQuery.viewInsets.bottom,
          ),
          controller: widget.controller,
          focusNode: widget.focusNode,
          onTapOutside: (event) {
            if (widget.unFocusOnTapOutside) {
              if (widget.focusNode != null) {
                widget.focusNode?.unfocus();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            }
          },
          autofocus: widget.autofocus!,
          style: widget.textStyle,
          obscureText: widget.obscureText!,
          readOnly: widget.readOnly!,
          enableInteractiveSelection: !(widget.readOnly!),
          enableSuggestions: false,
          onTap: () {
            widget.onTap?.call();
          },
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxChars,
          textAlign: widget.textAlign ?? TextAlign.start,
          decoration: decoration,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters ?? [],
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!(value);
            }
          },
          onChanged: (value) {
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(value);
            }
          },
        ),
      );

  InputDecoration get decoration => InputDecoration(
      hintText: widget.hintText ?? '',
      hintStyle: widget.hintStyle,
      prefixIcon: widget.prefix,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      isDense: widget.isDense,
      contentPadding: widget.contentPadding ??
          EdgeInsets.all(
            AppDimens.dimensOutlinedInputFieldContentPadding.h,
          ),
      fillColor: isFieldFocused
          ? (widget.focusedFillColor ?? AppColors.colorWhite)
          : (widget.fillColor ?? AppColors.colorWhite),
      filled: widget.filled,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      counterText: widget.counterVisible == true ? null : '');
}
