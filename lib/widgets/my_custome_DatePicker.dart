import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_event.dart';
import 'package:todoassignment/widgets/my_custome_button.dart';

class CustomDatePickerDialog extends StatefulWidget {
  bool isDateFromPicker;
  DateTime? minimumDate;
  CustomDatePickerDialog({
    super.key,
    required this.isDateFromPicker,
    this.minimumDate,
  });
  @override
  _CustomDatePickerDialogState createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  int dateButtonSelect = 1;

  DateTime _calculateNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilWeekday = (weekday - now.weekday + 7) % 7;
    return now.add(Duration(days: daysUntilWeekday));
  }

  List<Widget> _buildCalendarGrid() {
    List<Widget> gridItems = [];
    DateTime firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    int daysBeforeFirstDay = firstDayOfMonth.weekday % 7;

    for (int i = 0; i < daysBeforeFirstDay; i++) {
      gridItems.add(Container());
    }

    int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(
        _currentMonth.year,
        _currentMonth.month,
        day,
      );

      bool isSelected =
          _selectedDate.year == currentDate.year &&
          _selectedDate.month == currentDate.month &&
          _selectedDate.day == currentDate.day;

      bool isToday =
          currentDate.year == DateTime.now().year &&
          currentDate.month == DateTime.now().month &&
          currentDate.day == DateTime.now().day;

      bool isDisabled =
          widget.minimumDate != null &&
          currentDate.isBefore(widget.minimumDate!);

      Widget dayWidget = Container(
        alignment: Alignment.center,
        decoration:
            isSelected
                ? BoxDecoration(shape: BoxShape.circle, color: Colors.blue)
                : isToday
                ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue),
                )
                : null,
        child: Text(
          day.toString(),
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:
                isDisabled
                    ? Colors
                        .grey // Grey out disabled dates
                    : isSelected
                    ? Colors.white
                    : isToday
                    ? Colors.blue
                    : Colors.black,
          ),
        ),
      );
      gridItems.add(
        isDisabled
            ? IgnorePointer(child: dayWidget)
            : GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = currentDate;
                });
              },
              child: dayWidget,
            ),
      );
    }
    return gridItems;
  }

  // List<Widget> _buildCalendarGrid() {
  //   List<Widget> gridItems = [];
  //   DateTime firstDayOfMonth = DateTime(
  //     _currentMonth.year,
  //     _currentMonth.month,
  //     1,
  //   );
  //   int daysBeforeFirstDay = firstDayOfMonth.weekday % 7;

  //   for (int i = 0; i < daysBeforeFirstDay; i++) {
  //     gridItems.add(Container());
  //   }

  //   int daysInMonth =
  //       DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
  //   for (int day = 1; day <= daysInMonth; day++) {
  //     DateTime currentDate = DateTime(
  //       _currentMonth.year,
  //       _currentMonth.month,
  //       day,
  //     );
  //     bool isSelected =
  //         _selectedDate.year == currentDate.year &&
  //         _selectedDate.month == currentDate.month &&
  //         _selectedDate.day == currentDate.day;
  //     bool isToday =
  //         currentDate.year == DateTime.now().year &&
  //         currentDate.month == DateTime.now().month &&
  //         currentDate.day == DateTime.now().day;

  //     gridItems.add(
  //       GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _selectedDate = currentDate;
  //           });
  //         },
  //         child: Container(
  //           alignment: Alignment.center,
  //           decoration:
  //               isSelected
  //                   ? BoxDecoration(shape: BoxShape.circle, color: Colors.blue)
  //                   : isToday
  //                   ? BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     border: Border.all(color: Colors.blue),
  //                   )
  //                   : null,
  //           child: Text(
  //             day.toString(),
  //             style: GoogleFonts.roboto(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w400,
  //               color:
  //                   isSelected
  //                       ? Colors.white
  //                       : isToday
  //                       ? Colors.blue
  //                       : Colors.black,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return gridItems;
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width:
            kIsWeb && MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    widget.isDateFromPicker == false
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                text: 'No Date',
                                onPressed: () {
                                  setState(() {
                                    dateButtonSelect = 5;
                                    //   _selectedDate = "No Date";
                                    // _selectedDate = _calculateNextWeekday(
                                    //   DateTime.monday,
                                    // );
                                  });
                                },
                                backgroundColor:
                                    dateButtonSelect == 5
                                        ? Color(0xff1DA1FA)
                                        : Color(0xffEDF8FF),

                                textStyle:
                                    dateButtonSelect == 5
                                        ? GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffffffff),
                                        )
                                        : null,

                                borderRadius: 5.0,
                              ),
                            ),

                            SizedBox(width: 10),
                            Expanded(
                              child: CustomElevatedButton(
                                text: "Today",
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = DateTime.now();
                                    dateButtonSelect = 1;
                                  });
                                },
                                backgroundColor:
                                    dateButtonSelect == 1
                                        ? Color(0xff1DA1FA)
                                        : Color(0xffEDF8FF),

                                textStyle:
                                    dateButtonSelect == 1
                                        ? GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffffffff),
                                        )
                                        : null,

                                borderRadius: 5.0,
                              ),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: "Today",
                                    onPressed: () {
                                      setState(() {
                                        _selectedDate = DateTime.now();
                                        dateButtonSelect = 1;
                                      });
                                    },
                                    backgroundColor:
                                        dateButtonSelect == 1
                                            ? Color(0xff1DA1FA)
                                            : Color(0xffEDF8FF),

                                    textStyle:
                                        dateButtonSelect == 1
                                            ? GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            )
                                            : null,

                                    borderRadius: 5.0,
                                  ),
                                ),

                                SizedBox(width: 10),
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: 'Next Monday',
                                    onPressed: () {
                                      setState(() {
                                        dateButtonSelect = 2;
                                        _selectedDate = _calculateNextWeekday(
                                          DateTime.monday,
                                        );
                                      });
                                    },
                                    backgroundColor:
                                        dateButtonSelect == 2
                                            ? Color(0xff1DA1FA)
                                            : Color(0xffEDF8FF),

                                    textStyle:
                                        dateButtonSelect == 2
                                            ? GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            )
                                            : null,

                                    borderRadius: 5.0,
                                  ),
                                ),
                              ],
                            ),
                            if (kIsWeb) SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: 'Next Tuesday',
                                    onPressed: () {
                                      setState(() {
                                        dateButtonSelect = 3;
                                        _selectedDate = _calculateNextWeekday(
                                          DateTime.tuesday,
                                        );
                                      });
                                    },
                                    backgroundColor:
                                        dateButtonSelect == 3
                                            ? Color(0xff1DA1FA)
                                            : Color(0xffEDF8FF),

                                    textStyle:
                                        dateButtonSelect == 3
                                            ? GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            )
                                            : null,

                                    borderRadius: 5.0,
                                  ),
                                ),

                                SizedBox(width: 10),
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: 'After 1 week',
                                    onPressed: () {
                                      setState(() {
                                        dateButtonSelect = 4;
                                        _selectedDate = DateTime.now().add(
                                          Duration(days: 7),
                                        );
                                      });
                                    },
                                    backgroundColor:
                                        dateButtonSelect == 4
                                            ? Color(0xff1DA1FA)
                                            : Color(0xffEDF8FF),

                                    textStyle:
                                        dateButtonSelect == 4
                                            ? GoogleFonts.roboto(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff),
                                            )
                                            : null,

                                    borderRadius: 5.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _currentMonth = DateTime(
                                _currentMonth.year,
                                _currentMonth.month - 1,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/arrow_drop_down_FILL1_wght400_GRAD0_opsz24 8.png",
                              height: 24,
                            ),
                          ),
                        ),

                        Text(
                          DateFormat.yMMMM().format(_currentMonth),
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff323238),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            setState(() {
                              _currentMonth = DateTime(
                                _currentMonth.year,
                                _currentMonth.month + 1,
                              );
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/arrow_drop_down_FILL1_wght400_GRAD0_opsz24 7.png",
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      children: [
                        ...['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                            .map(
                              (day) => Center(
                                child: Text(
                                  day,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff323238),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        ..._buildCalendarGrid(),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey[300],
                //indent: 16,
                // endIndent: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/event.png", height: 23),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dateButtonSelect == 5
                            ? "No Date"
                            : DateFormat.yMMMd().format(_selectedDate),
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff323238),
                        ),
                      ),
                    ),
                    Spacer(),

                    CustomElevatedButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Color(0xffEDF8FF),

                      borderRadius: 5.0,
                    ),
                    SizedBox(width: 10),
                    CustomElevatedButton(
                      text: 'Save',
                      onPressed: () {
                        if (dateButtonSelect == 5) {
                          // context.read<EmployeeAddEditBloc>().dateToCont.text =
                          //     "No Date";

                          context.read<EmployeeAddEditBloc>().add(
                            EmployeeSelectDateEvent("No Date"),
                          );
                          Navigator.pop(context, null);
                        } else {
                          // "No Date";
                          Navigator.pop(context, _selectedDate);
                        }
                      },
                      textStyle: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                      backgroundColor: Color(0xff1DA1FA),

                      borderRadius: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
