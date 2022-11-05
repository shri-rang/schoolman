import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/screens/Attendance/AttendanceController.dart';
import 'package:table_calendar/table_calendar.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final attendanceController = Get.put(AttendanceController());

  final event = CalendarEventData(
      date: DateTime(2022, 10, 10),
      event: "Event 1",
      title: '',
      color: Colors.red);

//  CalendarControllerProvider.of(context).controller.add(event);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CalendarControllerProvider.of(context).controller.add(event);
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child:
            //  Obx(
            //   () =>
            Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              locale: 'en_US',
              weekendDays: [DateTime.sunday],
              daysOfWeekStyle: DaysOfWeekStyle(),
              // calendarController: _calendarController,
              headerStyle: HeaderStyle(),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,

                // holidayStyle: TextStyle().copyWith(color: greyColor),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => attendanceController
                                    .attendanceModel.value.messages ==
                                null
                            ? Container()
                            : CircleAvatar(
                                backgroundColor: getColor(day),
                                child: Text(day.day.toString()),
                              ),
                      ));
                },
                // todayBuilder: (context, day, focusedDay) {
                //   return CircleAvatar(
                //     backgroundColor: Colors.lightBlue,
                //     child: Text(day.day.toString()),
                //   );

                // },
              ),
            ),
          ],
        ),
        // )
      ),
      //  events: ,
    );

    // );
  }

  getColor(DateTime date) {
    var color;
    for (var i = 0;
        i < attendanceController.attendanceModel.value.data!.length;
        i++) {
      if (attendanceController.attendanceModel.value.data![i].attendance ==
              "P" &&
          date.withoutTime ==
              attendanceController.attendanceModel.value.data![i].date) {
        color = Colors.green;
        return color;
      } else if (attendanceController
                  .attendanceModel.value.data![i].attendance ==
              "A" &&
          date.withoutTime ==
              attendanceController.attendanceModel.value.data![i].date) {
        color = Colors.red;

        return color;
      } else if (attendanceController
                  .attendanceModel.value.data![i].attendance ==
              "H" &&
          date.withoutTime ==
              attendanceController.attendanceModel.value.data![i].date) {
        color = Colors.grey;
        return color;
      }
    }
  }
}
