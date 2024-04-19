import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../../languages/LocaleString.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/sized_box.dart';
import '../../../../utils/sizes_class.dart';
import '../../../../utils/textstyles.dart';
import '../../../boat_details/boat_details.dart';

class JustForYou extends StatefulWidget {
  const JustForYou({super.key});

  @override
  State<JustForYou> createState() => _JustForYouState();
}

class _JustForYouState extends State<JustForYou> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Padding(
          padding:   EdgeInsets.only(top:MySize2.size10,left: MySize2.size20,right: MySize2.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( AppLocale.justForYou.getString(context),
                style: TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w600,),),
            ],
          ),
        ),

        Container(
          height: height(context)*0.25,
          width: width(context),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('BoatData').snapshots(),
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
                                        left: MySize2.size10,right: MySize2.size10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Container(
                                            width: width(context)* 0.3,
                                            child: Text(snap['boatName'], style: TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w500, ),overflow: TextOverflow.ellipsis,)),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,size: 12,color: greyText,),
                                            SizedBox(width: 5,),
                                            Text(snap['area'], style: TextStyle(fontSize: MySize2.size14,fontWeight: FontWeight.w400, color: const Color(0xff262323).withOpacity(0.43)),),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Container(
                                            width: width(context)* 0.3,
                                            child: Text((snap['boatPrice']).toString()+ ' SAR',
                                              style:
                                              TextStyle(fontSize: MySize2.size14,
                                                  fontWeight: FontWeight.w500,color: primaryColor),
                                              overflow: TextOverflow.ellipsis,)),                                      ],
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
    );
  }
}
