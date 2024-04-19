// import 'package:boat_app/utils/colors.dart';
// import 'package:boat_app/utils/image_paths.dart';
// import 'package:boat_app/utils/sized_box.dart';
// import 'package:boat_app/utils/textstyles.dart';
// import 'package:boat_app/view/boat_details.dart';
// import 'package:boat_app/view/filter.dart';
// import 'package:boat_app/view/home_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../languages/LocaleString.dart';
// import '../../main.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
// int id = DateTime.now().microsecondsSinceEpoch;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Center(
//                     child: Text(
//                       AppLocale.boatApp.getString(context),
//                   style: text24500,
//                 )),
//                 SizedBox(
//                   height: height(context)*0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: width(context) * 0.75,
//                       child: TextFormField(
//
//                         decoration: InputDecoration(
//                           hintText: AppLocale.searchboatinyourarea.getString(context),
//                           hintStyle: text12400,
//                           fillColor: Color(0xffF3F4F9),
//                           filled: true,
//                           prefixIcon: Icon(Icons.search),
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: Color(0xffF3F4F9),
//                               ),
//                               borderRadius: BorderRadius.circular(16)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: Color(0xffF3F4F9),
//                               ),
//                               borderRadius: BorderRadius.circular(16)),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=> FilterScreen()));
//                         },
//                         child: Container(
//                           height: 50,
//                             width: 30,
//                             child: SvgPicture.asset(filter)))
//                   ],
//                 ),
//                 SizedBox(
//                   height: height(context) * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Offers_screen()));
//                       },
//                       child: Container(
//                         height: 28,
//                         width: 94,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.black),
//                         child: Center(
//                             child: Text(
//                           AppLocale.popular.getString(context),
//                           style: text14500white,
//                         )),
//                       ),
//                     ),
//                     Text(
//                       AppLocale.discover.getString(context),
//                       style: text14500,
//                     ),
//                     Text(
//                       AppLocale.domestic.getString(context),
//                       style: text14500,
//                     ),
//                     Text(
//                       AppLocale.explore.getString(context),
//                       style: text14500,
//                     ),
//                   ],
//                 ),
//                 StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('BoatData')
//                       .snapshots(),
//                   builder: (context, snapshot){
//                     if(snapshot.hasError){
//                       return Text('error');
//                     }
//                     if(snapshot.connectionState == ConnectionState.waiting){
//                       return const CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                       );
//                     }
//                     if(snapshot.hasData){
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: ( context,  index) {
//                           var snap = snapshot.data!.docs[index];
//                           String name = snap['boatName'];
//                           String imageUrl = snap['image1'];
//                           String price = snap['boatPrice'];
//                           String boatId = snap['boatId'];
//                           String maxPerson = snap['maxPerson'];
//
//                           String docName = snapshot.data!.docs[index].toString();
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
//                             child: InkWell(
//                               onTap: (){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=> BoatDetails(index: index,)));
//                               },
//                               child: Container(
//                                 width: width(context)*0.84,
//                                 height: height(context)*0.2,
//                                 child: Stack(
//                                   clipBehavior: Clip.none,
//                                   children: [
//                                     Container(
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(16)),
//                                       child:  CachedNetworkImage(
//                                         width: width(context),
//                                         height: height(context),
//                                         fit: BoxFit.cover,
//                                         imageUrl: imageUrl,
//                                         placeholder: (context, url) => Container(child: Center(child: CircularProgressIndicator())),
//                                         errorWidget: (context, url, error) => Icon(Icons.error),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       right: 10,
//                                       top: 10,
//                                       child: InkWell(
//                                         onTap: (){
//                                           FirebaseFirestore.instance.collection('fav')
//                                               .doc(FirebaseAuth.instance.currentUser!.uid).collection('items').doc(boatId).set(
//                                               {
//                                                 'index': index,
//                                                 'name' :name,
//                                                'imageUrl' : imageUrl,
//                                                'price': price,
//                                                'boatId' : boatId,
//
//                                               });
//                                         },
//                                         child: Container(
//                                           height: 30,
//                                           width: 30,
//                                           decoration: const BoxDecoration(
//                                               color: Color(0xff979797),
//                                               shape: BoxShape.circle),
//                                           child: const Icon(Icons.favorite, color: Colors.white,size: 20,),
//                                         ),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: -45,
//                                       child: Container(
//                                         width: width(context)*0.84,
//                                         decoration: BoxDecoration(
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   blurRadius: 5,
//                                                   color: Colors.grey,
//                                                   offset: Offset(0, 2)
//                                               )
//                                             ],
//                                             borderRadius: BorderRadius.circular(16),
//                                             color: Colors.white),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Row(
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                     children: [
//                                                       Text(
//                                                         name,
//                                                         style: text18600,
//                                                       ),
//                                                       Text(
//                                                         '(Available by Seat)',
//                                                         style: text8500,
//                                                       )
//                                                     ],
//                                                   ),
//                                                   const Text('Sea View, Premium Lifestyle'),
//                                                   Row(
//                                                     children: [
//                                                       const Icon(
//                                                         Icons.star,
//                                                         size: 15,
//                                                         color: Color(0xff494AFF),
//                                                       ),
//                                                       const Icon(
//                                                         Icons.star,
//                                                         size: 15,
//
//                                                         color: Color(0xff494AFF),
//                                                       ),
//                                                       const Icon(
//                                                         Icons.star,
//                                                         size: 15,
//
//                                                         color: Color(0xff494AFF),
//                                                       ),
//                                                       const Icon(
//                                                         Icons.star,
//                                                         size: 15,
//
//                                                         color: Color(0xff494AFF),
//                                                       ),
//                                                       Icon(
//                                                         Icons.star,
//                                                         size: 15,
//
//                                                         color: Colors.grey.shade500,
//                                                       ),
//                                                       Text(AppLocale.rating.getString(context), style: text11400,)
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                               Column(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                     height: 23,
//                                                     width: 79,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(10),
//                                                         color: Colors.black),
//                                                     child: Center(
//                                                         child: Text(
//                                                          'available',
//                                                           style: text10500white,
//                                                         )),
//                                                   ),
//                                                   SizedBox(height: 10,),
//                                                   Row(
//                                                     children: [
//                                                       Image(
//                                                           height: 20,
//                                                           width: 20,
//                                                           image: AssetImage(profile)),
//                                                       Text(maxPerson,style: text11400,),
//                                                       const SizedBox(
//                                                         width: 5,
//                                                       )
//                                                     ],
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//
//                       );
//                     }
//                     return Text('No data found');
//                   },
//
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
