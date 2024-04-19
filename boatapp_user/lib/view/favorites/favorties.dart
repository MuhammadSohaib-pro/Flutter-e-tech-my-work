import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/boat_details/boat_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/reuseable_container.dart';
import '../../languages/LocaleString.dart';
import '../../provider/fav_provider.dart';
import '../../utils/constants.dart';
import '../../utils/image_paths.dart';
import '../../utils/sized_box.dart';

class Favorties extends StatefulWidget {
  const Favorties({Key? key}) : super(key: key);

  @override
  State<Favorties> createState() => _FavortiesState();
}

class _FavortiesState extends State<Favorties> {

  String fId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider =
    Provider.of<BookmarkProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title:    Text(
        AppLocale.myFav.getString(context),
        style: TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w600,),
      ),
        elevation: 0, backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MySize2.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 20,),
              // Text(
              //   AppLocale.myFav.getString(context),
              //   style: TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w600),
              // ),
              // SizedBox(height: 10,),

              SizedBox(
                // height: height(context)*0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Fav')
                      .where('userId', isEqualTo: fId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<DocumentSnapshot> orderedDocs = snapshot.data!.docs;
                        orderedDocs.sort((a, b) {
                          int favIdA = int.parse(a['favId']);
                          int favIdB = int.parse(b['favId']);
                          return favIdB.compareTo(favIdA); // Change to 'favIdA.compareTo(favIdB)' for ascending order
                        });

                        return ListView.builder(
                          // reverse: true,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: orderedDocs.length,
                          itemBuilder: (context, index) {
                            String boatId = orderedDocs[index]['boatId'];

                            // if(snapshot.data!.docs[0]['id'] == FirebaseAuth.instance.currentUser!.uid){
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: MySize2.size8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BoatDetails(
                                                // index: index,
                                                boatId: boatId,)));
                                },
                                child: StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('BoatData')
                                        .doc(boatId)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      if (snapshot.hasData) {
                                        String name =
                                            snapshot.data!['boatName'];
                                        String imageUrl =
                                            snapshot.data!['image1'];
                                        String price =
                                            snapshot.data!['boatPrice'];
                                        String area =
                                        snapshot.data!['area'];
                                        // String hours =
                                        // snapshot.data!['totalHours'];
                                        print(snapshot.data!['userId'] +
                                            'fun' +
                                            index.toString());
                                        return Padding(
                                          padding:  EdgeInsets.symmetric(
                                              vertical: MySize2.size10),
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: MySize2.size60),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: MySize2.size110,
                                                  // width: width(context)*0.02,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(0x11000000),
                                                          blurRadius: 20,
                                                          offset: Offset(0, 4),
                                                          spreadRadius: 0,
                                                        )
                                                      ]
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: MySize2.size60, top: MySize2.size15, bottom: MySize2.size15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: MySize2.size16),),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.location_on, color: greyText,size: MySize2.size12,),
                                                                    Text(area, style: TextStyle(fontWeight: FontWeight.w400, fontSize: MySize2.size10, color: greyText),),
                                                                  ],
                                                                )

                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:  EdgeInsets.only(right: MySize2.size15),
                                                              child: InkWell(
                                                                        onTap: () async {

                                                                          bool isBookmarked =
                                                                          await bookmarkProvider
                                                                              .isContainerBookmarked(snapshot.data!
                                                                          ['boatId']);

                                                                          if (isBookmarked) {
                                                                            // bookmarkProvider.removeBookmark(id);
                                                                            bookmarkProvider.removeBookmarkF(snapshot.data!['boatId']);
                                                                            print('remove');
                                                                          } else {
                                                                            // Save the container as a bookmark
                                                                            // bookmarkProvider.addBookmark(id);
                                                                            bookmarkProvider.saveBookmark(
                                                                                id,
                                                                                snapshot.data!
                                                                                ['boatId'],
                                                                                FirebaseAuth
                                                                                    .instance.currentUser!.uid);
                                                                          }
                                                                          // FirebaseFirestore.instance.collection('Fav').doc(id).set(
                                                                          //     {
                                                                          //      'favId': id,
                                                                          //      'boatId':  snapshot.data!.docs[widget.index]['boatId'],
                                                                          //       'userId': FirebaseAuth.instance.currentUser!.uid,
                                                                          //
                                                                          //     });
                                                                        },
                                                                        child: Consumer<BookmarkProvider>(
                                                                          builder: (context, value, child) {
                                                                            return FutureBuilder<
                                                                                bool>(
                                                                              future: bookmarkProvider
                                                                                  .isContainerBookmarked(
                                                                                  snapshot
                                                                                      .data! ['boatId']),
                                                                              builder: (
                                                                                  context,
                                                                                  AsyncSnapshot<
                                                                                      bool> snapshotB) {
                                                                                bool isBookmarked = snapshotB
                                                                                    .data ??
                                                                                    false;
                                                                                return isBookmarked
                                                                                    ?
                                                                                Container(
                                                                                  height: MySize2
                                                                                      .size26,
                                                                                  width: MySize2
                                                                                      .size26,
                                                                                  decoration: const BoxDecoration(
                                                                                      color:greyf9f9f9,
                                                                                      shape: BoxShape
                                                                                          .circle),
                                                                                  child: Icon(
                                                                                    Icons
                                                                                        .favorite,
                                                                                    color: primaryColor,
                                                                                    size: MySize2
                                                                                        .size16,
                                                                                  ),
                                                                                )
                                                                                    :
                                                                                Container(
                                                                                  height: MySize2
                                                                                      .size26,
                                                                                  width: MySize2
                                                                                      .size26,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: greyf9f9f9,
                                                                                      shape: BoxShape
                                                                                          .circle),
                                                                                  child: Icon(
                                                                                    Icons
                                                                                        .favorite,
                                                                                    color: Colors
                                                                                        .white,
                                                                                    size: MySize2
                                                                                        .size16,
                                                                                  ),
                                                                                );
                                                                              },

                                                                            );
                                                                          })
                                                                  ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        Row(
                                                          children: [
                                                            Text('$price SAR', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: primaryColor),),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(

                                                  height: MySize2.size110,width:  MySize2.size100,

                                                  child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Positioned(
                                                          left: -MySize2.size60,
                                                          bottom: MySize2.size7,
                                                          child: Container(
                                                              clipBehavior: Clip.hardEdge,
                                                              height: MySize2.size96,width:  MySize2.size96,
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                              child: CachedNetworkImage(
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
                                          // ReusableContainer(
                                          //     child: Padding(
                                          //   padding:
                                          //       const EdgeInsets.all(20.0),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     children: [
                                          //       Row(
                                          //         children: [
                                          //           Container(
                                          //             width: width(context) *
                                          //                 0.2,
                                          //             height:
                                          //                 height(context) *
                                          //                     0.12,
                                          //             clipBehavior:
                                          //                 Clip.hardEdge,
                                          //             decoration:
                                          //                 BoxDecoration(
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(16),
                                          //             ),
                                          //             child:
                                          //                 CachedNetworkImage(
                                          //               width: width(context),
                                          //               height:
                                          //                   height(context),
                                          //               fit: BoxFit.cover,
                                          //               imageUrl: imageUrl,
                                          //               placeholder: (context,
                                          //                       url) =>
                                          //                   const Center(
                                          //                       child:
                                          //                           CircularProgressIndicator()),
                                          //               errorWidget: (context,
                                          //                       url, error) =>
                                          //                   const Icon(
                                          //                       Icons.error),
                                          //             ),
                                          //           ),
                                          //           SizedBox(
                                          //             width: width(context) *
                                          //                 0.05,
                                          //           ),
                                          //           Column(
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment
                                          //                     .start,
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment
                                          //                     .spaceBetween,
                                          //             children: [
                                          //               Container(
                                          //                 width: width(context)* 0.25,
                                          //                 child: Text(
                                          //                   name,
                                          //                   style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700, ),
                                          //                   overflow: TextOverflow.ellipsis,
                                          //                 ),
                                          //               ),
                                          //
                                          //               Row(
                                          //                 children: [
                                          //
                                          //                   Text(
                                          //                       snapshot.data!['area']
                                          //                   ),
                                          //                   Icon(Icons.location_on),
                                          //
                                          //
                                          //                 ],
                                          //               ),
                                          //               // Text(
                                          //               //   'With '+hours+
                                          //               //   ' hours of boating',
                                          //               //   style: text11400op,
                                          //               // ),
                                          //               SizedBox(
                                          //                 height: 5,
                                          //               ),
                                          //               Text(
                                          //                   '\$'+snapshot.data!['boatPrice'],style: TextStyle(
                                          //                 color: primaryColor, fontSize: 16,fontWeight: FontWeight.w600
                                          //               ),
                                          //               ),
                                          //               // Row(
                                          //               //   children: [
                                          //               //     FutureBuilder(
                                          //               //       future: getReviewAvg(snapshot.data!['boatId']),
                                          //               //       builder: (context, snapshot){
                                          //               //         if(snapshot.hasData){
                                          //               //           return  Row(
                                          //               //             children: [
                                          //               //               RatingBarIndicator(
                                          //               //                 itemSize: 20,
                                          //               //                 rating: snapshot.data!,
                                          //               //                 direction: Axis.horizontal,
                                          //               //                 itemCount: 5,
                                          //               //                 itemBuilder: (context, _) =>
                                          //               //                 const Icon(
                                          //               //                   Icons.star,
                                          //               //                   size: 10,
                                          //               //                   color: Colors.amber,
                                          //               //                 ),),
                                          //               //               SizedBox(
                                          //               //                 width: width(
                                          //               //                     context) *
                                          //               //                     0.02,
                                          //               //               ),
                                          //               //               Text(
                                          //               //                 snapshot.data != 0 ? AppLocale.rating
                                          //               //                     .getString(
                                          //               //                     context) : 'N/A',
                                          //               //                 style:
                                          //               //                 text11400,
                                          //               //               ),
                                          //               //             ],
                                          //               //           );
                                          //               //
                                          //               //         }else if(snapshot.hasError){
                                          //               //           return Icon(Icons.error);
                                          //               //         }
                                          //               //         return Container();
                                          //               //
                                          //               //       },
                                          //               //     ),
                                          //               //
                                          //               //
                                          //               //     SizedBox(
                                          //               //       width: width(
                                          //               //               context) *
                                          //               //           0.1,
                                          //               //     ),
                                          //               //   ],
                                          //               // )
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       ),
                                          //       // Column(
                                          //       //   mainAxisAlignment:
                                          //       //       MainAxisAlignment
                                          //       //           .center,
                                          //       //   children: [
                                          //       //     Text('\$$price'),
                                          //       //     SizedBox(
                                          //       //       height:
                                          //       //           height(context) *
                                          //       //               0.03,
                                          //       //     ),
                                          //       //     Row(
                                          //       //       children: [
                                          //       //         Image(
                                          //       //             height: 20,
                                          //       //             width: 20,
                                          //       //             image: AssetImage(
                                          //       //                 profile)),
                                          //       //         Text(
                                          //       //           snapshot.data![
                                          //       //               'maxPerson'],
                                          //       //           style: text11400,
                                          //       //         ),
                                          //       //       ],
                                          //       //     )
                                          //       //   ],
                                          //       // )
                                          //       FirebaseAuth.instance.currentUser == null ? Container(): InkWell(
                                          //         onTap: () async {
                                          //
                                          //           bool isBookmarked =
                                          //           await bookmarkProvider
                                          //               .isContainerBookmarked(snapshot.data!
                                          //           ['boatId']);
                                          //
                                          //           if (isBookmarked) {
                                          //             // bookmarkProvider.removeBookmark(id);
                                          //             bookmarkProvider.removeBookmarkF(snapshot.data!['boatId']);
                                          //             print('remove');
                                          //           } else {
                                          //             // Save the container as a bookmark
                                          //             // bookmarkProvider.addBookmark(id);
                                          //             bookmarkProvider.saveBookmark(
                                          //                 id,
                                          //                 snapshot.data!
                                          //                 ['boatId'],
                                          //                 FirebaseAuth
                                          //                     .instance.currentUser!.uid);
                                          //           }
                                          //           // FirebaseFirestore.instance.collection('Fav').doc(id).set(
                                          //           //     {
                                          //           //      'favId': id,
                                          //           //      'boatId':  snapshot.data!.docs[widget.index]['boatId'],
                                          //           //       'userId': FirebaseAuth.instance.currentUser!.uid,
                                          //           //
                                          //           //     });
                                          //         },
                                          //         child: Consumer<BookmarkProvider>(
                                          //           builder: (context, value, child){
                                          //             return  FutureBuilder<bool>(
                                          //               future: bookmarkProvider.isContainerBookmarked(snapshot.data! ['boatId']),
                                          //               builder: (context, AsyncSnapshot<bool> snapshotB){
                                          //                 bool isBookmarked = snapshotB.data ?? false;
                                          //                 return isBookmarked ?
                                          //                 Container(
                                          //                   height: MySize2.size40,
                                          //                   width: MySize2.size40,
                                          //                   decoration: const BoxDecoration(
                                          //                       color: Color(0xfff0f0f0),
                                          //                       shape: BoxShape.circle),
                                          //                   child:   Icon(
                                          //                     Icons.favorite,
                                          //                     color:   primaryColor,
                                          //                     size: MySize2.size25,
                                          //                   ),
                                          //                 )
                                          //                     :
                                          //                 Container(
                                          //                   height: MySize2.size40,
                                          //                   width: MySize2.size40,
                                          //                   decoration: const BoxDecoration(
                                          //                       color: Color(0xfff0f0f0),
                                          //                       shape: BoxShape.circle),
                                          //                   child:   Icon(
                                          //                     Icons.favorite,
                                          //                     color:   Colors.white,
                                          //                     size: MySize2.size25,
                                          //                   ),
                                          //                 );
                                          //               },
                                          //
                                          //             );
                                          //           },
                                          //
                                          //         ),
                                          //       ),
                                          //
                                          //     ],
                                          //   ),
                                          // )),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text('error');
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child:
                                                CircularProgressIndicator());
                                      }
                                      return Container();
                                    }),
                              ),
                            );
                          },
                        );
                      } else {
                        return  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(empty),
                            Center(child: Text(AppLocale.noFavBoats.getString(context)))
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return const Text('error');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
