import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../../../languages/LocaleString.dart';
import '../../../../utils/sized_box.dart';
import '../../../../utils/sizes.dart';
import '../../../../utils/textstyles.dart';
import '../../../boat_details/boat_details.dart';
import '../../full_home_screen.dart';
import '../provider/homescreen_tile_provider.dart';

class BoatCardWidget extends StatefulWidget {
 final String name;
 final Stream<QuerySnapshot<Object?>>? Ste, streamFeatured;

  const BoatCardWidget({super.key, required this.name, required this.Ste, required this.streamFeatured});

  @override
  State<BoatCardWidget> createState() => _BoatCardWidgetState();
}

class _BoatCardWidgetState extends State<BoatCardWidget> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  var stream = FirebaseFirestore.instance.collection('BoatData').where('boatStatusApproved', isEqualTo: true).snapshots();
  var streamFeatured = FirebaseFirestore.instance.collection('BoatData').where('feature', isEqualTo: true).where('boatStatusApproved', isEqualTo: true).snapshots();
// void getAll(){
//   if(widget.name == 'all'){
//      setState(() {
//        stream = FirebaseFirestore.instance
//            .collection('BoatData')
//            .snapshots();
//        streamFeatured = FirebaseFirestore.instance.collection('BoatData').where('feature', isEqualTo: true).snapshots();
//      });
//   }else{
//    setState(() {
//      stream = FirebaseFirestore.instance
//          .collection('BoatData').
//      where('boatType', isEqualTo: widget.name)
//          .snapshots();
//      streamFeatured = FirebaseFirestore.instance
//          .collection('BoatData').
//      where('boatType', isEqualTo: widget.name).where('feature', isEqualTo: true)
//          .snapshots();
//    });
//   }
// }

@override
  void initState() {
  // getAll();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final tileProvider = Provider.of<HomeScreenTileProvider>(context, listen: false);
    MySize2().init(context);
    return   Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(top:MySize2.size10,bottom: height(context)*0.01, left: MySize2.size20,right: MySize2.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocale.featuredBoat.getString(context)
                , style: TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w600,),),
            ],
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       Container(
        //         width: width(context)*0.8,
        //
        //         child: Stack(
        //           children: [
        //             Container(
        //               width: width(context)*0.8,
        //               clipBehavior: Clip.antiAlias,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(16)),
        //
        //               child: Image(
        //                 width: width(context),
        //                 image: AssetImage(boat1),
        //               ),
        //             ),
        //             Container(
        //               height: height(context)*0.2,
        //               width: width(context)*0.8,
        //               decoration: BoxDecoration(
        //                   color: Colors.black38,
        //                   borderRadius: BorderRadius.circular(15)
        //               ),
        //             ),
        //             Positioned(
        //               right: 10,
        //               top: 50,
        //               child: Column(
        //                 children: [
        //                   Text('Lorem Ipsum', style: text16500white,),
        //                   Text('Flat 12% Off', style: text23600white,),
        //                   Text('Boating Experiences', style: text12400white,)
        //
        //                 ],
        //               ),
        //             ),
        //             Positioned(
        //               bottom: 0,
        //               child: Container(
        //                 height: 36,
        //                 width: width(context)*0.8,
        //                 decoration: const BoxDecoration(
        //                     color: Color(0xff494AFF),
        //                     borderRadius: BorderRadius.only(
        //                         bottomLeft: Radius.circular(15),
        //                         bottomRight: Radius.circular(15)
        //                     )
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text('Valid till June 30', style: text12400white,),
        //                       Container(
        //                         height: 24,
        //                         width: 72,
        //                         decoration: BoxDecoration(
        //                             color: Colors.black,
        //                             borderRadius: BorderRadius.circular(15)
        //                         ),
        //                         child: Center(child: Text('View More', style: text12400white,)),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       SizedBox(width: width(context)*0.02,),
        //       Container(
        //         width: width(context)*0.8,
        //
        //         child: Stack(
        //           children: [
        //             Container(
        //               width: width(context)*0.8,
        //               clipBehavior: Clip.antiAlias,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(16)),
        //
        //               child: Image(
        //                 width: width(context),
        //                 image: AssetImage(boat1),
        //               ),
        //             ),
        //             Container(
        //               height: height(context)*0.2,
        //               width: width(context)*0.8,
        //               decoration: BoxDecoration(
        //                 color: Colors.black38,
        //                 borderRadius: BorderRadius.circular(15)
        //               ),
        //             ),
        //             Positioned(
        //               right: 10,
        //               top: 50,
        //               child: Column(
        //                 children: [
        //                   Text('Lorem Ipsum', style: text16500white,),
        //                   Text('Flat 12% Off', style: text23600white,),
        //                   Text('Boating Experiences', style: text12400white,)
        //
        //                 ],
        //               ),
        //             ),
        //             Positioned(
        //               bottom: 0,
        //               child: Container(
        //                 height: 36,
        //                 width: width(context)*0.8,
        //                 decoration: const BoxDecoration(
        //                   color: Color(0xff494AFF),
        //                   borderRadius: BorderRadius.only(
        //                       bottomLeft: Radius.circular(15),
        //                     bottomRight: Radius.circular(15)
        //                   )
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text('Valid till June 30', style: text12400white,),
        //                       Container(
        //                         height: 24,
        //                         width: 72,
        //                         decoration: BoxDecoration(
        //                           color: Colors.black,
        //                           borderRadius: BorderRadius.circular(15)
        //                         ),
        //                         child: Center(child: Text('View More', style: text12400white,)),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Container(
          height: height(context)*0.22,
          child: Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.streamFeatured ?? streamFeatured,
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return const Icon(Icons.error);
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasData){
                  if(snapshot.data!.docs.isNotEmpty){
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          var snap = snapshot.data!.docs[index];
                          String image = snap['image1'];
                          // String orderId = snap['orderId'];

                          return Padding(
                            padding:  EdgeInsets.only(left:MySize2.size20),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width(context)*0.8,
                                    // height: height(context)*0.15,

                                    child: Stack(
                                      children: [
                                        Container(
                                          width: width(context)*0.8,
                                          height: height(context)*0.2,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16)),

                                          child: CachedNetworkImage(

                                            fit: BoxFit.cover,

                                            imageUrl: image,
                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                        Container(
                                          height: height(context)*0.2,
                                          width: width(context)*0.8,
                                          decoration: BoxDecoration(
                                              color: Colors.black38,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                        ),
                                        Positioned(
                                          right: MySize2.size10,
                                          top: MySize2.size30,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('1 Day',
                                                style:  TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w500, color: Colors.white),),
                                              Container(
                                                  width: width(context)*0.25,
                                                  child: Text(snap['boatName'],
                                                    style: TextStyle(fontSize: MySize2.size23, fontWeight: FontWeight.w600,color: Colors.white)
                                                    ,overflow: TextOverflow.ellipsis,)),
                                              Text('Boating Experiences',
                                                style:  TextStyle(fontSize: MySize2.size12, fontWeight: FontWeight.w400,color:
                                              Colors.white,)
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            height: MySize2.size44,
                                            width: width(context)*0.8,
                                            decoration:  BoxDecoration(
                                                color: Color(0xffffffff).withOpacity(0.2),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(15),
                                                    bottomRight: Radius.circular(15)
                                                )
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: MySize2.size15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // localization.currentLocale.toString() == 'en'?
                                                  // const Row(
                                                  //   children: [
                                                  //     // Text(AppLocale.validTill.getString(context), style: text12400white,),
                                                  //     // StreamBuilder(stream: FirebaseFirestore.instance.collection('BoatData')
                                                  //     //     .doc(snapshot.data!.docs[index]['boatId']).collection('daysTime').snapshots(),
                                                  //     //     builder: (context, snap){
                                                  //     //       if(snapshot.hasError){
                                                  //     //         return const Icon(Icons.error);
                                                  //     //       }
                                                  //     //       else if(snapshot.connectionState == ConnectionState.waiting){
                                                  //     //         return const Center(child: CircularProgressIndicator());
                                                  //     //       }
                                                  //     //       else if(snapshot.hasData){
                                                  //     //         if(snapshot.data!.docs.isNotEmpty){
                                                  //     //           return   Text(snap.data!.docs[0]['endTime'], style: text12400white,);
                                                  //     //       }
                                                  //     //         else{
                                                  //     //           return const Column(
                                                  //     //             children: [
                                                  //     //               // Image.asset(empty),
                                                  //     //               Text(' N/A')
                                                  //     //             ],
                                                  //     //           );
                                                  //     //         }
                                                  //     //       }
                                                  //     //       else{
                                                  //     //         return const Text('Nothing');
                                                  //     //       }
                                                  //     //     })
                                                  //   ],
                                                  // ):
                                                  // Row(
                                                  //   children: [
                                                  //     // StreamBuilder(stream: FirebaseFirestore.instance.collection('BoatData')
                                                  //     //     .doc(snapshot.data!.docs[index]['boatId']).collection('daysTime').snapshots(),
                                                  //     //     builder: (context, snap){
                                                  //     //       if(snapshot.hasError){
                                                  //     //         return const Icon(Icons.error);
                                                  //     //       }
                                                  //     //       else if(snapshot.connectionState == ConnectionState.waiting){
                                                  //     //         return const Center(child: CircularProgressIndicator());
                                                  //     //       }
                                                  //     //       else if(snapshot.hasData){
                                                  //     //         if(snapshot.data!.docs.isNotEmpty){
                                                  //     //           return   Text(snap.data!.docs[0]['endTime'], style: text12400white,);
                                                  //     //         }
                                                  //     //         else{
                                                  //     //           return const Column(
                                                  //     //             children: [
                                                  //     //               // Image.asset(empty),
                                                  //     //               Text(' N/A')
                                                  //     //             ],
                                                  //     //           );
                                                  //     //         }
                                                  //     //       }
                                                  //     //       else{
                                                  //     //         return const Text('Nothing');
                                                  //     //       }
                                                  //     //     })   ,
                                                  //     Text(AppLocale.validTill.getString(context), style: text12400white,),
                                                  //   ],
                                                  // ),
                                                  SizedBox(width: width(context)*0.02,),

                                                  InkWell(
                                                    onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> BoatDetails(boatId: snap['boatId'],)));
                                                      // FirebaseFirestore.instance.collection('orders').doc(orderId).update(
                                                      //     {
                                                      //       'status': 'Canceled'
                                                      //     }).then((value) {
                                                      //
                                                      // });


                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BoatDetails(boatId: snap['boatId'])));

                                                    },
                                                    child: Container(
                                                      height: MySize2.size24,
                                                      width: MySize2.size90,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.4),
                                                          borderRadius: BorderRadius.circular(15)
                                                      ),
                                                      child: Center(child: Text(AppLocale.viewMore.getString(context), style: text12400white,)),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });

                  }
                  else{
                    return  Column(
                      children: [
                        // Image.asset(empty),
                        Text(AppLocale.noFeaturedBoats.getString(context))
                      ],
                    );
                  }
                }
                else{
                  return const Text('Nothing');
                }
                return Container();
              },
            ),
          ),
        ),
        Padding(
          padding:   EdgeInsets.only(top:MySize2.size10,left: MySize2.size20,right: MySize2.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text( AppLocale.categories.getString(context),
                style:  TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w600,),),
              GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageRouteBuilder(
                        pageBuilder: (context, animation1,animation2)=>  FullHomeScreen(boatType: tileProvider.getName!,),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero
                    ));
                  },
                  child:   Text(AppLocale.explore.getString(context),
                    style:TextStyle(fontSize: MySize2.size14,
                      fontWeight: FontWeight.w400,
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor, // You can set the color of the underline
                    ) ,))
            ],
          ),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(vertical: MySize2.size15,horizontal: MySize2.size20),
          child: Center(
            child: Consumer<HomeScreenTileProvider>(
              builder: (context, value, child){
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('typesOfBoats').where('status', isEqualTo: 'available').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        tileProvider.updateSelectedIndex(-1, 'All');
                                      });
                                    },
                                    child: tileProvider.selectedIndex
                                        == -1 ?
                                    Container(
                                      height: 4 * SizeConfig.heightMultiplier,
                                      width:20 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: secondaryColor),
                                      child: Center(
                                          child: Text(
                                            AppLocale.all.getString(context),
                                            style: text14500white,
                                          )),
                                    ):
                                    Container(
                                      height: 4 * SizeConfig.heightMultiplier,
                                      width:20 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.black45,width: 0.5)
                                      ),
                                      child: Center(
                                          child: Text(
                                            AppLocale.all.getString(context),
                                            style: text14500grey,
                                          )),
                                    )),
                                const SizedBox(width: 2.5,),
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: MySize2.size5),
                                            child: InkWell(
                                                onTap: (){
                                                  tileProvider.updateSelectedIndex(index, snapshot.data!.docs[index]['name']);
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Offers_screen()));
                                                },
                                                child:tileProvider.selectedIndex == index?
                                                Container(
                                                  height: 4 * SizeConfig.heightMultiplier,
                                                  width: index ==2 ? 30 * SizeConfig.widthMultiplier: 25 * SizeConfig.widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: secondaryColor),
                                                  child: Center(
                                                      child: Text(


                                                        localization.currentLocale!.languageCode.toString() == 'en'?
                                                        snapshot.data!.docs[index]['name']
                                                            :
                                                        snapshot.data!.docs[index]['nameAr'],
                                                        style: text14500white,
                                                      )),
                                                ):
                                                Container(
                                                  height: 4 * SizeConfig.heightMultiplier,
                                                  width: index ==2 ? 30 * SizeConfig.widthMultiplier: 25 * SizeConfig.widthMultiplier,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      border: Border.all(color: Colors.black45, width: 0.5)

                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                        localization.currentLocale!.languageCode.toString()== 'en'?

                                                        snapshot.data!.docs[index]['name']:
                                                        snapshot.data!.docs[index]['nameAr'],
                                                        style: text14500grey,
                                                      )),
                                                )
                                            ),
                                          ),



                                        ],
                                      );
                                    }
                                ),
                              ],
                            );



                          }
                          else if( snapshot.hasError){
                            return Center(child: Icon(Icons.error));
                          }
                          else if( snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          return Container();
                        }
                    ),
                  ),
                );
              },

            ),
          ),
        ),
        SizedBox(
          height: height(context)*0.25,
          width: width(context),
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.Ste,
            builder: (context, snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.docs.isNotEmpty){
                  return ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                      // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //     maxCrossAxisExtent: 200,
                      //     // childAspectRatio: 3 / 2,
                      //     crossAxisSpacing: 5,
                      //     mainAxisSpacing: 40),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length ,
                      itemBuilder: (context, index){
                        var snap = snapshot.data!.docs[index];

                        return Padding(
                          padding:  EdgeInsets.only(top: MySize2.size60,left: MySize2.size20,bottom: MySize2.size15),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  BoatDetails(boatId: snap['boatId'],
                                    // index: index,
                                  )));

                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  // height: height(context)*0.1,
                                  width: width(context)* 0.42,
                                  decoration:  BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: Offset(0, 4),
                                        color: grey2.withOpacity(0.1)
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                        top: height(context)*0.06,
                                        left: 10,right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,


                                      children: [
                                        Container(
                                            width: width(context)* 0.3,
                                            child: Text(snap['boatName'],
                                              style:  TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w500, ),
                                              overflow: TextOverflow.ellipsis,)),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,size: MySize2.size12,color: greyText,),
                                            SizedBox(width: 5,),
                                            Text(snap['area'], style: TextStyle(fontSize: MySize2.size14,fontWeight: FontWeight.w400, color: const Color(0xff262323).withOpacity(0.43)),),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Container(
                                            width: width(context)* 0.3,
                                            child: Text((snap['boatPrice']).toString() + ' SAR',
                                              style:
                                              TextStyle(fontSize: MySize2.size14,
                                                  fontWeight: FontWeight.w500,color: primaryColor),
                                              overflow: TextOverflow.ellipsis,)),

                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -40,
                                  left: 8,
                                  child: Container(
                                    width: width(context)* 0.38,
                                    height: height(context)*0.1,

                                    clipBehavior: Clip.hardEdge,
                                    decoration:BoxDecoration(
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    child:CachedNetworkImage(

                                      fit: BoxFit.cover,

                                      imageUrl: snap['image1'],
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });

                }
                else{
                  return  Column(
                    children: [
                      // Image.asset(empty),
                      Center(child: Text(AppLocale.noBoats.getString(context)))
                    ],
                  );
                }
              }
              if(snapshot.hasError){
                return const Icon(Icons.error);
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    )
    ;
  }
}
