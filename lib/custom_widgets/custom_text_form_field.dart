import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/theme/app.colors.dart';
import '../utils/theme/app.typography.dart';

class CustomTextFormField extends StatefulWidget {
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String val)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function(String val)? onChanged;
  final TextEditingController textController;
  final String? hintText;
  final double? height;
  final double? width;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? label;
  final bool? autoFocus;
  final double? textFieldHeight;
  final Function()? onTap;
  final bool? isDense;
  final BoxConstraints? prefixIconSize;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? errorText;
  final int? minLine;
  final bool isNeedVirtualKeyBoard;
  final int? currentCursorPosition;
  final Function(int cursorPosition)? onCursorPositionChanged;
  final String? title;
  final double? titleFontSize;
  final bool isPassword;
  final bool? isSpace;
  final TextEditingController? controller;
  final Function(String value)? onchangeText;

  final int? maxLine;

  final int? maxLength;

  final Color? hintTextColors;
  final Color? textFieldTextColor;
  final Color? titleColor;
  final Color? hintTextBgColor;
  final Color? containerOutLineColor;
  final double? borderRadius;
  final bool? isEdit;
  final Color? textColor;
  final EdgeInsetsGeometry? textFieldContainerPadding;
  final Function(bool val)? onFocusChanged;

  final TextInputType? textInputType;
  final bool? isRequired;
  final bool? addIcon;
  final bool? isEnable;
  final EdgeInsetsGeometry? containerMargin;
  final Function()? onSubmit;
  final Color? backgroundColor;
  final FontWeight? titleFontWeight;
  final Widget? prefixIcon;

  final BoxConstraints? suffixIconSize;
  final bool listenOtherKeyBordOnChanged;
  final Color? cursorColor;
  final InputBorder? border;
  final Decoration? decoration;
  final bool autofocus;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField(
      {super.key,
      this.initialValue,
      this.onFieldSubmitted,
      this.contentPadding,
      this.textAlign,
      this.hintText,
      this.keyboardType,
      this.maxLines,
      this.suffixIcon,
      this.textFieldHeight,
      this.label,
      this.width,
      this.onTap,
      this.height,
      this.focusNode,
      this.autoFocus,
      this.textInputAction,
      this.onEditingComplete,
      this.errorText,
      this.minLine,
      this.onChanged,
      this.isDense,
      this.prefixIconSize,
      required this.textController,
      this.title,
      this.isPassword = false,
      this.controller,
      this.hintTextColors,
      this.titleColor,
      this.hintTextBgColor,
      this.maxLine,
      this.onchangeText,
      this.borderRadius,
      this.containerOutLineColor,
      this.isEdit = true,
      this.textColor,
      this.textFieldContainerPadding,
      this.onFocusChanged,
      this.textInputType,
      this.isRequired,
      this.addIcon,
      this.containerMargin,
      this.isEnable = true,
      this.isNeedVirtualKeyBoard = true,
      this.currentCursorPosition,
      this.onCursorPositionChanged,
      this.maxLength,
      this.isSpace = false,
      this.onSubmit,
      this.backgroundColor,
      this.textFieldTextColor,
      this.titleFontWeight,
      this.prefixIcon,
      this.suffixIconSize,
      this.listenOtherKeyBordOnChanged = true,
      this.titleFontSize,
      this.cursorColor,
      this.border,
      this.decoration,
      this.autofocus = false,
      this.inputFormatters,
      this.labelText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.textFieldHeight,
          width: widget.width,
          child: TextFormField(
            textAlign: widget.textAlign ?? TextAlign.start,
            controller: widget.textController,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onFieldSubmitted: widget.onFieldSubmitted,
            maxLines: widget.maxLines,
            autofocus: widget.autoFocus ?? false,
            textInputAction: widget.textInputAction,
            onEditingComplete: widget.onEditingComplete,
            onChanged: widget.onChanged,
            cursorColor: AppColors.textBlack,
            onTap: widget.onTap,
            minLines: widget.minLine,
            enabled: widget.isEnable,
            cursorWidth: 1,
            style: TextStyle(color: widget.textColor ?? AppColors.appBlack),
            decoration: InputDecoration(
              contentPadding: widget.contentPadding ??
                  EdgeInsets.all(widget.isDense == true ? 5 : 0),
              prefixIcon: widget.prefixIcon,
              isDense: widget.isDense ?? false,
              hintText: widget.hintText ?? "",
              label: widget.label,
              labelText: widget.labelText,
              labelStyle: _textFormLabelStyle(widget.focusNode),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.appGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.appPrimary),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: AppColors.appGrey),
              ),
              hintStyle:
                  AppTypography.menuTitle.copyWith(color: AppColors.appGrey),
              suffixIcon: widget.suffixIcon,
            ),
            inputFormatters: widget.inputFormatters ?? [],
          ),
        ),
        if (widget.errorText != null)
          ErrorFieldDisplayWidget(
            errorText: widget.errorText!,
          ),
      ],
    );
  }
}

TextStyle _textFormLabelStyle(FocusNode? focusNode) {
  return AppTypography.menuTitle.copyWith(
      color: focusNode?.hasFocus == true
          ? AppColors.appPrimary
          : AppColors.appGrey);
}

class ErrorFieldDisplayWidget extends StatelessWidget {
  final String errorText;
  const ErrorFieldDisplayWidget({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 2,
        ),
        Text(
          errorText,
          style: const TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
