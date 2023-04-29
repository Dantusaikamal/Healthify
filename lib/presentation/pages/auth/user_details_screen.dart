import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/presentation/widgets/export_widgets.dart';
import 'package:healthify/routes/app_routes.dart';

import '../../../themes/app_styles.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String genderSelected = "Male";
  DateTime date = DateTime.now();
  int heightListIndex = 0;
  int height = 0;

  int weightListIndex = 0;
  int weight = 0;

  final int minHeight = 90;
  final int maxHeight = 245;
  static List<int> heightNumberList = [];

  final int minWeight = 20;
  final int maxWeight = 200;
  static List<int> weightNumberList = [];

  @override
  void initState() {
    super.initState();

    for (int i = minHeight; i <= maxHeight; i++) {
      heightNumberList.add(i);
    }

    for (int i = minWeight; i <= maxWeight; i++) {
      weightNumberList.add(i);
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 350,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: 200,
              child: Image.asset(ImageConstant.imgLogoLight),
            ),
            Text(
              "Which one are you?",
              style: AppStyle.txtPoppinsSemiBold22Light,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SelectGenderOption(
                  gender: "Male",
                  genderSelected: genderSelected,
                  imagePath: ImageConstant.imgMaleAvatar,
                  onTap: () {
                    setState(() {
                      genderSelected = "Male";
                    });
                  },
                ),
                SelectGenderOption(
                  gender: "Female",
                  genderSelected: genderSelected,
                  imagePath: ImageConstant.imgFemaleAvatar,
                  onTap: () {
                    setState(() {
                      genderSelected = "Female";
                    });
                  },
                ),
              ],
            ),
            TellUsAboutUserSelf(
              birthday: date.toString().split(" ")[0],
              datePickerOnTap: () => _showDialog(
                SizedBox(
                  height: 50,
                  child: CupertinoDatePicker(
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: date,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    // This is called when the user changes the date.
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => date = newDate);
                    },
                  ),
                ),
              ),
              height: heightNumberList[heightListIndex],
              heightPicker: () => _showDialog(
                SizedBox(
                  height: 50,
                  child: CupertinoPicker(
                    itemExtent: 65,
                    scrollController: FixedExtentScrollController(
                      initialItem: heightListIndex,
                    ),
                    onSelectedItemChanged: (index) =>
                        setState(() => heightListIndex = index),
                    children: heightNumberList.map(
                      (int height) {
                        return Center(
                          child: Text(
                            height.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              weight: weightNumberList[weightListIndex],
              weightPicker: () => _showDialog(
                SizedBox(
                  height: 50,
                  child: CupertinoPicker(
                    itemExtent: 65,
                    scrollController: FixedExtentScrollController(
                      initialItem: weightListIndex,
                    ),
                    onSelectedItemChanged: (index) =>
                        setState(() => weightListIndex = index),
                    children: weightNumberList.map(
                      (int weight) {
                        return Center(
                          child: Text(
                            weight.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            CustomTextButton(
              label: "Next",
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 20,
              ),
              labelColor: ColorConstant.whiteText,
              buttonBgColor: ColorConstant.bluedark,
              onTap: () {
                Get.toNamed(AppRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SelectGenderOption extends StatelessWidget {
  final VoidCallback onTap;
  final String genderSelected, imagePath, gender;

  const SelectGenderOption(
      {super.key,
      required this.onTap,
      required this.genderSelected,
      required this.imagePath,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: genderSelected == gender
                    ? ColorConstant.bluedark
                    : ColorConstant.lightGray,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipOval(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  genderSelected == gender
                      ? Colors.transparent
                      : Colors.white.withOpacity(0.5),
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  imagePath,
                  width: 110,
                  height: 100,
                ),
              ),
            ),
          ),
          Text(
            gender,
            style: genderSelected == gender
                ? AppStyle.txtPoppinsSemiBold18Dark
                : AppStyle.txtPoppinsSemiBold18LightGray,
          )
        ],
      ),
    );
  }
}

class TellUsAboutUserSelf extends StatelessWidget {
  final VoidCallback datePickerOnTap, heightPicker, weightPicker;
  final String birthday;
  final int height, weight;
  const TellUsAboutUserSelf({
    super.key,
    required this.datePickerOnTap,
    required this.birthday,
    required this.height,
    required this.heightPicker,
    required this.weight,
    required this.weightPicker,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 25),
            child: Text(
              "Tell us about yourself",
              style: AppStyle.txtPoppinsSemiBold22Light,
            ),
          ),
          _dataAsFollow("Birthday", birthday, datePickerOnTap),
          const SizedBox(
            height: 20,
          ),
          _dataAsFollow("Height", "${height}cm", heightPicker),
          const SizedBox(
            height: 20,
          ),
          _dataAsFollow("Weight", "${weight}kg", weightPicker),
        ],
      ),
    );
  }

  Widget _dataAsFollow(String title, dataFormat, VoidCallback onTap) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyle.txtPoppinsSemiBold18Dark,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              dataFormat,
              style: AppStyle.txtPoppinsSemiBold18LightBlue,
            ),
          )
        ],
      ),
    );
  }
}
