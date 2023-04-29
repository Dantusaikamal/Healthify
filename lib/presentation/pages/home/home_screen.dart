import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthify/core/app_exports.dart';
import 'package:healthify/routes/app_routes.dart';
import 'package:healthify/themes/app_decoration.dart';
import 'package:healthify/themes/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAlertNotification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteBackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 22,
                right: 22,
                top: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hello,",
                    style: AppStyle.txtPoppinsSemiBold28Light,
                  ),
                  Text(
                    "Pavan",
                    style: AppStyle.txtPoppinsBold28Dark,
                  ),
                  _dailyActivityNotification(
                    isAlertNotification,
                    "You haven’t been physically active today.",
                  ),
                  DailyActivityRating(
                    timeLine: "3 days ago",
                    onTapRefresh: () {},
                    heartRating: 78,
                    exerciseRating: 24,
                    walkingRating: 10,
                    sleepRating: 8,
                  ),
                  const ActivityStatus(),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Health Corner",
                    style: AppStyle.txtPoppinsSemiBold16DarkGray,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HealthCornerCard(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.healthCornerScreen,
                        );
                      },
                      imagePath: ImageConstant.imgHealthCorner2,
                      description: "10 Tips for a Healthy heart",
                    ),
                    HealthCornerCard(
                      onTap: () {},
                      imagePath: ImageConstant.imgHealthCorner2,
                      description: "10 Tips for a Healthy heart",
                    ),
                    HealthCornerCard(
                      onTap: () {},
                      imagePath: ImageConstant.imgHealthCorner2,
                      description: "10 Tips for a Healthy heart",
                    ),
                  ],
                ),
              ),
            )
          ],
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

class HealthCornerCard extends StatelessWidget {
  final String imagePath, description;
  final VoidCallback onTap;
  const HealthCornerCard({
    super.key,
    required this.imagePath,
    required this.description,
    required this.onTap,
  });
  final double cardWidth = 250;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: ColorConstant.whiteBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.shadowColor,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        width: cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: cardWidth,
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 3, color: ColorConstant.whiteBackground),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: cardWidth,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorConstant.lightGray,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      // child: Image.asset(name),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sang Dong-Min",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Sep 9, 2022",
                          style: TextStyle(
                            color: ColorConstant.gray,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(ImageConstant.iconPaperPlane),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DailyActivityRating extends StatelessWidget {
  final String timeLine;
  final int heartRating, exerciseRating, walkingRating, sleepRating;
  final VoidCallback onTapRefresh;

  const DailyActivityRating(
      {super.key,
      required this.timeLine,
      required this.onTapRefresh,
      required this.heartRating,
      required this.exerciseRating,
      required this.walkingRating,
      required this.sleepRating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              timeLine,
              style: AppStyle.txtPoppinsSemiBold16DarkGray,
            ),
            IconButton(
              onPressed: onTapRefresh,
              icon: Icon(
                Icons.refresh_rounded,
                color: ColorConstant.bluedark.withOpacity(0.8),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingShowCaseCard(
              cardColor: ColorConstant.lightRed,
              icon: Icon(
                Icons.monitor_heart_outlined,
                color: ColorConstant.lightRed,
              ),
              title: "Heart Rate",
              measure: "bpm",
              rating: heartRating,
            ),
            RatingShowCaseCard(
              cardColor: ColorConstant.pupuleColor,
              icon: Icon(
                Icons.speed_outlined,
                color: ColorConstant.pupuleColor,
              ),
              title: "Exercise",
              measure: "min",
              rating: exerciseRating,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingShowCaseCard(
              cardColor: ColorConstant.greenColor,
              icon: Icon(
                Icons.flag_outlined,
                color: ColorConstant.greenColor,
              ),
              title: "Walking",
              measure: "km",
              rating: walkingRating,
            ),
            RatingShowCaseCard(
              cardColor: ColorConstant.blueColor,
              icon: Icon(
                Icons.night_shelter_sharp,
                color: ColorConstant.blueColor,
              ),
              title: "Sleep",
              measure: "hrs",
              rating: sleepRating,
            )
          ],
        )
      ],
    );
  }
}

class RatingShowCaseCard extends StatelessWidget {
  final Color cardColor;
  final Widget icon;
  final String title, measure;
  final int rating;

  const RatingShowCaseCard(
      {super.key,
      required this.cardColor,
      required this.icon,
      required this.title,
      required this.measure,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          color: cardColor.withOpacity(0.2),
          borderRadius: BorderRadiusStyle.roundedBorder15,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Wrap(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: cardColor,
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  rating.toString(),
                  style: TextStyle(
                    color: cardColor,
                    fontFamily: "Poppins",
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  measure,
                  style: TextStyle(
                    color: cardColor,
                    fontSize: 18,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ActivityStatus extends StatelessWidget {
  const ActivityStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Heart Rate",
            style: AppStyle.txtPoppinsSemiBold16DarkGray,
          ),
          const SizedBox(
            height: 22,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: const LineChartWidget(),
          )
        ],
      ),
    );
  }
}

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<Color> gradientColors = [
    ColorConstant.greenColor,
    ColorConstant.blueColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg
                    ? ColorConstant.greenColor
                    : ColorConstant.greenColor.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '86';
        break;
      case 3:
        text = '98';
        break;
      case 5:
        text = '80';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

// fromHex("#92A3FD").withOpacity(0.3)
  LineChartData mainData() {
    return LineChartData(
      backgroundColor: ColorConstant.greenColor.withOpacity(0.2),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorConstant.lightBlue.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ColorConstant.lightBlue.withOpacity(0.2),
            strokeWidth: 1,
          );
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
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d).withOpacity(0.0),
        ),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      backgroundColor: ColorConstant.greenColor.withOpacity(0.2),
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        verticalInterval: 1,
        horizontalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
