import 'package:flutter/material.dart';
import 'package:healthify/core/app_exports.dart';

import '../../../themes/app_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notificationItems = [
    {
      "title": "You haven't moved since two hours",
      "subtitle": "About 6 hours ago",
      "image": ImageConstant.imgExercise,
    },
    {
      "title": "You haven't moved since two hours",
      "subtitle": "About 13 hours ago",
      "image": ImageConstant.imgExercise,
    },
    {
      "title": "High Heart rate - 140 BPM!",
      "subtitle": "1 day ago",
      "image": ImageConstant.imgHightHeartRate,
    },
    {
      "title": "Your daily remainder to work out",
      "subtitle": "1 day ago",
      "image": ImageConstant.imgExercise,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteBackground,
      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(
            color: ColorConstant.bluedark,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: ColorConstant.bluedark,
              size: 30,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: ColorConstant.whiteBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 12.0, top: 22),
        child: notificationItems.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: notificationItems.length,
                itemBuilder: (BuildContext context, int index) {
                  {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width:
                                notificationItems.length == index + 1 ? 0 : 2,
                            color: ColorConstant.lightGray.withOpacity(0.5),
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          notificationItems[index]["title"],
                          style: AppStyle.txtPoppinsWithDefaultSizeW500,
                        ),
                        subtitle: Text(
                          notificationItems[index]["subtitle"],
                          style:
                              AppStyle.txtPoppinsWithDefaultSizeLightGrayW500,
                        ),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteBackground,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                              notificationItems[index]['image'].toString()),
                        ),
                      ),
                    );
                  }
                },
              )
            : SizedBox(
                child: Center(
                  child: Image.asset(
                    ImageConstant.imgNotification,
                  ),
                ),
              ),
      ),
    );
  }
}
