import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_event.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_state.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/core/constants/enums.dart';
import 'package:healthify/core/helper_methods.dart';
import 'package:healthify/helper/lang_controller.dart';
import 'package:healthify/models/user_model.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/themes/app_decoration.dart';
import 'package:healthify/themes/app_styles.dart';
import 'package:translator/translator.dart';

const List<String> list = <String>['English', 'Hindi', 'Telugu', 'Marathi'];

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isNotification = true;
  late FetchUserDataBloc fetchUserDataBloc;
  final translator = GoogleTranslator();

  @override
  void initState() {
    super.initState();
    fetchUserDataBloc = FetchUserDataBloc();
    fetchUserDataBloc.add(const GetUserData());
  }

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
          "profile".tr,
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
          child: BlocProvider(
            create: (_) => fetchUserDataBloc,
            child: BlocBuilder<FetchUserDataBloc, FetchUserDataBlocState>(
              builder: (context, state) {
                if (state is FetchingDataSuccess) {
                  return _profileContent(state.user);
                }

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.bluedark,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileContent(UserModel userModel) {
    return Column(
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
                      ImageConstant.imgMaleAvatar,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Text(
                    userModel.fullName!,
                    style: const TextStyle(
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
                userModel.height.toString(),
                "cm",
                "height".tr,
              ),
              _ratingCard(
                userModel.weight.toString(),
                "kg",
                "weight".tr,
              ),
              _ratingCard(
                "22",
                "yo",
                "age".tr,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preferences",
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
                    inactiveThumbColor: ColorConstant.bluedark.withOpacity(0.8),
                    inactiveTrackColor: ColorConstant.bluedark.withOpacity(0.5),
                    value: isNotification,
                    onChanged: (val) {
                      setState(() {
                        isNotification = !isNotification;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          ImageConstant.iconLanguage,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "languages".tr,
                        style: TextStyle(
                          color: ColorConstant.bluedark.withOpacity(0.7),
                          fontSize: 15.5,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                  const CustomDropdownButton(),
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

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String dropdownValue = list.first;
  LangController langController = Get.put(LangController());

  updateLocale(Locale locale, BuildContext context) {
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: TextStyle(color: ColorConstant.bluedark),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });

        if (value == "English") {
          updateLocale(const Locale("en", "US"), context);
          langController.setLanguagecode("en");
        } else if (value == "Hindi") {
          updateLocale(const Locale("hi", "IN"), context);
          langController.setLanguagecode("hi");
        } else if (value == "Telugu") {
          updateLocale(const Locale("te", "IN"), context);
          langController.setLanguagecode("te");
        } else if (value == "Marathi") {
          updateLocale(const Locale("mr", "IN"), context);
          langController.setLanguagecode("mr");
        }
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15.5,
              color: ColorConstant.bluedark.withOpacity(0.7),
            ),
          ),
        );
      }).toList(),
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
            "other".tr,
            style: AppStyle.txtPoppinsBold18Dark,
          ),
          const SizedBox(
            height: 22,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.email_outlined,
            ),
            title: "contactUs".tr,
            onTap: onTapContactUs,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.policy_outlined,
            ),
            title: "privacy".tr,
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
            "account".tr,
            style: AppStyle.txtPoppinsBold18Dark,
          ),
          const SizedBox(
            height: 22,
          ),
          ItemCardWidget(
            leadingIcon: const Icon(
              Icons.person_outline_outlined,
            ),
            title: "data".tr,
            onTap: onTapPersonalData,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconContact,
            ),
            title: "contacts".tr,
            onTap: onTapEmergencyContact,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconPieChart,
            ),
            title: "history".tr,
            onTap: onTapAcitvityHistory,
          ),
          ItemCardWidget(
            leadingIcon: Image.asset(
              ImageConstant.iconOutlineNotification,
            ),
            title: "remainders".tr,
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
