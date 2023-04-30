import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/themes/app_decoration.dart';
import 'package:healthify/themes/app_styles.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteBackground,
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteBackground,
        elevation: 0,
        title: Text(
          "Analytics",
          style: TextStyle(
            fontFamily: "Poppins",
            color: ColorConstant.bluedark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            children: [
              BMIWidgetChart(
                onTapViewMore: () {},
                bmiValue: 30,
              ),
              const SizedBox(
                height: 22,
              ),
              sleepingTimeWidget("45 mins"),
              const ActivityProgressChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sleepingTimeWidget(String sleepingTime) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 25,
      ),
      decoration: AppDecoration.boxShadowWithWhiteFillAndBorderRadius15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "sleep".tr,
                style: AppStyle.txtPoppinsBold18Dark,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                sleepingTime,
                style: TextStyle(
                  color: ColorConstant.lightBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
          Image.asset(
            ImageConstant.imgSleeping,
            width: 150,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class ActivityProgressChart extends StatefulWidget {
  const ActivityProgressChart({super.key});

  @override
  State<ActivityProgressChart> createState() => _ActivityProgressChartState();
}

class _ActivityProgressChartState extends State<ActivityProgressChart> {
  List<Color> get availableColors => <Color>[
        ColorConstant.lightDarkBlue,
        ColorConstant.lightPurple,
      ];

  Color barBackgroundColor = ColorConstant.lightGray.withOpacity(0.25);
  Color barColor = Colors.yellow.withOpacity(0.5);
  Color touchedBarColor = ColorConstant.bluedark.withOpacity(0.5);

  Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Activity Progress",
                style: TextStyle(
                  color: ColorConstant.bluedark,
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.lightSkyBlue,
                        ColorConstant.lightDarkBlue,
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weekly",
                        style: TextStyle(
                          color: ColorConstant.whiteText,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: ColorConstant.whiteBackground,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 40,
            ),
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: BarChart(
              mainBarData(),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    List<Color> colors = const [],
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          gradient: LinearGradient(colors: colors),
          toY: isTouched ? y + 1 : y,
          color: isTouched ? touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              10,
              isTouched: i == touchedIndex,
              colors: [ColorConstant.lightSkyBlue, ColorConstant.lightDarkBlue],
            );
          case 1:
            return makeGroupData(
              1,
              6.5,
              isTouched: i == touchedIndex,
              colors: [ColorConstant.lightpink, ColorConstant.lightPurple],
            );
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex, colors: [
              ColorConstant.lightSkyBlue,
              ColorConstant.lightDarkBlue
            ]);
          case 3:
            return makeGroupData(
              3,
              7.5,
              isTouched: i == touchedIndex,
              colors: [ColorConstant.lightpink, ColorConstant.lightPurple],
            );
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex, colors: [
              ColorConstant.lightSkyBlue,
              ColorConstant.lightDarkBlue
            ]);
          case 5:
            return makeGroupData(
              5,
              11.5,
              isTouched: i == touchedIndex,
              colors: [ColorConstant.lightpink, ColorConstant.lightPurple],
            );
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex, colors: [
              ColorConstant.lightSkyBlue,
              ColorConstant.lightDarkBlue
            ]);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: ColorConstant.bluedark.withOpacity(0.7),
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              TextStyle(
                color: ColorConstant.whiteText,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

class BMIWidgetChart extends StatelessWidget {
  final VoidCallback onTapViewMore;
  final double bmiValue;
  const BMIWidgetChart(
      {super.key, required this.onTapViewMore, required this.bmiValue});

  final int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 22,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 30,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(ImageConstant.imgBannerDots),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConstant.lightSkyBlue,
            ColorConstant.lightDarkBlue,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BMI (Body Mass Index)",
                style: TextStyle(
                  color: ColorConstant.whiteText,
                  fontSize: 15,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You are under weight.",
                style: TextStyle(
                  color: ColorConstant.whiteText,
                  fontFamily: "Poppins",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: onTapViewMore,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.lightpink,
                        ColorConstant.lightPurple,
                      ],
                    ),
                  ),
                  child: Text(
                    "View More",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.whiteText,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 60),
            width: 10,
            height: 10,
            child: PieChart(
              PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: [
                  PieChartSectionData(
                    value: 100,
                    color: ColorConstant.whiteBackground,
                    radius: 60,
                    titleStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.whiteText,
                    ),
                  ),
                  PieChartSectionData(
                    value: bmiValue,
                    title: "$bmiValue%",
                    color: ColorConstant.lightPurple,
                    radius: 70,
                    titleStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.whiteText,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
