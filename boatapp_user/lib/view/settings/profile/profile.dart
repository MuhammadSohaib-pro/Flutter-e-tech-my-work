//
// import 'package:boat_app/custom_widgets/back_arrow.dart';
// import 'package:boat_app/utils/colors.dart';
// import 'package:boat_app/utils/image_paths.dart';
// import 'package:boat_app/utils/sizes_class.dart';
// import 'package:boat_app/utils/textstyles.dart';
// import 'package:boat_app/view/profile/settings.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
//
// import '../../languages/LocaleString.dart';
// import '../../utils/sized_box.dart';
// import '../booking/booking_details.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//   String id = FirebaseAuth.instance.currentUser!.uid;
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     MySize2().init(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea (
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Back_Arrow(
//                           ontap: (){
//                             // print(id);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsScreen()));
//                           },
//                           image: settings,
//                         )
//                       ],
//                     ),
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance.collection('User').where('id', isEqualTo: id).snapshots(),
//                       builder: (context, snapshot){
//                         if(snapshot.hasError){
//                           return const Text('Network Error');
//                         }
//                         else if(snapshot.hasData){
//                           return Text(snapshot.data!.docs[0]['name'], style: text17700,);
//                         }
//                         else if(snapshot.connectionState == ConnectionState.waiting){
//                           return const Center(child: CircularProgressIndicator());
//                         }
//
//                         return Container();
//                       },),
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0, left: 40, right: 40),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               StreamBuilder<QuerySnapshot>(
//                                 stream: FirebaseFirestore.instance.collection('orders').where('userIdB', isEqualTo: id).snapshots(),
//                                 builder: (context, snapshot){
//                                   if(snapshot.hasError){
//                                     return const Text('Network Error');
//                                   }
//                                   if(snapshot.hasData){
//                                     return Text(snapshot.data!.docs.length.toString(), style: text17700,);
//                                   }
//                                   return Container();
//                                 },),
//
//                               const SizedBox(
//                                 height: 5,
//                               ),
//
//                               Text(AppLocale.totalBooking.getString(context), style: text12500color,)
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               StreamBuilder<QuerySnapshot>(
//                                 stream: FirebaseFirestore.instance.collection('Fav').where('userId', isEqualTo: id).snapshots(),
//                                 builder: (context, snapshot){
//                                   if(snapshot.hasError){
//                                     return const Text('Network Error');
//                                   }
//                                   if(snapshot.hasData){
//                                     return Text(snapshot.data!.docs.length.toString(), style: text17700,);
//                                   }
//                                   return Container();
//                                 },),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(AppLocale.favoriteBoats.getString(context), style: text12500color,)
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//
//               ),
// //tab here
//               Center(
//                 child: TabBar(
//                   unselectedLabelColor: const Color(0xff9FA5C0),
//                   labelColor: primaryColor,
//                   indicatorColor: Colors.green,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   controller: _tabController,
//                   tabs: [
//
//                     Tab(text: AppLocale.upcoming.getString(context),),
//                     Tab(text: AppLocale.history.getString(context)),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: MySize2.size350* 1.5,//height(context)*0.6,
//                 width: width(context),// Adjust the height as per your requirement
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     // First Tab Content (existing code)
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('orders').where('userIdB', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                           .where('status',whereIn: ['Pending', 'Confirmed','Booked' ])
//
//                           .snapshots(),
//                       builder: (BuildContext context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                             ),
//                           );
//                         } else if (snapshot.hasError) {
//                           return const Icon(Icons.error);
//                         } else if (snapshot.hasData) {
//                           // Extract the necessary data from `orderData` and `boatData`
//                           if(snapshot.data!.docs.isNotEmpty){
//                             List<DocumentSnapshot> sortedDocs = List.from(snapshot.data!.docs)
//                               ..sort((a, b) => b['orderId'].compareTo(a['orderId']));
//
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               // reverse: true,
//                               physics: const ScrollPhysics(),
//                               itemCount: sortedDocs.length,
//                               itemBuilder: (context, index) {
//                                 var snap = sortedDocs[index];
//                                 String boatName = snap["boatName"];
//                                 String imageUrl = snap["image1"];
//                                 double price = snap['Amount'];
//                                 String orderId = snap['orderId'];
//                                 String userId = snap['userId'];
//                                 String ownerId = snap['ownerId'];
//                                 String boatId = snap['boatId'];
//                                 String description = snap['aboutBoat'];
//                                 String startTime = snap['timeSlot'];
//                                 String startDate = snap['startDate'];
//                                 String endDate = snap['endDate'];
//                                 String status = snap['status'];
//                                 String hours = snap['totalHours'];
//                                 var orderTime = snap['orderTime'].toDate();
//
//
//                                 // String startTime = 'sd';
//                                 // String endTime = 'gsdf';
//                                 // String date = 'ksnda';
//                                 return InkWell(
//                                   onTap: (){
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => BookingDetails(
//                                               price: price.toString(),
//                                               endDate: endDate,
//                                               // endTime: endTime,
//                                               startDate: startDate,
//                                               name: boatName,
//                                               description: description,
//                                               startTime: startTime,
//                                               orderId: orderId,
//                                               status: status,
//                                               image: imageUrl, index: index,
//                                               hours: hours,
//                                               boatId: boatId,
//                                               ownerId: ownerId, orderTime: orderTime,
//                                             )));
//                                   },
//                                   child: Padding(
//                                     padding:
//                                     EdgeInsets.only(top: height(context)*0.02, left: width(context)*0.04, right: width(context)*0.04),
//                                     child: Column(
//
//                                       children: [
//                                         SizedBox(
//                                           height: height(context)*0.14,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 width: width(context) * 0.22,
//                                                 height: width(context) * 0.22,
//                                                 clipBehavior: Clip.hardEdge,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       16),
//                                                 ),
//                                                 child: CachedNetworkImage(
//                                                   width: width(context),
//                                                   height: height(context),
//                                                   fit: BoxFit.cover,
//                                                   imageUrl: imageUrl,
//                                                   placeholder: (context,
//                                                       url) =>
//                                                   const Center(
//                                                       child:
//                                                       CircularProgressIndicator()),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                   const Icon(Icons.error),
//                                                 ),
//                                               ),
//                                               // SizedBox(
//                                               //   width: width(context)*0.02,
//                                               // ),
//                                               Column(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     height: height(context)*0.03,
//                                                     width: width(context)*0.65,
//
//                                                     decoration: BoxDecoration(
//                                                       gradient:
//                                                       const LinearGradient(
//                                                         colors: [
//                                                           Color(0xff006EFE),
//                                                           Color(0xff494AFF)
//                                                         ],
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(16),
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                       const EdgeInsets
//                                                           .symmetric(
//                                                           horizontal:
//                                                           10.0),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             'Booking ID: $orderId',
//                                                             style:
//                                                             text11500white,
//                                                           ),
//                                                           const Icon(
//                                                             Icons
//                                                                 .arrow_forward_ios_sharp,
//                                                             color: Colors
//                                                                 .white,
//                                                             size: 15,
//                                                           ),
//                                                           // Row(
//                                                           //   children: [
//                                                           //     Text(
//                                                           //       AppLocale
//                                                           //           .viewDetails
//                                                           //           .getString(
//                                                           //               context),
//                                                           //       style:
//                                                           //           text11600white,
//                                                           //     ),
//                                                           //     const Icon(
//                                                           //       Icons
//                                                           //           .arrow_forward_ios_sharp,
//                                                           //       color: Colors
//                                                           //           .white,
//                                                           //       size: 15,
//                                                           //     ),
//                                                           //   ],
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: width(context)*0.55,
//                                                     height: height(context)*0.1,
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Text(boatName,
//                                                             style: text16500),
//                                                         SizedBox(
//                                                           width:
//                                                           width(context) * 0.55,
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                   '$startTime ',
//                                                                   style:
//                                                                   text11400op),
//                                                               // SizedBox(
//                                                               //   width:
//                                                               //   width(context) *
//                                                               //       0.155,
//                                                               // ),
//                                                               Text(startDate,
//                                                                   style:
//                                                                   text11400op),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width:
//                                                           width(context) * 0.6,
//
//                                                           child: Row(
//
//                                                             children: [
//                                                               Container(
//
//                                                                 height: 10,//height(context)*0.03,
//                                                                 width: 10,
//                                                                 decoration: BoxDecoration(
//                                                                     shape: BoxShape.circle,
//                                                                     color:status== 'Pending'?
//                                                                     Colors.red:status == 'Confirmed' ?
//                                                                     Colors.green:status == 'Booked'?
//                                                                     Colors.black:status == 'Canceled'? Colors.red : Colors.green
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: width(context)*0.01,
//                                                               ),
//                                                               Text(status,
//                                                                 style: text15500,
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: height(context)*0.01,),
//                                         Padding(
//                                           padding:  EdgeInsets.only(left: width(context)*0.12),
//                                           child: Divider(
//                                             color: Colors.grey.shade300,
//                                             thickness: 2,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//
//                             );
//                           }else{
//                             return  Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Image.asset(empty),
//                                 Text(AppLocale.noUpcomingBookings.getString(context))
//                               ],
//                             );
//                           }
//
//
//                         }
//
//                         return Container();
//                       },
//                     ),
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('orders').where('userIdB', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                           .where('status',whereIn: ['Complete', 'Canceled','Rejected' ])
//                           .snapshots(),
//                       builder: (BuildContext context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                             ),
//                           );
//                         } else if (snapshot.hasError) {
//                           return const Icon(Icons.error);
//                         } else if (snapshot.hasData) {
//                           // Extract the necessary data from `orderData` and `boatData`
//
//
//                           if(snapshot.data!.docs.isNotEmpty){
//                             List<DocumentSnapshot> sortedDocs = List.from(snapshot.data!.docs)
//                               ..sort((a, b) => b['orderId'].compareTo(a['orderId']));
//
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               // reverse: true,
//                               itemCount: sortedDocs.length,
//                               itemBuilder: (context, index) {
//                                 var snap = sortedDocs[index];
//                                 String boatName = snap["boatName"];
//                                 String imageUrl = snap["image1"];
//                                 double price = snap['Amount'];
//                                 String orderId = snap['orderId'];
//                                 String userId = snap['userId'];
//                                 String ownerId = snap['ownerId'];
//                                 String boatId = snap['boatId'];
//                                 String description = snap['aboutBoat'];
//                                 String startTime = snap['timeSlot'];
//                                 String startDate = snap['startDate'];
//                                 String endDate = snap['endDate'];
//                                 String status = snap['status'];
//                                 String hours = snap['totalHours'];
//                                 var orderTime = snap['orderTime'].toDate();
//
//
//                                 // String startTime = 'sd';
//                                 // String endTime = 'gsdf';
//                                 // String date = 'ksnda';
//                                 return InkWell(
//                                   onTap: (){
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => BookingDetails(
//                                               price: price.toString(),
//                                               endDate: endDate,
//                                               // endTime: endTime,
//                                               startDate: startDate,
//                                               name: boatName,
//                                               description: description,
//                                               startTime: startTime,
//                                               orderId: orderId,
//                                               status: status,
//                                               image: imageUrl, index: index,
//                                               hours: hours,
//                                               boatId: boatId,
//                                               ownerId: ownerId, orderTime: orderTime,
//                                             )));
//                                   },
//                                   child: Padding(
//                                     padding:
//                                     EdgeInsets.only(top: height(context)*0.02, left: width(context)*0.04, right: width(context)*0.04),
//                                     child: Column(
//
//                                       children: [
//                                         SizedBox(
//                                           height: height(context) * 0.14,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 width: width(context) * 0.22,
//                                                 height: width(context) * 0.22,
//                                                 clipBehavior: Clip.hardEdge,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       16),
//                                                 ),
//                                                 child: CachedNetworkImage(
//                                                   width: width(context),
//                                                   height: height(context),
//                                                   fit: BoxFit.cover,
//                                                   imageUrl: imageUrl,
//                                                   placeholder: (context,
//                                                       url) =>
//                                                   const Center(
//                                                       child:
//                                                       CircularProgressIndicator()),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                   const Icon(Icons.error),
//                                                 ),
//                                               ),
//                                               // SizedBox(
//                                               //   width: width(context)*0.02,
//                                               // ),
//                                               Column(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     height: height(context)*0.029,
//                                                     width: width(context)*0.65,
//
//                                                     decoration: BoxDecoration(
//                                                       gradient:
//                                                       const LinearGradient(
//                                                         colors: [
//                                                           Color(0xff006EFE),
//                                                           Color(0xff494AFF)
//                                                         ],
//                                                       ),
//                                                       borderRadius:
//                                                       BorderRadius
//                                                           .circular(16),
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                       const EdgeInsets
//                                                           .symmetric(
//                                                           horizontal:
//                                                           10.0),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             'Booking ID: $orderId',
//                                                             style:
//                                                             text11500white,
//                                                           ),
//                                                           const Icon(
//                                                             Icons
//                                                                 .arrow_forward_ios_sharp,
//                                                             color: Colors
//                                                                 .white,
//                                                             size: 15,
//                                                           ),
//                                                           // Row(
//                                                           //   children: [
//                                                           //     Text(
//                                                           //       AppLocale
//                                                           //           .viewDetails
//                                                           //           .getString(
//                                                           //               context),
//                                                           //       style:
//                                                           //           text11600white,
//                                                           //     ),
//                                                           //     const Icon(
//                                                           //       Icons
//                                                           //           .arrow_forward_ios_sharp,
//                                                           //       color: Colors
//                                                           //           .white,
//                                                           //       size: 15,
//                                                           //     ),
//                                                           //   ],
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: width(context)*0.55,
//                                                     height: height(context)*0.1,
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Text(boatName,
//                                                             style: text16500),
//                                                         SizedBox(
//                                                           width:
//                                                           width(context) * 0.55,
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                             children: [
//                                                               Text(
//                                                                   startTime,
//                                                                   style:
//                                                                   text11400op),
//                                                               // SizedBox(
//                                                               //   width:
//                                                               //   width(context) *
//                                                               //       0.155,
//                                                               // ),
//                                                               Text(startDate,
//                                                                   style:
//                                                                   text11400op),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width:
//                                                           width(context) * 0.6,
//                                                           height: height(context)*0.029,
//
//                                                           child: Row(
//
//                                                             children: [
//                                                               Container(
//
//                                                                 height: 10,//height(context)*0.03,
//                                                                 width: 10,
//                                                                 decoration: BoxDecoration(
//                                                                     shape: BoxShape.circle,
//                                                                     color: status == 'Pending'
//                                                                         ? Colors.red
//                                                                         : status == 'Confirmed'
//                                                                         ? Colors.green
//                                                                         : status == 'Booked'
//                                                                         ? Colors.black
//                                                                         : status == 'Canceled'
//                                                                         ? Colors.red
//                                                                         : status == 'Rejected'
//                                                                         ? Colors.red
//                                                                         : Colors.green),
//
//                                                               ),
//                                                               SizedBox(
//                                                                 width: width(context)*0.01,
//                                                               ),
//                                                               Text(status,
//                                                                 style: text15500,
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: height(context)*0.01,),
//                                         Padding(
//                                           padding:  EdgeInsets.only(left: width(context)*0.12),
//                                           child: Divider(
//                                             color: Colors.grey.shade300,
//                                             thickness: 2,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//
//                             );
//                           }else{
//                             return  Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Image.asset(empty),
//                                 Text(AppLocale.noPreviousBookings.getString(context))
//                               ],
//                             );
//                           }
//                         }
//
//                         return Container();
//                       },
//                     ),
//
//                     // Second Tab Content (you can add your desired content for the second tab here)
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
