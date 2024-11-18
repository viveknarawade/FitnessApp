import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String selectedCategoryValue = "Full Body";
  String? selectedHour;
  String? selectedMinute;
  String? selectedAmPm;
  String? scheduleDate;
  @override
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

  Widget buildTimeSlot(String time, String workout, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: scheduleDate == timeSlots[index]["time"]!
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          color:
                              workout.isNotEmpty ? Colors.black : Colors.grey),
                    ),
                  )
                : SizedBox.shrink(),
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
                  return buildTimeSlot(time, workout, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icon/Calendar.svg",
                            width: 18,
                            height: 27,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            DateFormat('EEE, d MMM y').format(selectedDate),
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Time",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Hours Scroll
                                  SizedBox(
                                    width: 50,
                                    child: ListWheelScrollView.useDelegate(
                                      itemExtent: 40,
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.002,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedHour = (index + 1)
                                              .toString()
                                              .padLeft(2, '0');
                                          log("SELECTED HOUR $selectedHour");
                                        });
                                      },
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        builder: (context, index) {
                                          return Center(
                                            child: Text(
                                              "${index + 1}", // Hours 1-12
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // Minutes Scroll
                                  SizedBox(
                                    width: 50,
                                    child: ListWheelScrollView.useDelegate(
                                      itemExtent: 40,
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.002,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedMinute = (index * 5)
                                              .toString()
                                              .padLeft(2, '0');
                                          log("SELECTED MINUTE $selectedMinute");
                                        });
                                      },
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        builder: (context, index) {
                                          return Center(
                                            child: Text(
                                              "${index * 5}", // Minutes 0, 5, 10, etc.
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  // AM/PM Scroll
                                  SizedBox(
                                    width: 50,
                                    child: ListWheelScrollView.useDelegate(
                                      itemExtent: 40,
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.002,
                                      onSelectedItemChanged: (index) {
                                        setState(() {
                                          selectedAmPm =
                                              index == 0 ? "AM" : "PM";
                                          log("SELECTED AM PM $selectedAmPm");
                                        });
                                      },
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        builder: (context, index) {
                                          return Center(
                                            child: Text(
                                              index == 0 ? "AM" : "PM",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: 2, // AM or PM
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(215, 230, 230, 1)),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.dumbbell,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Choose Workout",
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Spacer(),
                            DropdownButton<String>(
                              value: selectedCategoryValue,
                              icon: const Icon(Icons.arrow_downward_outlined),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategoryValue = newValue!;
                                  log("$newValue");
                                });
                              },
                              items: <String>[
                                "Upper Body",
                                "Lower Body",
                                "Full Body"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Construct the selected time (e.g., "07:00 AM")
                            scheduleDate =
                                "$selectedHour:$selectedMinute $selectedAmPm";

                            // Check if the selected time already has a workout, to prevent duplicates
                            bool workoutExists = timeSlots
                                .any((slot) => slot["time"] == scheduleDate);

                            if (!workoutExists) {
                              // If the workout does not exist, add the new workout
                              setState(() {
                                timeSlots.add({
                                  "time": scheduleDate!,
                                  "workout": selectedCategoryValue!,
                                });
                              });
                            } else {
                              log("Workout already scheduled for $scheduleDate.");
                            }

                            log("Scheduled new workout: $scheduleDate for $selectedCategoryValue");

                            Navigator.of(context)
                                .pop(); // Close the BottomSheet
                          },
                          child: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color.fromRGBO(154, 193, 254, 1),
                                    Color.fromRGBO(147, 166, 253, 1),
                                  ],
                                )),
                            child: Text(
                              "Save",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        backgroundColor: const Color.fromRGBO(107, 80, 210, 0.6),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
