import 'dart:async';

import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/view/my_bookings/provider/mybooking_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../utils/colors.dart';
import '../../utils/sizes.dart';
import '../../utils/sizes_class.dart';
import '../../utils/textstyles.dart';
import '../../utils/utils.dart';
import '../boat_details/boat_bookings.dart';
import '../booking/booking_details.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {

  // Future<int?> get(){
  //   return getTime('89');
  // }
  @override
  Widget build(BuildContext context) {
    List<String> status = [
      // AppLocale.all.getString(context),
      // AppLocale.requested.getString(context),
      // AppLocale.toPay.getString(context),
      // AppLocale.active.getString(context),
      // AppLocale.canceled.getString(context),
      // AppLocale.complete.getString(context),
      'All',
      'Requested',
      'To Pay',
      'Active',
      'Canceled',
      'Complete'

    ];
    MySize2().init(context);
    final bookingProvider = Provider.of<MyBookingProvider>(context);
    return Scaffold(
      appBar: AppBar(title:    Text(
        AppLocale.myBookings.getString(context),
        style: TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w600,),
      ),
        elevation: 0, backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Consumer<MyBookingProvider>(
                  builder: (context, value, child){
                    return Container(
                      height: MySize2.size72,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:status.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: MySize2.size5),
                                  child: bookingProvider.selectedIndex == index?
                                  Container(
                                    height: 4 * SizeConfig.heightMultiplier,
                                    // width:  30 * SizeConfig.widthMultiplier,
                                    padding: EdgeInsets.symmetric(horizontal: MySize2.size20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: secondaryColor),
                                    child: Center(
                                        child: Text(
                                          status[index],
                                          style: TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w500,color: Colors.white),
                                        )),
                                  ):
                                  InkWell(
                                    onTap: (){
                                      bookingProvider.updateSelectedIndex(index, status[index]);
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Offers_screen()));
                                    },
                                    child: Container(
                                      height: 4 * SizeConfig.heightMultiplier,
                                      // width:  30 * SizeConfig.widthMultiplier,
                                      padding: EdgeInsets.symmetric(horizontal: MySize2.size20),

                                      decoration: const BoxDecoration(
                                          // borderRadius: BorderRadius.circular(30),
                                          // border: Border.all(color: Colors.black45, width: 0.5)

                                      ),
                                      child: Center(
                                          child: Text(
                                            status[index],
                                            style: TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w400,color: greyText),
                                          )),
                                    ),
                                  ),
                                ),



                              ],
                            );
                          }
                      ),
                    );
                  },
                ),

                Consumer<MyBookingProvider>(
                  builder: (context,value, child){
                    print(bookingProvider.getStatus);
                    return  StreamBuilder<QuerySnapshot>(
                      stream: bookingProvider.getStatus == 'All'?
                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots():
                      bookingProvider.getStatus == 'Requested'?
                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('status', isEqualTo: 'Pending')
                          .snapshots()
                          :
                      bookingProvider.getStatus == 'To Pay'?

                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('status', isEqualTo: 'Confirmed')
                          .snapshots()
                          :
                      bookingProvider.getStatus == 'Active'?

                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('status', isEqualTo: 'Booked')
                          .snapshots():
                      bookingProvider.getStatus == 'Canceled'?
                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('status', isEqualTo: 'Canceled')
                          .snapshots()
                          :
                      FirebaseFirestore.instance
                          .collection('orders')
                          .where('userIdB',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .where('status', isEqualTo: 'Complete')
                          .snapshots()

                      ,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.error);
                        } else if (snapshot.hasData) {
                          // Extract the necessary data from `orderData` and `boatData`
                          if (snapshot.data!.docs.isNotEmpty) {
                            List<DocumentSnapshot> orderedDocs = snapshot.data!.docs;
                            orderedDocs.sort((a, b) {
                              int orderIdA = int.parse(a['orderId']);
                              int orderIdB = int.parse(b['orderId']);
                              return orderIdB.compareTo(orderIdA); // Change to 'orderIdA.compareTo(orderIdB)' for ascending order
                            });
                            return ListView.builder(
                              shrinkWrap: true,
                              // reverse: true,
                              // scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),//const AlwaysScrollableScrollPhysics(),
                              itemCount: orderedDocs.length,
                              itemBuilder: (context, index) {
                                var snap = orderedDocs[index];
                                String boatName = snap["boatName"];
                                String imageUrl = snap["image1"];
                                double price = snap['Amount'];
                                String orderId = snap['orderId'];
                                String userId = snap['userIdB'];
                                String ownerId = snap['ownerId'];
                                String boatId = snap['boatId'];
                                String area = snap['area'];
                                String userName = snap['userName'] ;

                                double lat = snap['Latitude'];
                                double long = snap['Longitude'];
                                String paymentType = snap['paymentType'];
                                String description = snap['aboutBoat'];
                                String startTime = snap['timeSlot'];
                                String startDate = snap['startDate'];
                                String endDate = snap['endDate'];
                                String status = snap['status'];
                                String interval = snap['interval'].toString();
                                var orderTime = (snap['orderTime'] as Timestamp).toDate();

                                // var timeLeftInSeconds =time.isAfter(orderTime) ? orderTime.difference(time).inSeconds : 0;

                                // print(leftTime);
                                // print(orderTime.difference(time).inSeconds);
                                // if (time.difference(orderTime).inSeconds > 60) {
                                //   FirebaseFirestore.instance
                                //       .collection('orders')
                                //       .doc(snap['orderId'])
                                //       .update({
                                //     'status': 'Canceled',
                                //   });
                                // }

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingDetails(
                                              price: price.toString(),
                                              endDate: endDate,
                                              // endTime: endTime,
                                              userName: userName ?? '',
                                              area: area,
                                              startDate: startDate,
                                              name: boatName,
                                              description: description,
                                              startTime: startTime,
                                              orderId: orderId,
                                              status: status,
                                              image: imageUrl,
                                              index: index,
                                              hours: interval,
                                              paymentType : paymentType,
                                              boatId: boatId,
                                              ownerId: ownerId, orderTime: orderTime,
                                              interval: interval, Lat: lat, Long: long,

                                            )));
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: MySize2.size60,bottom: MySize2.size20),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: MySize2.size120,
                                          // width: width(context)*0.02,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Color(0x11000000),
                                                  blurRadius: 20,
                                                  offset: Offset(0, 4),
                                                  spreadRadius: 0,
                                                )
                                              ]
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: MySize2.size60, top: MySize2.size10, bottom: MySize2.size10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: MySize2.size18,


                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10)),
                                                    color: primaryColor,
                                                  ),
                                                  child: Padding(
                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(AppLocale.bookingId.getString(context),
                                                          style: TextStyle(
                                                              fontSize: MySize2.size10,
                                                              color: Colors.white,fontWeight: FontWeight.w400),),

                                                        Text(orderId,
                                                          style: TextStyle(
                                                              fontSize: MySize2.size10,
                                                              color: Colors.white,fontWeight: FontWeight.w400),),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(boatName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: MySize2.size16),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(endDate, style: TextStyle(fontWeight: FontWeight.w400, fontSize: MySize2.size10, color: greyText),),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.watch_later_outlined, color: greyText,size: MySize2.size12,),
                                                            const SizedBox(width: 3,),
                                                            Text(startTime, style: TextStyle(fontWeight: FontWeight.w400, fontSize: MySize2.size10, color: greyText),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.symmetric(horizontal: MySize2.size15),
                                                      child: Container(
                                                          width: MySize2.size68,
                                                          height: MySize2.size17,
                                                          decoration: ShapeDecoration(

                                                            color: status == 'Pending' ?
                                                            grey6 :  status== 'Confirmed' ?
                                                            appColorBlue2:  status == 'Canceled'?
                                                            Color(0xffFF6464):status == 'Rejected'?
                                                            Color(0xfff33939):status == 'Booked'?
                                                            black1:
                                                            primaryColor
                                                            ,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(300),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              status,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: MySize2.size8,
                                                                fontWeight: FontWeight.w400,

                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on, color: primaryColor,size: MySize2.size12,),
                                                    Text(area, style: TextStyle(fontWeight: FontWeight.w400, fontSize: MySize2.size10, color: greyText),),
                                                  ],
                                                )


                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(

                                          height: MySize2.size120,width:  MySize2.size100,

                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Positioned(
                                                  left: -MySize2.size60,
                                                  bottom: MySize2.size10,
                                                  child: Container(
                                                      clipBehavior: Clip.hardEdge,
                                                      height: MySize2.size100,width:  MySize2.size100,
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                      child:  CachedNetworkImage(
                                                        width: width(context),
                                                        height: height(context),
                                                        fit: BoxFit.cover,
                                                        imageUrl: imageUrl,
                                                        placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                            CircularProgressIndicator()),
                                                        errorWidget:
                                                            (context, url, error) =>
                                                        const Icon(Icons.error),
                                                      ),))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset(empty),
                                SizedBox(
                                  height: 0.03 * height(context),
                                ),
                                Center(
                                    child: Text(
                                        AppLocale.noBookings.getString(context)))
                              ],
                            );
                          }
                        }
                        return Container();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountdownProvider with ChangeNotifier {
  int _countdown = 60; // Set your initial countdown value in seconds
  late Timer _timer;

  CountdownProvider() {
    // Start the countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        _countdown--;
        notifyListeners(); // Notify listeners when the countdown changes
      } else {
        // Countdown is finished, you can perform any action here
        _timer.cancel(); // Stop the timer
      }
    });
  }

  int get countdown => _countdown;

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}
