import 'package:activityapp/screens/booking_screens/model/payment_model.dart';

class BookingModel {
  final String eventName;
  final String date;
  final String bookingId;
  final String status;
  final String logoImagePath;
  final String logoText;
  final String smalllogo;
  final String subText;
  final String time;
  final String duration;
  final String location; // assuming you have a location field
  final PaymentModel payment;
  // final VoidCallback onTap;



  BookingModel({
    required this.eventName,
    required this.duration,
    required this.time,
    required this.date,
    required this.bookingId,
    required this.status,
    required this.logoImagePath,
    required this.logoText,
    required this.smalllogo,
    required this.subText,
    required this.location,
    required this.payment,
 //   required this.onTap,
  });

  // Method to convert BookingCard data to JSON format
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'date': date,
      'bookingId': bookingId,
      'status': status,
      'logoImagePath': logoImagePath,
      'logoText': logoText,
      'smalllogo': smalllogo,
      'subText': subText,
      'location': location,
      'time':time,
      'duration':duration,
      'payment': payment.toJson(),
    };
  }
}
