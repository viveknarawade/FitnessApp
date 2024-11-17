import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/Firebase/Firestore/Meal/calories._intake.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyCaloriesChart extends StatefulWidget {
  const WeeklyCaloriesChart({super.key});

  @override
  State<WeeklyCaloriesChart> createState() => _WeeklyCaloriesChartState();
}

class _WeeklyCaloriesChartState extends State<WeeklyCaloriesChart> {
  Map<String, String> weeklyCalories = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await CaloriesIntake().getWeeklyCaloriesData();
      setState(() {
        weeklyCalories = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading weekly calories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  TextStyle textStyle() {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  List<FlSpot> _getSpots() {
    final dayOrder = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    List<FlSpot> spots = [];

    for (int i = 0; i < dayOrder.length; i++) {
      final calories = double.tryParse(weeklyCalories[dayOrder[i]] ?? '0') ?? 0;
      // Assuming 2000 calories is 100% for visualization
      final percentage = (calories / 2000) * 100;
      spots.add(FlSpot(i.toDouble(), percentage.clamp(0, 100)));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: LineChart(
          LineChartData(
            minY: 0, // Set minimum Y value to 0
            maxY: 100, // Set maximum Y value to 100
            lineBarsData: [
              LineChartBarData(
                spots: _getSpots(),
                color: Colors.blue,
                isCurved: true,
                curveSmoothness: 0.35,
                preventCurveOverShooting: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              )
            ],
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // Hiding right titles
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final days = [
                      'Sun',
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat'
                    ];
                    if (value >= 0 && value < days.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          days[value.toInt()],
                          style: textStyle(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  interval: 1,
                  reservedSize: 40,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value % 20 == 0) {
                      return Text(
                        '${value.toInt()}%',
                        style: textStyle(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  interval: 20, // Show percentage scale at 20% intervals
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.black.withOpacity(0.5),
                  strokeWidth: 1,
                );
              },
              horizontalInterval: 20, // Set grid lines at 20% intervals
            ),
          ),
        ),
      ),
    );
  }
}
