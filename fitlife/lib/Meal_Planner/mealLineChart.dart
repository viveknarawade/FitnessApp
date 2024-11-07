import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Meallinechart extends StatefulWidget {
  const Meallinechart({super.key});

  @override
  State<Meallinechart> createState() => _MeallinechartState();
}

class _MeallinechartState extends State<Meallinechart> {
  TextStyle textStyle() {
    return GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500); // Make sure to return the TextStyle
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 0),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 0),
                  FlSpot(1, 1),
                  FlSpot(2, 1),
                  FlSpot(3, 50),
                  FlSpot(4, 0),
                  FlSpot(5, 30),
                  FlSpot(6, 0),
                 
                ],
                color: Colors.blue,
                isCurved: true,
                curveSmoothness: 0.35,
                preventCurveOverShooting: true,
                dotData: FlDotData(
                  show: true,
                  checkToShowDot: (spot, barData) {
                    return false;
                  },
                ),
              )
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
                          child: Text(
                            '0%',
                            style: textStyle(),
                          ),
                        );
                      case 10:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '20%',
                            style: textStyle(),
                          ),
                        );
                      case 20:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '40%',
                            style: textStyle(),
                          ),
                        );
                      case 30:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '60%',
                            style: textStyle(),
                          ),
                        );
                      case 40:
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '80%',
                            style: textStyle(),
                          ),
                        );
                      case 50:
                        return Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            '100%',
                            style: textStyle(),
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                  interval: 10,
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
                          child: Text(
                            'Mon',
                            style: textStyle(),
                          ),
                        );
                      case 2:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tue',
                            style: textStyle(),
                          ),
                        );
                      case 3:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Wed',
                            style: textStyle(),
                          ),
                        );
                      case 4:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Thu',
                            style: textStyle(),
                          ),
                        );
                      case 5:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Fri',
                            style: textStyle(),
                          ),
                        );
                      case 6:
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sat',
                            style: textStyle(),
                          ),
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
            borderData: FlBorderData(
              show: false, // This hides the border
            ),
            gridData: FlGridData(
              show: true, // Set to true to show grid lines
              drawHorizontalLine:
                  true, // Set to true to show horizontal grid lines
              drawVerticalLine:
                  false, // Set to false to hide vertical grid lines
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.black.withOpacity(0.5),
                  // Set color for horizontal grid lines
                  strokeWidth: 1, // Set stroke width for horizontal grid lines
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
