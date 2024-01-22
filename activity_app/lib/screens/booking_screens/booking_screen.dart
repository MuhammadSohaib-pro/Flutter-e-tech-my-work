import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/booking_screens/component/booking_card.dart';
import 'package:activityapp/screens/booking_screens/booking_details.dart';
import 'package:activityapp/screens/booking_screens/model/booking_model.dart';
import 'package:activityapp/screens/booking_screens/model/payment_model.dart';
import 'package:activityapp/screens/home/component/tabbar.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}
//Map<String, dynamic> jsonData = bookingCard.toJson();

final List<BookingModel> bookings = [
  BookingModel(
    eventName: 'Boat Event 1',
    date: 'Wednesday 17 April, 2023',
    bookingId: '#122344737',
    status: 'Completed',
    logoImagePath:
    'https://images.pexels.com/photos/2100387/pexels-photo-2100387.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    logoText: 'Boat',
    smalllogo: 'assets/images/Horse.png',
    subText: 'Borem ipsum',
    location: 'Saudi Arabia, Riyadh',
    time: '12:00 PM',
    duration: '120 min',
    payment: PaymentModel(
      participentprice: '200',
      totalParticipent: '2',
      bookingDate: '2 April 2023',

    ),
  ),

  BookingModel(
    eventName: 'Boat Event 2',
    date: 'Thursday 18 April, 2023',
    bookingId: '#122344738',
    status: 'Completed',
    logoImagePath:
    'https://images.pexels.com/photos/2100387/pexels-photo-2100387.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    logoText: 'Boat',
    smalllogo: 'assets/images/Horse.png',
    subText: 'Borem ipsum',
    location: 'Saudi Arabia, Riyadh',
    time: '1:00 PM',
    duration: '70 min',
    payment: PaymentModel(
      participentprice: '100',
      totalParticipent: '5',
      bookingDate: '14 April 2023',

    ),
  ),
  BookingModel(
    eventName: 'Boat Event 2',
    date: 'Thursday 18 April, 2023',
    bookingId: '#122344738',
    status: 'Cancelled',
    logoImagePath:
    'https://images.pexels.com/photos/2100387/pexels-photo-2100387.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    logoText: 'Boat',
    smalllogo: 'assets/images/Horse.png',
    subText: 'Borem ipsum',
    location: 'Saudi Arabia, Riyadh',
    time: '1:00 PM',
    duration: '90 min',
    payment: PaymentModel(
      participentprice: '100',
      totalParticipent: '1',
      bookingDate: '17 April 2023',

    ),
  ),
];

// Now you can use the bookingCard instance as needed.


class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'My Bookings',
            style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'History'),
            ],
            indicatorColor: AppColors.primaryColor,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
            labelColor:
                AppColors.primaryColor, // Color for the selected tab text
            unselectedLabelColor: AppColors.greyText,
          ),
        ),
        body: TabBarView(
          children: [
        Column(
        children: [
        Expanded(
        child: bookings.any((booking) => booking.status == 'Active')
          ? ListView.builder(
        itemCount: bookings.where((booking) => booking.status == 'Active').length,
        itemBuilder: (context, index) {
          // Get only the 'Active' bookings
          final activeBookings = bookings.where((booking) => booking.status == 'Active').toList();

          return BookingCard(
            booking: activeBookings[index],
            onTap: () {
              // Add your onTap logic here
              print('Booking card tapped at index $index');
              // You can also navigate to a new screen using Navigator
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetails(booking: activeBookings[index]),
                ),
              );
            },
          );
        },
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.heightMultiplier * 30,
              child: Image.asset('assets/images/bookingnotfound.png'),
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          ),
          Text(
            'No Bookings Found!',
            style: MyTextStyles.interTextstyle(
                SizeConfig.textMultiplier * 2, FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 1,
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 84,
            child: Text(
              'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
              textAlign: TextAlign.center,
              style: MyTextStyles.myTextStylelightsize(
                  SizeConfig.textMultiplier * 1.5),
            ),
          ),
        ],
      ),
    ),
    ],
    ),


    //Completed
            Column(
              children: [
                Expanded(
                  child: bookings.any((booking) => booking.status == 'Completed')
                      ? ListView.builder(
                    itemCount: bookings.where((booking) => booking.status == 'Completed').length,
                    itemBuilder: (context, index) {
                      // Get only the 'Active' bookings
                      final activeBookings = bookings.where((booking) => booking.status == 'Completed').toList();

                      return BookingCard(
                        booking: activeBookings[index],
                        onTap: () {
                          // Add your onTap logic here
                          print('Booking card tapped at index $index');
                          // You can also navigate to a new screen using Navigator
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetails(booking: activeBookings[index]),
                            ),
                          );
                        },
                      );
                    },
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: SizeConfig.heightMultiplier * 30,
                          child: Image.asset('assets/images/bookingnotfound.png'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      Text(
                        'No Bookings Found!',
                        style: MyTextStyles.interTextstyle(
                            SizeConfig.textMultiplier * 2, FontWeight.w600),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 84,
                        child: Text(
                          'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                          textAlign: TextAlign.center,
                          style: MyTextStyles.myTextStylelightsize(
                              SizeConfig.textMultiplier * 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),



            //History
            Column(
              children: [
                bookings.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return BookingCard(
                        booking: bookings[index],
                        onTap: () {
                          // Add your onTap logic here
                          print('Booking card tapped at index $index');
                          // You can also navigate to a new screen using Navigator
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetails(booking: bookings[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: SizeConfig.heightMultiplier * 30,
                        child: Image.asset('assets/images/bookingnotfound.png'),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Text(
                      'No Bookings Found!',
                      style: MyTextStyles.interTextstyle(
                        SizeConfig.textMultiplier * 2,
                        FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 84,
                      child: Text(
                        'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                        textAlign: TextAlign.center,
                        style: MyTextStyles.myTextStylelightsize(
                          SizeConfig.textMultiplier * 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
