import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/core/constants/enums.dart';
import 'package:healthify/core/helper_methods.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/themes/app_decoration.dart';
import 'package:healthify/themes/app_styles.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteBackground,
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteBackground,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Logout") {
                removeItemFromSharedPreferences(AuthState.authToken.toString());
                removeItemFromSharedPreferences(
                    AuthState.authenticated.toString());

                Get.offAndToNamed(AppRoutes.signInScreen);
              }
            },
            icon: Icon(
              Icons.more_horiz,
              color: ColorConstant.bluedark,
              size: 30,
            ),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: "Logout",
                  child: Text(
                    "Logout",
                  ),
                )
              ];
            },
          )
        ],
        title: Text(
          "Profile",
          style: TextStyle(
            color: ColorConstant.bluedark,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          margin: const EdgeInsets.only(top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            ImageConstant.imgFemaleAvatar,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        const Text(
                          "Pavan Kumar",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: 35,
                      decoration: BoxDecoration(
                        color: ColorConstant.bluedark,
                        borderRadius: BorderRadiusStyle.roundedBorder15,
                      ),
                      child: Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: ColorConstant.whiteText,
                            fontFamily: "Poppins",
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ratingCard(
                      "180",
                      "cm",
                      "Height",
                    ),
                    _ratingCard(
                      "65",
                      "kg",
                      "Weight",
                    ),
                    _ratingCard(
                      "22",
                      "yo",
                      "Age",
                    ),
                  ],
                ),
              ),
              AccountWidget(
                onTapPersonalData: () {},
                onTapEmergencyContact: () {},
                onTapAcitvityHistory: () {},
                onTapSetRemainder: () {},
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration:
                    AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: AppStyle.txtPoppinsBold18Dark,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              ImageConstant.iconOutlineNotification,
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            Text(
                              "Pop-up Notification",
                              style: TextStyle(
                                color: ColorConstant.bluedark.withOpacity(0.7),
                                fontSize: 15.5,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          activeColor: ColorConstant.bluedark,
                          inactiveThumbColor:
                              ColorConstant.bluedark.withOpacity(0.8),
                          inactiveTrackColor:
                              ColorConstant.bluedark.withOpacity(0.5),
                          value: isNotification,
                          onChanged: (val) {
                            setState(() {
                              isNotification = !isNotification;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              OtherWidget(
                onTapContactUs: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingCard(String rating, measure, title) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 3.7,
      decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
      child: Column(
        children: [
          Text(
            "$rating $measure",
            style: TextStyle(
              color: ColorConstant.bluedark,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "$title",
            style: AppStyle.txtPoppinsWithDefaultSizeLightGrayW500,
          ),
        ],
      ),
    );
  }
}

class OtherWidget extends StatelessWidget {
  final VoidCallback onTapContactUs;
  const OtherWidget({super.key, required this.onTapContactUs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Other",
            style: AppStyle.txtPoppinsBold18Dark,
          ),
          const SizedBox(
            height: 22,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.email_outlined,
            ),
            title: "Contact Us",
            onTap: onTapContactUs,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.policy_outlined,
            ),
            title: "Privacy Policy",
            onTap: onTapContactUs,
          ),
        ],
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  final VoidCallback onTapPersonalData,
      onTapEmergencyContact,
      onTapAcitvityHistory,
      onTapSetRemainder;
  const AccountWidget(
      {super.key,
      required this.onTapPersonalData,
      required this.onTapEmergencyContact,
      required this.onTapAcitvityHistory,
      required this.onTapSetRemainder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Account",
            style: AppStyle.txtPoppinsBold18Dark,
          ),
          const SizedBox(
            height: 22,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.person_outline_outlined,
            ),
            title: "Personal Data",
            onTap: onTapPersonalData,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconContact,
            ),
            title: "Emergency Contact",
            onTap: onTapEmergencyContact,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconPieChart,
            ),
            title: "Activity History",
            onTap: onTapAcitvityHistory,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconOutlineNotification,
            ),
            title: "Set Remainder",
            onTap: onTapSetRemainder,
          ),
        ],
      ),
    );
  }
}

class ItemCardWidget extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final VoidCallback onTap;
  const ItemCardWidget(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leadingIcon,
                const SizedBox(
                  width: 22,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: ColorConstant.bluedark.withOpacity(0.7),
                    fontSize: 15.5,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: ColorConstant.bluedark.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
