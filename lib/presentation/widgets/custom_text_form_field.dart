import 'package:flutter/material.dart';

import '../../core/utils/color_constants.dart';
import '../../themes/app_decoration.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final bool enablePasswordField;
  final bool passwordVisible;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isObscureText;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final dynamic onChanged;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.enablePasswordField = false,
    this.passwordVisible = false,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.onSubmitted,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.margin,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: isObscureText,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: ColorConstant.bluedark,
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 15,
            minWidth: 15,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
