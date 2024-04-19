// import 'package:boat_app/custom_widgets/back_arrow.dart';
// import 'package:boat_app/provider/filter_provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:provider/provider.dart';
//
// import '../../../languages/LocaleString.dart';
// import '../../../utils/image_paths.dart';
// import '../../../utils/sized_box.dart';
// import '../../../utils/textstyles.dart';
// import '../../boat_details.dart';
//
// class SearchResult extends StatelessWidget {
//   final String? search;
//   SearchResult({super.key, required this.search});
//   late bool noResult = false;
//   @override
//   Widget build(BuildContext context) {
//     final filterProvider = Provider.of<FilterProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back_ios_new),
//         ),
//         title: Text('Search Results'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('BoatData')
//                     // .where('boatName', isEqualTo: search)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Loading state
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     // Error state
//                     return Center(
//                         child: Text('Error: ${snapshot.error.toString()}'));
//                   } else if (!snapshot.hasData) {
//                     // No data state
//                     return Center(child: Text('No data available'));
//                   } else {
//                     // Data available state
//                     List<Map<String, dynamic>> dataList = snapshot.data!.docs
//                         .map((doc) => doc.data() as Map<String, dynamic>)
//                         .toList();
//
//                     // Check if there are any matching results
//                     // bool hasMatchingResults = dataList.any((item) =>
//                     //     item['boatName'].toLowerCase().contains(search!.toLowerCase()));
//
//                     return dataList.any((item) => item['boatName']
//                             .toLowerCase()
//                             .contains(search!.toLowerCase())) // 1st Condition
//                         ?
//
//                     // if 1st cond == true
//                     filterProvider.sprice != null &&   // 2nd cond
//                                 filterProvider.eprice != null &&
//                                 filterProvider.spassengers != null &&
//                                 filterProvider.epassengers != null &&
//                                 filterProvider.boatType != null &&
//                                 filterProvider.boatindex != null
//                             ?
//
//                     //if 2nd cond == true
//                     dataList.any((item) =>
//                                         int.parse(item['boatPrice']) >
//                                         filterProvider.sprice!) &&  // 3rd cond
//                                     dataList.any((item) =>
//                                         int.parse(item['boatPrice']) <
//                                         filterProvider.eprice!)
//                                 ?
//                     //if 3rd cond == true
//                     ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     itemCount: dataList
//                                         .length, //noResult == false ? snapshot.data!.docs.length : 1,
//                                     itemBuilder: (context, index) {
//                                       var snap = snapshot.data!.docs[index];
//                                       String name = snap['boatName'];
//                                       String imageUrl = snap['image1'];
//                                       String price = snap['boatPrice'];
//                                       String location = snap['area'];
//                                       String maxPerson = snap['maxPerson'];
//                                       String boatType = snap['boatType'];
//
//                                       String docName =
//                                           snapshot.data!.docs[index].toString();
//                                       print('nahi ana tha');
//                                       print(maxPerson);
//                                       print(filterProvider.spassengers);
//                                       print(filterProvider.epassengers);
//
//
//                                       if (!name
//                                           .toLowerCase()
//                                           .contains(search!.toLowerCase())) {
//                                         noResult = true;
//                                         print(noResult);
//                                         return Container();
//                                          // Return an empty widget if the condition is false
//                                       } else {
//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10.0, vertical: 30),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           BoatDetails(
//                                                             // index: index,
//                                                             boatId:
//                                                                 snap['boatId'],
//                                                           )));
//                                             },
//                                             child: Stack(
//                                               clipBehavior: Clip.none,
//                                               children: [
//                                                 Container(
//                                                   width: width(context) * 0.95,
//                                                   height: height(context) * 0.2,
//                                                   clipBehavior: Clip.antiAlias,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16)),
//                                                   child: CachedNetworkImage(
//                                                     width: width(context),
//                                                     height: height(context),
//                                                     fit: BoxFit.cover,
//                                                     imageUrl: imageUrl,
//                                                     placeholder: (context,
//                                                             url) =>
//                                                         Container(
//                                                             child: Center(
//                                                                 child:
//                                                                     CircularProgressIndicator())),
//                                                     errorWidget:
//                                                         (context, url, error) =>
//                                                             Icon(Icons.error),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   bottom: -45,
//                                                   child: Container(
//                                                     width:
//                                                         width(context) * 0.95,
//                                                     decoration: BoxDecoration(
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               blurRadius: 5,
//                                                               color:
//                                                                   Colors.grey,
//                                                               offset:
//                                                                   Offset(0, 2))
//                                                         ],
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(16),
//                                                         color: Colors.white),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Row(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   Text(
//                                                                     name,
//                                                                     style:
//                                                                         text18600,
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               Text(
//                                                                 location,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   const Icon(
//                                                                     Icons.star,
//                                                                     size: 15,
//                                                                     color: Color(
//                                                                         0xff494AFF),
//                                                                   ),
//                                                                   const Icon(
//                                                                     Icons.star,
//                                                                     size: 15,
//                                                                     color: Color(
//                                                                         0xff494AFF),
//                                                                   ),
//                                                                   const Icon(
//                                                                     Icons.star,
//                                                                     size: 15,
//                                                                     color: Color(
//                                                                         0xff494AFF),
//                                                                   ),
//                                                                   const Icon(
//                                                                     Icons.star,
//                                                                     size: 15,
//                                                                     color: Color(
//                                                                         0xff494AFF),
//                                                                   ),
//                                                                   Icon(
//                                                                     Icons.star,
//                                                                     size: 15,
//                                                                     color: Colors
//                                                                         .grey
//                                                                         .shade500,
//                                                                   ),
//                                                                   Text(
//                                                                     AppLocale
//                                                                         .rating
//                                                                         .getString(
//                                                                             context),
//                                                                     style:
//                                                                         text11400,
//                                                                   )
//                                                                 ],
//                                                               )
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .end,
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Image(
//                                                                       height:
//                                                                           20,
//                                                                       width: 20,
//                                                                       image: AssetImage(
//                                                                           profile)),
//                                                                   Text(
//                                                                     maxPerson,
//                                                                     style:
//                                                                         text11400,
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 5,
//                                                                   )
//                                                                 ],
//                                                               )
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                   )
//                                 :
//                     //if 3rd cond == false
//                     Center(child: Text('${filterProvider.sprice } ${filterProvider.eprice}'))
//                             :
//                     //if 2nd cond == false
//                     ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: dataList.length,
//                                 itemBuilder: (context, index) {
//                                   var snap = snapshot.data!.docs[index];
//                                   String name = snap['boatName'];
//                                   String imageUrl = snap['image1'];
//                                   String price = snap['boatPrice'];
//                                   String location = snap['area'];
//                                   String maxPerson = snap['maxPerson'];
//                                   String boatType = snap['boatType'];
//
//                                   String docName =
//                                       snapshot.data!.docs[index].toString();
//
//                                   if (!name
//                                       .toLowerCase()
//                                       .contains(search!.toLowerCase())) {
//                                     noResult = true;
//                                     print(noResult);
//                                     return Container();
//                                     ; // Return an empty widget if the condition is false
//                                   } else {
//
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0, vertical: 30),
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         BoatDetails(
//                                                           // index: index,
//                                                           boatId:
//                                                               snap['boatId'],
//                                                         )));
//                                           },
//                                           child: Stack(
//                                             clipBehavior: Clip.none,
//                                             children: [
//                                               Container(
//                                                 width: width(context) * 0.95,
//                                                 height: height(context) * 0.2,
//                                                 clipBehavior: Clip.antiAlias,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             16)),
//                                                 child: CachedNetworkImage(
//                                                   width: width(context),
//                                                   height: height(context),
//                                                   fit: BoxFit.cover,
//                                                   imageUrl: imageUrl,
//                                                   placeholder: (context, url) =>
//                                                       Container(
//                                                           child: Center(
//                                                               child:
//                                                                   CircularProgressIndicator())),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Icon(Icons.error),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 bottom: -45,
//                                                 child: Container(
//                                                   width: width(context) * 0.95,
//                                                   decoration: BoxDecoration(
//                                                       boxShadow: const [
//                                                         BoxShadow(
//                                                             blurRadius: 5,
//                                                             color: Colors.grey,
//                                                             offset:
//                                                                 Offset(0, 2))
//                                                       ],
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               16),
//                                                       color: Colors.white),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 Text(
//                                                                   name,
//                                                                   style:
//                                                                       text18600,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             Text(
//                                                               location,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 const Icon(
//                                                                   Icons.star,
//                                                                   size: 15,
//                                                                   color: Color(
//                                                                       0xff494AFF),
//                                                                 ),
//                                                                 const Icon(
//                                                                   Icons.star,
//                                                                   size: 15,
//                                                                   color: Color(
//                                                                       0xff494AFF),
//                                                                 ),
//                                                                 const Icon(
//                                                                   Icons.star,
//                                                                   size: 15,
//                                                                   color: Color(
//                                                                       0xff494AFF),
//                                                                 ),
//                                                                 const Icon(
//                                                                   Icons.star,
//                                                                   size: 15,
//                                                                   color: Color(
//                                                                       0xff494AFF),
//                                                                 ),
//                                                                 Icon(
//                                                                   Icons.star,
//                                                                   size: 15,
//                                                                   color: Colors
//                                                                       .grey
//                                                                       .shade500,
//                                                                 ),
//                                                                 Text(
//                                                                   AppLocale
//                                                                       .rating
//                                                                       .getString(
//                                                                           context),
//                                                                   style:
//                                                                       text11400,
//                                                                 )
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                         Column(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .end,
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Image(
//                                                                     height: 20,
//                                                                     width: 20,
//                                                                     image: AssetImage(
//                                                                         profile)),
//                                                                 Text(
//                                                                   maxPerson,
//                                                                   style:
//                                                                       text11400,
//                                                                 ),
//                                                                 const SizedBox(
//                                                                   width: 5,
//                                                                 )
//                                                               ],
//                                                             )
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       );
//
//                                   }
//                                 },
//                               )
//                         :
//                     //if 1st cond== false
//                     Center(child: Text('No boat found'));
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
