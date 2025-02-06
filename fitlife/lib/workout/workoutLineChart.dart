import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Firebase/Firestore/workout/calories_burn.dart';

class WorkoutLineChart extends StatefulWidget {
  const WorkoutLineChart({super.key});

  @override
  State<WorkoutLineChart> createState() => _WorkoutLineChartState();
}

class _WorkoutLineChartState extends State<WorkoutLineChart> {
  Map<String, String> weeklyCalories = {};
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() => isLoading = true);
      final data = await CaloriesBurn().getWeeklyCaloriesBurnData();
      log("---------------------------------data--------------$data");
      setState(() {
        weeklyCalories = data;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      debugPrint('Error loading weekly calories: $e');
    }
  }

  TextStyle textStyle(
      {Color? color, double? fontSize, required FontWeight fontWeight}) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w500,
      color: color ?? Colors.black87,
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
    return List.generate(dayOrder.length, (i) {
      final calories = double.tryParse(weeklyCalories[dayOrder[i]] ?? '0') ?? 0;
      final percentage = (calories / 2000) * 100;
      return FlSpot(
        i.toDouble(),
        percentage.clamp(0, 100),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60),
            Text(
              'Failed to load calories data',
              style: textStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: loadData,
              child:
                  Text('Retry', style: textStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadData,
      color: Colors.blue,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: _getSpots(),
                    color: Colors.blue.shade600,
                    isCurved: true,
                    curveSmoothness: 0.4,
                    preventCurveOverShooting: true,
                    barWidth: 4,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: Colors.blue.shade600,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade200.withOpacity(0.5),
                          Colors.blue.shade50.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
                titlesData: FlTitlesData(
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(days[value.toInt()],
                              style: textStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        );
                      },
                      interval: 1,
                      reservedSize: 40,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return value % 20 == 0
                            ? Text('${value.toInt()}%',
                                style: textStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                            : const SizedBox.shrink();
                      },
                      interval: 20,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
