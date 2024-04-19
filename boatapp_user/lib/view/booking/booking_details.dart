import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/view/booking/payment_screen/payment_options.dart';
import 'package:boat_app/view/booking/ratings/rating_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/app_button.dart';
import '../../languages/LocaleString.dart';
import '../../provider/countdownProvider.dart';
import '../../provider/loading_provider/loading_provider.dart';
import '../../provider/reviewProvider.dart';
import '../../utils/colors.dart';
import '../../utils/sized_box.dart';
import '../../utils/sizes_class.dart';
import '../../utils/textstyles.dart';
import '../../utils/utils.dart';

class BookingDetails extends StatefulWidget {
  final int index;
  final String orderId,
  userName,
      name,
      description,
      price,
      startTime,
      // endTime,
      startDate,
      endDate,
  interval,
  paymentType,

  area,
  boatId,
  ownerId,
      status, image,
  hours;
  final double Lat,Long;
  final DateTime orderTime;

  const BookingDetails(
      {Key? key,
        required this.index,
        required this.orderTime,
        // required this.endTime,
        required this.userName,
        required this.endDate,
        required this.startDate,
        required this.startTime,
        required this.price,
        required this.name,
        required this.description,
        required this.image,
        required this.hours,
        required this.boatId,
        required this.paymentType,
        required this.area,
        required this.ownerId,
        required this.orderId,
        required this.status,
        required this.interval,
        required this.Lat,
        required this.Long
      })
      : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool? isReviewed;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final loadingProvider =
    Provider.of<LoadingProvider>(context, listen: false);
    ReviewProvider reviewProvider =     Provider.of<ReviewProvider>(context, listen: false);
    final countdownProvider =
    Provider.of<CountDownProvider>(context, listen: false);
    MySize2().init(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          AppLocale.bookingDetails.getString(context),
          // style: text23600,
        ),
        actions: [
          Consumer<CountDownProvider>(
            builder: (context, value, child){
              return  countdownProvider.canceled == 'true'? Container():
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('bookingTimes').doc('UserTime').snapshots(),
                  builder: (context, snapshotT) {
                    if(snapshotT.hasError){
                      return const Icon(Icons.error);
                    }
                    else if(snapshotT.hasData){
                      return FutureBuilder<String?>(
                        future: checkPendingStatus(widget.orderId), // Assuming checkPendingStatus returns a Future<String?>
                        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While the Future is still loading, you can display a loading indicator or return null.
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Handle error case if the Future fails.
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.data == 'Confirmed') {
                            // If the Future completes successfully with 'Confirmed', show the Countdown.
                            var time = DateTime.now();
                            var timeSpent =
                                time.difference(widget.orderTime).inSeconds;
                            var leftTime = snapshotT.data!['sec'] - timeSpent;
                            return   //countdown timer here
                              Column
                                (crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Countdown(
                                    seconds:
                                    leftTime < 0
                                        ? 0
                                        : leftTime,
                                    build: (BuildContext
                                    context,
                                        double time) {
                                      int a =
                                      time.toInt();
                                      int minutes = (a ~/ 60) % 60;
                                      int seconds = a % 60;
                                      return leftTime   <= 0? Container():Text(

                                        '$minutes:${seconds.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                            fontSize:
                                            16),
                                      );
                                    },
                                    onFinished: ()async{
                                      String? statuss = await checkPendingStatus(widget.orderId);
                                      if(statuss == 'Confirmed'){
                                        FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
                                          'status': 'Canceled',
                                        }).onError((error, stackTrace) {
                                          Utils.toastMessage(error.toString());
                                        });
                                      }
                                    },
                                  ),
                                   Text(AppLocale.bookingExpiresIn.getString(context), style: const TextStyle(fontSize: 10),),
                                ],
                              );
                          } else {
                            // If the Future completes with any value other than 'Confirmed', show a Container().
                            return Container();
                          }
                        },
                      );
                    }else if(snapshotT.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    return Container();
                  }
              );
            },
          ),
          const SizedBox(width: 6,)

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Padding(
                      padding:  EdgeInsets.only(left: MySize2.size60,bottom: MySize2.size20),
                      child: Stack(
                        children: [
                          Container(
                            height: MySize2.size120,
                            // width: width(context)*0.02,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
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
                                    height: MySize2.size20,


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

                                          Text(widget.orderId,
                                            style: TextStyle(
                                                fontSize: MySize2.size10,
                                                color: Colors.white,fontWeight: FontWeight.w400),),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(widget.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: MySize2.size16),),

                                          SizedBox(height: MySize2.size5,),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, color: primaryColor,size: MySize2.size12,),
                                              Text(widget.area, style: TextStyle(fontWeight: FontWeight.w400, fontSize: MySize2.size10, color: greyText),),
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: MySize2.size15),
                                        child: Container(
                                            width: MySize2.size68,
                                            height: MySize2.size17,
                                            decoration: ShapeDecoration(
                                              color: widget.status == 'Pending' ?
                                              grey6 :  widget.status== 'Confirmed' ?
                                              appColorBlue2:  widget.status == 'Canceled'?
                                              const Color(0xffFF6464):widget.status == 'Rejected'?
                                              const Color(0xfff33939):widget.status == 'Booked'?
                                              black1:
                                              primaryColor
                                              ,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(300),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                widget.status,
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
                                        imageUrl: widget.image,
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
                    Text(
                      AppLocale.bookingDetails.getString(context),
                      style:  TextStyle(fontWeight: FontWeight.w500, fontSize: MySize2.size16),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Date',
                          AppLocale.fullName.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.userName,
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    SizedBox(height: MySize2.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Date',
                          AppLocale.date.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.startDate,
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    SizedBox(height: MySize2.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Time',
                          AppLocale.time.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.startTime,
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    SizedBox(height: MySize2.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Interval',
                          AppLocale.intervals.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.interval+ ' Min',
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),

                    const Divider(
                      color: grey7,
                    ),
                    Text(

                      AppLocale.paymentDetails.getString(context),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Payment Method',
                          AppLocale.paymentMethod.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.status != 'Canceled'? widget.paymentType : 'Canceled',
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    SizedBox(height: MySize2.size10,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // 'Total to Pay',
                          AppLocale.totalToPay.getString(context),
                          style: text12400op,
                        ),
                        Text(
                          widget.status != 'Canceled'?'${widget.price} SAR': 'Canceled',
                          style:  const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),
                        ),
                      ],
                    ),
                    const Divider(
                      color: grey7,
                    ),
                  ],
                ),
              ),

//             Positioned(
//               bottom: 10,
//               left: 40,
//               child:widget.status == 'Pending'?  AppButton(
//                   loading: loadingProvider.loading,
//                   height: 60,
//                   width: width(context) * 0.8,
//                   onPressed: () async{
// //                         print('hi');
// //                         loadingProvider.loginLoading(true);
// //                         QuerySnapshot snapshot = await FirebaseFirestore.instance
// //                             .collection('orders')
// //                             .where('status', isEqualTo: 'Pending') // Adjust the criteria as needed
// //                             .limit(1)
// //                             .get();
// //
// // // Check if any documents match the query
// //                         if (snapshot.docs.isNotEmpty) {
// //                           // Get the first document from the result
// //                           DocumentSnapshot document = snapshot.docs[0];
// //
// //                           // Update the document with the 'status' field set to 'Confirmed'
// //                           await document.reference.update({
// //                             'status': 'Confirmed',
// //                           }).then((value) {
// //                             loadingProvider.loginLoading(false);
// //
// //                             Navigator.pop(context);
// //                           });
// //
// //                           print('Document updated successfully.');
// //                         } else {
// //                           loadingProvider.loginLoading(false);
// //
// //                           print('No matching documents found.');
// //                         }
//                   },
//                   text: 'Wait for Owner to confirm'
//               )
//                   : widget.status == "Confirmed"?
//               AppButton(
//                   loading: loadingProvider.loading,
//                   height: 60,
//                   width: width(context) * 0.8,
//                   onPressed: () async{
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen(orderId: widget.orderId,index: widget.index,)));
//
//                   },
//                   text: AppLocale.continueToPay.getString(context)
//               ):
//               widget.status == 'Booked'?
//               AppButton(
//                   loading: loadingProvider.loading,
//                   height: 60,
//                   width: width(context) * 0.8,
//                   onPressed: () async{
//
//                   },
//                   text: 'Booked'
//               ):widget.status == 'Complete'?
//               AppButton(
//                   loading: loadingProvider.loading,
//                   height: 60,
//                   background: Colors.green,
//                   width: width(context) * 0.8,
//                   onPressed: () async{
//
//                   },
//                   text: 'Complete'
//               ):
//               AppButton(
//                   loading: loadingProvider.loading,
//                   height: 60,
//                   width: width(context) * 0.8,
//                   onPressed: () async{
//
//                   },
//                   text: 'Canceled'
//               ),
//             ),

            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
              child: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('orders')
                  .doc(widget.orderId).snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      String status = snapshot.data!['status'];
                      return Column(
                        children: [
                          Consumer<LoadingProvider>(
                            builder: (context, value, child){
                              return FutureBuilder(future: checkOrderStatus(widget.orderId),
                                  builder: (context, AsyncSnapshot<bool> snapshot) {
                                    bool? isTime = snapshot.data ?? false;
                                    return

                                      AppButton(
                                        loading: loadingProvider.loading,
                                        height: MySize2.size50,
                                        width: width(context) ,
                                        onPressed: () async {
                                          // loadingProvider.loginLoading(
                                          //     true);

                                          if(status == 'Confirmed'){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentOptions(orderId: widget.orderId,index: widget.index,ownerId: widget.ownerId,)));
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentOptions(orderId: '', index: null, ownerId: '',)));


                                          }else if(status == 'Complete'){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RatingScreen(boatId: widget.boatId, ownerId: widget.ownerId, orderId: widget.orderId)));

                                          }
                                          else{
                                            loadingProvider.loginLoading(
                                                false);
                                          }
                                        },
                                        text: status == 'Pending'
                                            ? 'Pending'
                                            :
                                        status == 'Confirmed'
                                            ? 'Pay Now'
                                            : status == 'Booked' && isTime == true
                                            ? "It's ride time"
                                            :status == 'Ride Started'? 'Ride Started'
                                            : status == 'Complete'? 'Rate the boat':
                                        status == 'Canceled'?
                                        'Canceled': status == 'Rejected' ?
                                        'Rejected':
                                        'Waiting',
                                      );
                                  }
                              );
                            },
                          ),
                          SizedBox(
                            height: height(context)*0.02,
                          ),
                          // status == 'Pending' ?
                          // AppButton(onPressed: () async {
                          //   FirebaseFirestore.instance
                          //       .collection('orders').doc(
                          //       widget.orderId).update(
                          //       {
                          //         'status': 'Rejected'
                          //       });
                          // },
                          //     width: width(context) * 0.8,
                          //     text: 'Reject')
                          //     :
                          // Container()
                        ],
                      );
                    }
                    return Container();

                  }),
            ),
            Visibility(
              visible: widget.status == 'Canceled' ? false: true,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
                child: AppButton(text: AppLocale.cancel.getString(context),
                  textColor: black1,height: MySize2.size50 ,
                  onPressed: () async {
                   FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
                     'status': 'Canceled'
                   }).then((value) => {
                     Navigator.pop(context)
                   });
                  }, background: grey6,),
              ),
            ),

            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
            //   child: AppButton(text: AppLocale.viewLocation.getString(context),
            //     textColor: black1,height: MySize2.size50 ,onPressed: () async {
            //     final double latitude = widget.Lat; // Replace with your latitude
            //     final double longitude = widget.Long; // Replace with your longitude
            //
            //     String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            //     print(googleMapsUrl);
            //     var a = Uri.parse(googleMapsUrl);
            //     print(a);
            //     await launchUrl(a, mode: LaunchMode.externalApplication);
            //   }, background: grey6,),
            // ),
          ],
        ),
      ],
    );
  }
}
