import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Firebase/Firestore/workout/calories_burn.dart';

class LineChartWorkout extends StatefulWidget {
  @override
  State<LineChartWorkout> createState() => _LineChartWorkoutState();
}

class _LineChartWorkoutState extends State<LineChartWorkout> {
  Map<String, String> weeklyCalories = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await CaloriesBurn().getWeeklyCaloriesBurnData();
      if (mounted) setState(() {
        weeklyCalories = data;
        isLoading = false;
      });
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: _getSpots(),
            color: Colors.white,
            barWidth: 3,
            isCurved: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: Colors.blue[100]!,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
        ],
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) => 
            FlLine(color: Colors.white.withOpacity(0.2), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: _bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: _leftTitleWidgets,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    if (value >= 0 && value < days.length) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          days[value.toInt()],
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    if (value % 20 == 0) {
      return Text(
        '${value.toInt()}%',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  List<FlSpot> _getSpots() {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return List.generate(days.length, (i) {
      final calories = double.tryParse(weeklyCalories[days[i]] ?? '0') ?? 0;
      return FlSpot(i.toDouble(), (calories / 2000 * 100).clamp(0, 100));
    });
  }
}