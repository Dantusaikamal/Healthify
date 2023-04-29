import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/bloc/auth_bloc/signin_bloc/signin_bloc_state.dart';

import '../../core/utils/color_constants.dart';
import '../../themes/app_decoration.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final double? width, height, buttonPadding;
  final Color labelColor, buttonBgColor;
  final bool enableCustomization, isLoading;
  final EdgeInsetsGeometry margin;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.margin,
    required this.labelColor,
    required this.buttonBgColor,
    required this.onTap,
    this.width,
    this.height,
    this.buttonPadding,
    this.enableCustomization = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: enableCustomization ? width : double.infinity,
        padding: EdgeInsets.all(enableCustomization ? buttonPadding! : 12),
        decoration: BoxDecoration(
            color: buttonBgColor,
            borderRadius: BorderRadiusStyle.roundedBorder15,
            boxShadow: [
              BoxShadow(
                color: ColorConstant.shadowColor,
                blurRadius: 15.0,
                spreadRadius: 5.0,
                offset: const Offset(5, 5),
              ),
            ]),
        child: Center(
          child: isLoading == true
              ? SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: ColorConstant.whiteBackground,
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
