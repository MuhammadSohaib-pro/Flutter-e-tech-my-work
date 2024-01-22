import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/booking_screens/component/booking_card.dart';
import 'package:activityapp/screens/booking_screens/component/booking_details_card.dart';
import 'package:activityapp/screens/booking_screens/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetails extends StatefulWidget {
  final BookingModel booking;

  const BookingDetails({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 0,
          ),
          child: GestureDetector(
            onTap: (){

              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          'Booking Details',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BookingDatailsCard(
          booking: widget.booking,
          onTap: () {
              // Add your onTap logic here

              // You can also navigate to a new screen using Navigator
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetails(booking: widget.booking,),
                ),
              );
          },
        ),
            ),
          ],
        ),
      ),
    );
  }
}
