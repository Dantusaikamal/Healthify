import 'package:flutter/material.dart';
import 'package:healthify/core/app_exports.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int activeIndex;
  final VoidCallback onPressHome,
      onPressPieChart,
      onPressSOS,
      onPressNotification,
      onPressProfile;

  const CustomBottomNavigationBar(
      {super.key,
      required this.activeIndex,
      required this.onPressHome,
      required this.onPressPieChart,
      required this.onPressSOS,
      required this.onPressNotification,
      required this.onPressProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _customButtonIcon(
            onPressHome,
            Image.asset(
              activeIndex == 0
                  ? ImageConstant.iconHomeDark
                  : ImageConstant.iconHomeLight,
              fit: BoxFit.contain,
            ),
          ),
          _customButtonIcon(
            onPressPieChart,
            Image.asset(
              activeIndex == 1
                  ? ImageConstant.iconPieChartDark
                  : ImageConstant.iconPieChartLight,
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: onPressSOS,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: ColorConstant.lightRed,
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
              child: Center(
                child: Image.asset(
                  ImageConstant.imgHealthify,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ),
          _customButtonIcon(
            onPressNotification,
            Image.asset(
              activeIndex == 2
                  ? ImageConstant.iconNotificationDark
                  : ImageConstant.iconNotificationLight,
              fit: BoxFit.contain,
            ),
          ),
          _customButtonIcon(
            onPressProfile,
            Image.asset(
              activeIndex == 3
                  ? ImageConstant.iconPersonDark
                  : ImageConstant.iconPersonLight,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }

  Widget _customButtonIcon(VoidCallback onPress, Widget icon) {
    return IconButton(
      onPressed: onPress,
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 24,
        width: 24,
        child: icon,
      ),
    );
  }
}
