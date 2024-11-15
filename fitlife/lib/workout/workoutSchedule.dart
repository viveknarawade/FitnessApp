import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Workoutschedule extends StatefulWidget {
  const Workoutschedule({super.key});
  @override
  State createState() => _WorkoutState();
}

class _WorkoutState extends State {
  DateTime selectedDate = DateTime.now();
  List dateList = [];
  List<Map<String, String>> timeSlots = [];
  DateTime currentMonth = DateTime.now();

  void initState() {
    super.initState();
    _generateDateList();
    _generateTimeSlots();
  }

  void _generateDateList() {
    dateList.clear();
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      dateList.add(DateTime(currentMonth.year, currentMonth.month, i));
    }
  }

  void _generateTimeSlots() {
    timeSlots.clear();
    DateTime startTime =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 6, 0);
    DateTime endTime = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 20, 0);

    while (startTime.isBefore(endTime)) {
      String formattedTime = DateFormat('hh:mm a').format(startTime);
      String workout = "";
      if (formattedTime == "07:00 AM") {
        workout = "Ab Workoutschedule";
      } else if (formattedTime == "09:00 AM") {
        workout = "Upperbody Workoutschedule";
      } else if (formattedTime == "03:00 PM") {
        workout = "Lowerbody Workoutschedule";
      }
      timeSlots.add({"time": formattedTime, "workout": workout});
      startTime = startTime.add(const Duration(hours: 1));
    }
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      _generateDateList();
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      _generateDateList();
    });
  }

  Widget buildTimeSlot(String time, String workout) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: workout.isNotEmpty
                    ? Colors.purple[100]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                workout,
                style: TextStyle(
                    fontSize: 16,
                    color: workout.isNotEmpty ? Colors.black : Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workout Schedule",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
       
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(165, 163, 176, 1),
                    size: 20,
                  ),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat.yMMM().format(currentMonth),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(165, 163, 176, 1)),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(165, 163, 176, 1),
                    size: 20,
                  ),
                  onPressed: _nextMonth,
                ),
              ],
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  DateTime date = dateList[index];
                  bool isSelected = date.day == selectedDate.day &&
                      date.month == selectedDate.month &&
                      date.year == selectedDate.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                        _generateTimeSlots();
                      });
                    },
                    child: Container(
                      height: 80,
                      width: 60,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(204, 143, 237, 1)
                            : const Color.fromRGBO(198, 196, 212, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date),
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                          Text(
                            DateFormat('d').format(date),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  String time = timeSlots[index]["time"]!;
                  String workout = timeSlots[index]["workout"]!;
                  return buildTimeSlot(time, workout);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(107, 80, 210, 0.6),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
