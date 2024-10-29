import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Workoutlinechart extends StatefulWidget {
  const Workoutlinechart({super.key});

  @override
  State<Workoutlinechart> createState() => _WorkoutlinechartState();
}

TextStyle textStyle() {
  return GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700);
}

class _WorkoutlinechartState extends State<Workoutlinechart> {
  // This list will hold the dynamic calories burned data
  List<FlSpot> caloriesData = [
    FlSpot(0, 0), // Sunday
    FlSpot(1, 0), // Monday
    FlSpot(2, 0), // Tuesday
    FlSpot(3, 0), // Wednesday
    FlSpot(4, 0), // Thursday
    FlSpot(5, 0), // Friday
    FlSpot(6, 0), // Saturday
  ];

  // Function to update calories burned data
  void updateCaloriesData(int dayIndex, double calories) {
    setState(() {
      caloriesData[dayIndex] = FlSpot(dayIndex.toDouble(), calories);
    });
  }

  // Example function to simulate user burning calories
  void burnCalories(int dayIndex, double calories) {
    updateCaloriesData(dayIndex, calories);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: caloriesData, // Use dynamic calories data here
                color: Colors.white,
                isCurved: true,
                curveSmoothness: 0.35,
                preventCurveOverShooting: true,
                dotData: FlDotData(
                  show: true,
                  checkToShowDot: (spot, barData) {
                    return false;
                  },
                ),
              ),
            ],
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                          child: Text('0', style: textStyle()),
                        );
                      case 20:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('20', style: textStyle()),
                        );
                      case 40:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('40', style: textStyle()),
                        );
                      case 60:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('60', style: textStyle()),
                        );
                      case 80:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('80', style: textStyle()),
                        );
                      case 100:
                        return Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text('100', style: textStyle()),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                  interval: 20,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sun', style: textStyle()),
                        );
                      case 1:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Mon', style: textStyle()),
                        );
                      case 2:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tue', style: textStyle()),
                        );
                      case 3:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Wed', style: textStyle()),
                        );
                      case 4:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Thu', style: textStyle()),
                        );
                      case 5:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Fri', style: textStyle()),
                        );
                      case 6:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Sat', style: textStyle()),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                  interval: 1,
                  reservedSize: 40,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.5),
                  strokeWidth: 1,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
