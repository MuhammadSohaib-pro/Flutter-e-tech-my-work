import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/home/Search/searchScreen.dart';
import 'package:boat_app/view/home/search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../languages/LocaleString.dart';
import '../../utils/constants.dart';
import '../../utils/sized_box.dart';
import '../../utils/sizes.dart';
import '../boat_details/boat_details.dart';
import '../bottomBar/bottom_bar.dart';
import 'Search/filter.dart';
import '../notification/Notification.dart';



class FullHomeScreen extends StatefulWidget {
  final String boatType;
  const FullHomeScreen({Key? key, required this.boatType}) : super(key: key);

  @override
  State<FullHomeScreen> createState() => _FullHomeScreenState();
}

class _FullHomeScreenState extends State<FullHomeScreen> {
  final List<Map> myProducts =
  List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: height(context)*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomBarScreen()));

                  },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  InkWell(
                  onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
            },
                    child: Container(
                      width:width(context)*0.75,
                      height:MySize2.size50,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF6F6F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: MySize2.size20),
                      child:
                         Row(
                           children: [
                             Icon(Icons.search, size: MySize2.size16,color: greyText,),
                              SizedBox(width: 5,),
                              Text(
                                'Search....',
                                style: TextStyle(
                                  color: Color(0xFF9F9F9F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,

                                ),
                              ),
                           ],
                         ),
                          // Text(
                          //   'Cancel',
                          //   textAlign: TextAlign.right,
                          //   style: TextStyle(
                          //     color: Color(0xFF0095FF),
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w400,
                          //
                          //   ),
                          // )

                    ),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
                  //   },
                  //   // child: Container(
                  //   //   height:MySize2.size42,
                  //   //   width:width(context)*0.85,
                  //   //   child: TextFormField(
                  //   //     enabled: false,
                  //   //     decoration: InputDecoration(
                  //   //       hintText: AppLocale.searchboatinyourarea.getString(context),
                  //   //       hintStyle: text12400,
                  //   //       fillColor: const Color(0xffF3F4F9),
                  //   //       filled: true,
                  //   //       prefixIcon: const Icon(Icons.search),
                  //   //       disabledBorder: OutlineInputBorder(
                  //   //           borderSide: const BorderSide(
                  //   //             color: Color(0xffF3F4F9),
                  //   //           ),
                  //   //           borderRadius: BorderRadius.circular(16)),
                  //   //       focusedBorder: OutlineInputBorder(
                  //   //           borderSide: const BorderSide(
                  //   //             color: Color(0xffF3F4F9),
                  //   //           ),
                  //   //           borderRadius: BorderRadius.circular(16)),
                  //   //     ),
                  //   //   ),
                  //   // ),
                  // ),
                  ///
                  // InkWell(
                  //     onTap: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen()));
                  //     },
                  //     child: FutureBuilder(
                  //       future: checkNotification(),
                  //       builder: (context, AsyncSnapshot<bool> snap){
                  //         bool?  isUnread = snap.data ?? false;
                  //         return isUnread ?
                  //         SizedBox(
                  //             height:6 * SizeConfig.imageSizeMultiplier,
                  //             width: 6* SizeConfig.imageSizeMultiplier,
                  //             child: SvgPicture.asset(bellOn)):
                  //         SizedBox(
                  //             height:6 * SizeConfig.imageSizeMultiplier,
                  //             width: 6* SizeConfig.imageSizeMultiplier,
                  //             child: SvgPicture.asset(bell));
                  //       },
                  //     )),
                ],
              ),







              Padding(
                padding:  EdgeInsets.only(top:MySize2.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocale.explore.getString(context)
                      , style: text18600,),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: 
                  widget.boatType == 'All'?
                  FirebaseFirestore.instance.collection('BoatData')
                      .where('boatStatusApproved', isEqualTo: true).snapshots()
                  :
                  FirebaseFirestore.instance.collection('BoatData')
                      .where('boatStatusApproved', isEqualTo: true).where('boatType', isEqualTo: widget.boatType).snapshots()
                  ,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data!.docs.isNotEmpty){
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical:height(context)*0.01),
                          child: GridView.builder(

                            physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1.7/ 2,
                                  // crossAxisSpacing: 5,
                                  // mainAxisSpacing: 40
                              ),
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index){
                                var snap = snapshot.data!.docs[index];

                                return Padding(
                                  padding:  EdgeInsets.only(top: height(context)*0.035, bottom: MySize2.size10),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                          BoatDetails(
                                            // index: index,
                                            boatId: snap['boatId'],)));

                                    },
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: height(context)*0.2,
                                          width: width(context)* 0.42,
                                          decoration:  BoxDecoration(
                                              color: const Color(0xffedebeb),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.only(top: height(context)*0.08, left: 10,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: MySize2.size120,
                                                    child: Text(snap['boatName'],maxLines: 1, overflow: TextOverflow.ellipsis, style: text16500,)),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,size: 12,color: Color(0xff262323).withOpacity(0.43),),
                                                    Text(snap['area'], style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400, color: const Color(0xff262323).withOpacity(0.43)),),
                                                  ],
                                                ),

                                            Container(
                                              width: MySize2.size120,
                                              child:
                                              Text('\$ ' +(snap['boatPrice']).toString(),maxLines: 1, overflow: TextOverflow.ellipsis, style: text14500,)
                                            ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -20,
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
                              }),
                        );

                      }
                      else{
                        return const Column(
                          children: [
                            // Image.asset(empty),
                            Text('No Boats Available')
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
          ),
        ),
      ),
    );
  }
}
