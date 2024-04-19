// import 'package:boat_app/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
//
// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends State<CalendarScreen> {
//   Set<DateTime> _disabledDates = {
//     DateTime(2023, 8, 15),
//     DateTime(2023, 8, 20),
//     // Add more dates as needed
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Disabled Days Calendar'),
//       ),
//       body: CalendarCarousel(
//         todayButtonColor: primaryColor,
//         todayBorderColor: primaryColor,
//         todayTextStyle: TextStyle(color: Colors.white),
//         onDayPressed: (DateTime date, List<Event> events) {
//           if (_disabledDates.contains(date)) {
//             return;
//           }
//           // Handle day pressed
//         },
//         weekendTextStyle: TextStyle(color: Colors.red),
//         inactiveDaysTextStyle: TextStyle(color: Colors.grey),
//         inactiveWeekendTextStyle: TextStyle(color: Colors.red[200]),
//         customDayBuilder: (
//             bool isSelectable,
//             int index,
//             bool isSelectedDay,
//             bool isToday,
//             bool isPrevMonthDay,
//             TextStyle textStyle,
//             bool isNextMonthDay,
//             bool isThisMonthDay,
//             DateTime day,
//             ) {
//           if (_disabledDates.contains(day)) {
//             return Center(
//               child: Text(
//                 day.day.toString(),
//                 style: TextStyle(color: Colors.grey),
//               ),
//             );
//           } else {
//             return Center(
//               child: Text(
//                 day.day.toString(),
//                 style: TextStyle(
//                   color: isToday ? Colors.blue : isSelectable ? Colors.black87 : Colors.grey,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }