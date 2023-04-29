import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/themes/app_decoration.dart';

import '../../../themes/app_styles.dart';

class StrokeEmergencyScreen extends StatefulWidget {
  const StrokeEmergencyScreen({super.key});

  @override
  State<StrokeEmergencyScreen> createState() => _StrokeEmergencyScreenState();
}

class _StrokeEmergencyScreenState extends State<StrokeEmergencyScreen> {
  List listOfWhatToDo = [
    {
      "title": "Stay Calm, and wait for Ambulance. ",
      "description":
          "Do not panic. If you have called an ambulance, wait for help to arrive. Do not attempt to drive.",
    },
    {
      "title": "Do not lose conciousness",
      "description":
          "Try to stay awake. If you believe you are losing consciousness, take an aspirin. Try keeping your eyes open.",
    },
    {
      "title": "Importance of CPR ",
      "description":
          "If you are not alone and there is someone to assist you, ask them to perform CPR if your vitals are dropping.",
    },
    {
      "title": "Check for Symprtoms: ",
      "description":
          "Face: If your face is drooping.\n Arm: If your arms feel weak.\nSpeech: Speech difficulties. Then it is Time to call an Ambulance",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteBackground,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Having a Stroke?",
          style: TextStyle(
            color: ColorConstant.bluedark,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorConstant.bluedark,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.home);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: ColorConstant.bluedark,
            ),
          ),
        ],
        backgroundColor: ColorConstant.whiteBackground,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(
            left: 22,
            right: 22,
            bottom: 40,
          ),
          child: Column(
            children: [
              _dailyActivityNotification(
                false,
                "An alert has been sent to your emergency contact.",
              ),
              CallAnAmbulance(onTap: () {}),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  bottom: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "What to do?",
                      style: AppStyle.txtPoppinsSemiBold18Dark,
                    ),
                    Text(
                      "4 Steps",
                      style: TextStyle(
                        color: ColorConstant.bluedark.withOpacity(0.6),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              WhatToDoWidget(
                title: listOfWhatToDo[0]["title"],
                index: "01",
                description: listOfWhatToDo[0]["description"],
              ),
              WhatToDoWidget(
                title: listOfWhatToDo[1]["title"],
                index: "02",
                description: listOfWhatToDo[1]["description"],
              ),
              WhatToDoWidget(
                title: listOfWhatToDo[2]["title"],
                index: "03",
                description: listOfWhatToDo[2]["description"],
              ),
              WhatToDoWidget(
                title: listOfWhatToDo[3]["title"],
                index: "04",
                description: listOfWhatToDo[3]["description"],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dailyActivityNotification(bool isAlertNotification, String message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(
            Icons.info_rounded,
            color: isAlertNotification
                ? ColorConstant.lightRed
                : ColorConstant.warningColor,
            size: 26,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              message,
              style: AppStyle.txtPoppinsSemiBold14LightGray,
            ),
          ),
        ],
      ),
    );
  }
}

class CallAnAmbulance extends StatelessWidget {
  final VoidCallback onTap;
  const CallAnAmbulance({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: ColorConstant.lightRed,
          ),
          borderRadius: BorderRadiusStyle.roundedBorder15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.iconAlert,
              width: 30,
              height: 30,
            ),
            const SizedBox(
              width: 22,
            ),
            Text(
              "Call An Ambulance",
              style: TextStyle(
                color: ColorConstant.lightRed,
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatToDoWidget extends StatelessWidget {
  final String title, description, index;
  const WhatToDoWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.index});

  Widget _dotline() {
    return Container(
      margin: const EdgeInsets.only(left: 14, top: 5),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: ColorConstant.bluedark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        index,
                        style: AppStyle.txtPoppinsSemiBold18Light,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.adjust_sharp,
                        color: ColorConstant.bluedark.withOpacity(0.8),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                  _dotline(),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyle.txtPoppinsSemiBold16Dark,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: ColorConstant.bluedark.withOpacity(0.6),
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
