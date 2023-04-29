import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/presentation/pages/home/home_screen.dart';
import 'package:healthify/presentation/pages/home/notification_screen.dart';
import 'package:healthify/presentation/pages/home/user_profile_screen.dart';
import 'package:healthify/routes/app_routes.dart';

import '../../widgets/custom_bottom_navigation_bar.dart';
import 'analytics_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const AnalyticsScreen(),
    const NotificationScreen(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                  top: 55,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 320,
                    height: 250,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 35,
                          ),
                          child: Text(
                            "Experiencing a Heart Stroke?",
                            style: TextStyle(
                              color: ColorConstant.bluedark,
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SosButton(
                                title: "Yes",
                                onTap: () {
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.pop(context); // close all pop-up
                                  }

                                  Get.toNamed(AppRoutes.strokeEmergencyScreen);
                                },
                              ),
                              SosButton(
                                title: "NO",
                                enableOutlineButton: true,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 110,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 22,
                      right: 22,
                      bottom: 22,
                      top: 30,
                    ),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorConstant.lightRed,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Image.asset(
                        ImageConstant.imgHealthify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[activeIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        activeIndex: activeIndex,
        onPressHome: () {
          setState(() {
            activeIndex = 0;
          });
        },
        onPressPieChart: () {
          setState(() {
            activeIndex = 1;
          });
        },
        onPressSOS: () {
          _showCustomDialog(context);
          // Get.toNamed(
          //   AppRoutes.strokeEmergencyScreen,
          // );
        },
        onPressNotification: () {
          setState(() {
            activeIndex = 2;
          });
        },
        onPressProfile: () {
          setState(() {
            activeIndex = 3;
          });
        },
      ),
    );
  }
}

class SosButton extends StatelessWidget {
  final String title;
  final bool? enableOutlineButton;

  final VoidCallback onTap;

  const SosButton(
      {super.key,
      required this.title,
      this.enableOutlineButton = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: enableOutlineButton == true
              ? Colors.transparent
              : ColorConstant.lightRed,
          border: Border.all(
            width: 2,
            color: ColorConstant.lightRed,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: enableOutlineButton == true
                ? ColorConstant.lightRed
                : ColorConstant.whiteText,
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
