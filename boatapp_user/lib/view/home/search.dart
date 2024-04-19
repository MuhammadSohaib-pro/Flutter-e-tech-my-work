// import 'package:boat_app/custom_widgets/app_text_field.dart';
// import 'package:boat_app/custom_widgets/back_arrow.dart';
// import 'package:boat_app/custom_widgets/big_divider.dart';
// import 'package:boat_app/utils/image_paths.dart';
// import 'package:boat_app/utils/sized_box.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:input_history_text_field/input_history_text_field.dart';
//
// import '../../languages/LocaleString.dart';
// import '../../utils/colors.dart';
// import '../../utils/textstyles.dart';
// import '../boat_details.dart';
//
// class SearchBoat extends StatefulWidget {
//   const SearchBoat({Key? key}) : super(key: key);
//
//   @override
//   State<SearchBoat> createState() => _SearchBoatState();
// }
//
// class _SearchBoatState extends State<SearchBoat> {
//   List<String> searchHistroy = [
//     'boot'
//
//   ];
// TextEditingController searchController = TextEditingController();
// @override
//   void dispose() {
//   searchController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Back_Arrow(
//                           image: back_simple,
//                           ontap: (){
//                             // print(searchController.text);
//                             Navigator.pop(context);
//                             },
//                         ),
//                         Container(
//                           width: width(context) * 0.65,
//                           height: height(context)*0.06,
//                           child:  InputHistoryTextField(
//
//
//                             onSubmitted: (value){
//
//                               setState(() {
//
//                               });
//                             },
//                             // onChanged: (value){
//                             //   setState(() {
//                             //
//                             //   });
//                             // },
//                             keyboardType: TextInputType.text,
//                             textEditingController: searchController,
//                             historyKey: "01",
//                             limit: 5,
//                             listStyle: ListStyle.List,
//                             decoration:  InputDecoration(
//                               fillColor: Colors.grey.shade300,
//                                 filled: true,
//                                 prefixIcon: Icon(Icons.search),
//                                 isDense: true,
//                                 hintText: AppLocale.search.getString(context),
//
//                             alignLabelWithHint: true,
//
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none
//
//                             ),
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                   borderSide: BorderSide.none
//                               ),
//
//                             ),
//
//                           ),
//                           // TextField(
//                           //   controller: searchController,
//                           //
//                           //
//                           //
//                           //   decoration: InputDecoration(
//                           //     hintText: AppLocale.searchboatinyourarea.getString(context),
//                           //     hintStyle: text12400,
//                           //     fillColor: const Color(0xffF3F4F9),
//                           //     filled: true,
//                           //     prefixIcon: IconButton(icon: Icon(Icons.search),
//                           //       onPressed: () {
//                           //       // setState(() {
//                           //       //   searchController.clear();
//                           //       // });
//                           //       },) ,
//                           //     suffixIcon: Container(
//                           //       margin: const EdgeInsets.all(15),
//                           //         decoration: const BoxDecoration(
//                           //             shape: BoxShape.circle,
//                           //             color: Color(0xff2E3E5C)
//                           //         ),
//                           //         child: const Icon(Icons.close, color: Colors.white,)),
//                           //     disabledBorder: OutlineInputBorder(
//                           //         borderSide: const BorderSide(
//                           //           color: Color(0xffF3F4F9),
//                           //         ),
//                           //         borderRadius: BorderRadius.circular(16)),
//                           //     enabledBorder:   OutlineInputBorder(
//                           //   borderSide: const BorderSide(
//                           //   color: Color(0xffF3F4F9),
//                           // ),
//                           //   borderRadius: BorderRadius.circular(16)),
//                           //
//                           //     focusedBorder: OutlineInputBorder(
//                           //         borderSide: const BorderSide(
//                           //           color: Color(0xffF3F4F9),
//                           //         ),
//                           //         borderRadius: BorderRadius.circular(16)),
//                           //   ),
//                           // ),
//                         ),
//                         Image(
//
//                             height: height(context)*0.035,
//                             image: AssetImage(searchfilter))
//                       ],
//                     ),
//
//                   ],
//
//                 ),
//               ),
//
//               searchController.text.isNotEmpty == true ?
//               Container(
//                 height: height(context)*0.7,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: width(context)*0.04),
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('BoatData')
//                           .snapshots(),
//                       builder: (context, snapshot){
//                         if(snapshot.hasError){
//                           return Text('error');
//                         }
//                         if(snapshot.connectionState == ConnectionState.waiting){
//                           return const CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                           );
//                         }
//                         if(snapshot.hasData){
//
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: ( context,  index) {
//                               var snap = snapshot.data!.docs[index];
//                               String name = snap['boatName'];
//                               String imageUrl = snap['image1'];
//                               String price = snap['boatPrice'];
//                               String location = snap['area'];
//                               String maxPerson = snap['maxPerson'];
//
//                               String docName = snapshot.data!.docs[index].toString();
//                               print(snapshot.data!.docs[index]["boatName"]+ ' asdasd');
//
//
//                               if( !name.toLowerCase().contains(searchController.text.toLowerCase()) ){
//                                 return SizedBox.shrink(); // Return an empty widget if the condition is false
//
//
//                               }else{
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
//                                   child: InkWell(
//                                     onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                                           BoatDetails(
//                                             // index: index,
//                                             boatId: snap['boatId'],)));
//                                     },
//                                     child: Container(
//                                       width: width(context)*0.84,
//                                       height: height(context)*0.2,
//
//                                       child: Stack(
//                                         clipBehavior: Clip.none,
//                                         children: [
//                                           Container(
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(16)),
//                                             child:  CachedNetworkImage(
//                                               width: width(context),
//                                               height: height(context),
//                                               fit: BoxFit.cover,
//                                               imageUrl: imageUrl,
//                                               placeholder: (context, url) => Container(child: Center(child: CircularProgressIndicator())),
//                                               errorWidget: (context, url, error) => Icon(Icons.error),
//                                             ),
//                                           ),
//
//                                           Positioned(
//                                             bottom: -45,
//                                             child: Container(
//                                               width: width(context)*0.87,
//                                               decoration: BoxDecoration(
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         blurRadius: 5,
//                                                         color: Colors.grey,
//                                                         offset: Offset(0, 2)
//                                                     )
//                                                   ],
//                                                   borderRadius: BorderRadius.circular(16),
//                                                   color: Colors.white),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Row(
//                                                           crossAxisAlignment:
//                                                           CrossAxisAlignment.center,
//                                                           children: [
//                                                             Text(
//                                                               name,
//                                                               style: text18600,
//                                                             ),
//
//                                                           ],
//                                                         ),
//                                                          Text(location,),
//                                                         Row(
//                                                           children: [
//                                                             const Icon(
//                                                               Icons.star,
//                                                               size: 15,
//                                                               color: Color(0xff494AFF),
//                                                             ),
//                                                             const Icon(
//                                                               Icons.star,
//                                                               size: 15,
//
//                                                               color: Color(0xff494AFF),
//                                                             ),
//                                                             const Icon(
//                                                               Icons.star,
//                                                               size: 15,
//
//                                                               color: Color(0xff494AFF),
//                                                             ),
//                                                             const Icon(
//                                                               Icons.star,
//                                                               size: 15,
//
//                                                               color: Color(0xff494AFF),
//                                                             ),
//                                                             Icon(
//                                                               Icons.star,
//                                                               size: 15,
//
//                                                               color: Colors.grey.shade500,
//                                                             ),
//                                                             Text(AppLocale.rating.getString(context), style: text11400,)
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                     Column(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             Image(
//                                                                 height: 20,
//                                                                 width: 20,
//                                                                 image: AssetImage(profile)),
//                                                             Text(maxPerson,style: text11400,),
//                                                             const SizedBox(
//                                                               width: 5,
//                                                             )
//                                                           ],
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//
//
//                             },
//
//                           );
//                         }
//                         return Text('No data found');
//                       },
//
//                     ),
//                   ),
//                 ),
//               )
//
//                   :
//
//               Column(
//                 children: [
//                   Big_divider(),
//
//
//
//                 ],
//               ),
//
//
//
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
