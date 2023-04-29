import 'package:flutter/material.dart';
import 'package:healthify/core/app_exports.dart';

class AppDecoration {
  static BoxDecoration get fillIndigoWithBorderRadiusBottomLR22 =>
      BoxDecoration(
        color: ColorConstant.bluedark,
        borderRadius: BorderRadiusStyle.customBorderRadiusBottomLR22,
      );

  static BoxDecoration get fillWhiteWithBorderRadiusAndBoxShadow =>
      BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: ColorConstant.fromHex("DBD7D7"),
        ),
        borderRadius: BorderRadiusStyle.roundedBorder12,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.shadowColor,
            blurRadius: 15.0,
            spreadRadius: 5.0,
            offset: const Offset(5, 5),
          ),
        ],
      );

  static BoxDecoration get boxShadowWithWhiteFillAndBorderRadius15 =>
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyle.roundedBorder15,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.shadowColor,
            blurRadius: 15.0,
            spreadRadius: 5.0,
            offset: const Offset(5, 5),
          ),
        ],
      );

  static BoxDecoration get boxShadowWithWhiteFillAndBorderRadius15AllSide =>
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.shadowColor,
            blurRadius: 15.0,
            spreadRadius: 5.0,
            offset: const Offset(5, 5),
          ),
        ],
      );
}

class BorderRadiusStyle {
  static BorderRadius circleBorder22 = BorderRadius.circular(
    getHorizontalSize(
      22.00,
    ),
  );

  static BorderRadius roundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8.00,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12.00,
    ),
  );

  static BorderRadius roundedBorder15 = BorderRadius.circular(
    getHorizontalSize(
      15.00,
    ),
  );

  static BorderRadius roundedBorder3 = BorderRadius.circular(
    getHorizontalSize(
      3.50,
    ),
  );

  static BorderRadius roundedBorder24 = BorderRadius.circular(
    getHorizontalSize(
      24.55,
    ),
  );

  static BorderRadius customBorderTL12 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        12.00,
      ),
    ),
  );

  static BorderRadius customBorderRadiusBottomLR22 = BorderRadius.only(
    bottomLeft: Radius.circular(
      getHorizontalSize(
        22.00,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        22.00,
      ),
    ),
  );

  static BorderRadius roundedBorder1 = BorderRadius.circular(
    getHorizontalSize(
      1.00,
    ),
  );

  static BorderRadius txtCircleBorder8 = BorderRadius.circular(
    8,
  );
}
