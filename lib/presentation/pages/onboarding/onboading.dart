// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthify/themes/app_styles.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'data/constants/slider_modal_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LiquidSwipe(
        pages: const [
          SliderScreen(
            pageIndex: 0,
            backgroundColor: Colors.white,
          ),
          SliderScreen(
            pageIndex: 1,
            backgroundColor: Color.fromARGB(255, 102, 191, 251),
          ),
          SliderScreen(
            pageIndex: 2,
            backgroundColor: Color.fromARGB(255, 249, 95, 146),
          ),
          SliderScreen(
            pageIndex: 3,
            backgroundColor: Color.fromARGB(255, 250, 144, 83),
          ),
        ],
        slideIconWidget: const Icon(Icons.arrow_back_ios),
        enableLoop: false,
        enableSideReveal: true,
      ),
    );
  }
}

class SliderScreen extends StatelessWidget {
  final int pageIndex;
  final Color backgroundColor;
  const SliderScreen({
    Key? key,
    required this.pageIndex,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 400,
                child: Image.asset(SliderModalContant.onBoadingData[pageIndex]
                    ["assetImagePath"]),
              ),
              Column(
                children: [
                  Text(
                    SliderModalContant.onBoadingData[pageIndex]["title"],
                    style: AppStyle.txtDMSanBold27,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    SliderModalContant.onBoadingData[pageIndex]["description"],
                    style: AppStyle.txtPoppinsSemiBold18Light,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          pageIndex != 3
              ? Text(
                  SliderModalContant.onBoadingData[pageIndex]["sliderNumber"],
                  style: AppStyle.txtPoppinsBold18Dark,
                  textAlign: TextAlign.center,
                )
              : SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.signInScreen);
                    },
                    child: Text(
                      'Get Started',
                      style: AppStyle.txtPoppinsBold18Dark,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
