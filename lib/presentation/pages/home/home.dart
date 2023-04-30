import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_event.dart';
import 'package:healthify/bloc/home/get_user_data/fetch_bloc_state.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/presentation/pages/home/home_screen.dart';
import 'package:healthify/presentation/pages/home/notification_screen.dart';
import 'package:healthify/presentation/pages/home/user_profile_screen.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
    HomeScreen(),
    const AnalyticsScreen(),
    const NotificationScreen(),
    const UserProfileScreen(),
  ];

  String userName = "";
  late FetchUserDataBloc fetchUserDataBloc;

  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: dotenv.env['ACCOUNT_SID'].toString(),
      authToken: dotenv.env['AUTH_TOKEN'].toString(),
      twilioNumber: dotenv.env['TWILIO_NUMBER'].toString());

  @override
  void initState() {
    super.initState();
    fetchUserDataBloc = FetchUserDataBloc();
    fetchUserDataBloc.add(const GetUserData());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void sendSoS() async {
    Position position = await _determinePosition();

    String emergencyContactNumber1 = "+918688668145";

    String location =
        'Their location: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    twilioFlutter.sendSMS(
        toNumber: emergencyContactNumber1,
        messageBody:
            'SOS! Emergency alert from team healthify.\n$userName might be suffering from a heart Stroke.\n $location');
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
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.transparent,
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: -10,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: ColorConstant.whiteBackground,
                        ),
                      ),
                      Center(
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          padding: const EdgeInsets.only(
                              top: 30.0, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SosButton(
                                title: "Yes",
                                onTap: () {
                                  sendSoS();
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.pop(context); // close all pop-up
                                    Future.delayed(const Duration(seconds: 3));
                                    Get.toNamed(
                                        AppRoutes.strokeEmergencyScreen);
                                  }
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => fetchUserDataBloc,
        child: BlocListener<FetchUserDataBloc, FetchUserDataBlocState>(
          listener: (context, state) {
            if (state is FetchingDataSuccess) {
              setState(() {
                userName = state.user.fullName!;
              });
            }
          },
          child: screens[activeIndex],
        ),
      ),
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
