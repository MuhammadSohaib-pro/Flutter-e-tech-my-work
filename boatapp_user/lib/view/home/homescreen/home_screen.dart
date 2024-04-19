import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/home/homescreen/components/just_for_you.dart';
import 'package:boat_app/view/home/homescreen/provider/homescreen_tile_provider.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sizes.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/maps/maps_with_markers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../languages/LocaleString.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_function.dart';
import '../../../utils/sized_box.dart';
import '../../boat_details/boat_details.dart';
import '../../notification/Notification.dart';
import 'components/boat_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<Position> getUsercurrentlocation() async{
    // print('object1');
    await Geolocator.requestPermission().then((value) {
      print(value);

    }).onError((error, stackTrace) {
      // print('error');
    });
    // print(Geolocator.getCurrentPosition());
    Position position = await Geolocator.getCurrentPosition();
    // print(position);
    return position;
  }

  String? selectedArea;

  // final List<Map> myProducts =
  // List.generate(100000, (index) => {"id": index, "name": "Product $index"})
  //     .toList();
  final FlutterLocalization localization = FlutterLocalization.instance;
  // String isSelected = 'popular';

  @override
  Widget build(BuildContext context) {
    MySize2().init(context);
    final tileProvider = Provider.of<HomeScreenTileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MySize2.size80,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        actions: [

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MySize2.size10),
            child: Column(
              children: [
                SizedBox(height: MySize2.size10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('area').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            List<String> areas = [];

                            for(int i = 0; i< snapshot.data!.docs.length; i++){
                              areas.add(snapshot.data!.docs[i]['area']);

                            }

                            // List<String> authorsList = List<String>.from(areas);
                            // print(areas);
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          color: grey2.withOpacity(0.9)
                                      )
                                    ]
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint:  Row(
                                      children: [
                                        SizedBox(
                                          width: MySize2.size4,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on_rounded, color: primaryColor,size: MySize2.size16,),
                                              SizedBox(width: MySize2.size10,),
                                              Text(
                                                AppLocale.selectCity.getString(context),
                                                style: TextStyle(
                                                    fontSize: MySize2.size12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: areas!
                                        .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style:  TextStyle(
                                          fontSize: MySize2.size14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                        .toList(),
                                    value: selectedArea,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedArea = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: MySize2.size40,
                                      width: width(context)*0.7,
                                      padding:  EdgeInsets.only(left: MySize2.size14, right: MySize2.size14),
                                      decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(5),

                                        color: Color(0xfff3f4f9),
                                      ),
                                      elevation: 0,
                                    ),
                                    iconStyleData:  IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                      ),
                                      iconSize: height(context)*0.03,
                                      iconEnabledColor: Colors.black,
                                      iconDisabledColor: Colors.black,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: MySize2.size200,
                                      width: MySize2.size200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                      ),
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(6),
                                        thumbVisibility: MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          else if(snapshot.hasError){
                            return Text('error');
                          }else if(snapshot.connectionState == ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }
                          return Container();
                        }
                    ),
                    SizedBox(width: MySize2.size20,),
                    InkWell(
                      onTap: (){
                        // getUsercurrentlocation().then((value) async {
                        //   var latt = value.latitude;
                        //   var langg = value.longitude;
                        //   print(latt);
                        //   print(langg);
                        //
                        // });
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                const MapsWithMarkers(
                                )));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomMarkerInfoWindow()));
                      },
                      child: SvgPicture.asset(map,height: MySize2.size24,color: Colors.black,),
                    ),
                    SizedBox(width: MySize2.size20,),

                    InkWell(
                        onTap: ()async{

                          // getUsercurrentlocation().then((value) async{
                          //   var latt = value.latitude;
                          //   var langg = value.longitude;
                          //   print(latt);
                          //   print(langg);
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=> MapsGoogle(lat: latt,   long: langg,)));
                          // });
                          if(FirebaseAuth.instance.currentUser == null){
                            showDialogGuest(context);
                          }else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const NotificationScreen()));
                          }
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomMarkerInfoWindow()));

                        },
                        child: FutureBuilder(
                          future: checkNotification(),
                          builder: (context, AsyncSnapshot<bool> snap){
                            bool?  isUnread = snap.data ?? false;
                            print(isUnread);
                            return isUnread ?
                            SvgPicture.asset(bellOn,height: MySize2.size24,):
                            SvgPicture.asset(bell,height: MySize2.size24,);
                          },
                        )),

                  ],
                ),
                SizedBox(
                  height: height(context)*0.02,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  selectedArea == null ?
                  Column(
                    children: [
                      Consumer<HomeScreenTileProvider>(
                        builder: (context, value, child){
                          return Column(
                            children: [
                              BoatCardWidget(name: tileProvider.getName!,
                                Ste:tileProvider.getName == 'All'?   FirebaseFirestore.instance
                                    .collection('BoatData').where('boatStatusApproved', isEqualTo: true)
                                    .snapshots():
                                FirebaseFirestore.instance
                                    .collection('BoatData').
                                where('boatType', isEqualTo: tileProvider.getName!).where('boatStatusApproved', isEqualTo: true)
                                    .snapshots(),

                                streamFeatured: tileProvider.getName == 'All'?   FirebaseFirestore.instance
                                    .collection('BoatData').where('feature', isEqualTo: true).where('boatStatusApproved', isEqualTo: true)
                                    .snapshots():
                                FirebaseFirestore.instance
                                    .collection('BoatData').
                                where('boatType', isEqualTo: tileProvider.getName!).where('feature', isEqualTo: true).where('boatStatusApproved', isEqualTo: true)
                                    .snapshots(),)
                            ],
                          );
                        },
                      ),
                      const JustForYou(),
                      SizedBox(height: 30,)
                    ],
                  )
                      :
                  Column(
                    children: [
                      // Center(
                      //   child: Consumer<HomeScreenTileProvider>(
                      //     builder: (context, value, child){
                      //       return SingleChildScrollView(
                      //         scrollDirection: Axis.horizontal,
                      //         child: Container(
                      //           height: SizeConfig.heightMultiplier * 4,
                      //           child: StreamBuilder<QuerySnapshot>(
                      //               stream: FirebaseFirestore.instance.collection('typesOfBoats').where('status', isEqualTo: 'available').snapshots(),
                      //               builder: (context, snapshot) {
                      //                 if(snapshot.hasData){
                      //                   return Row(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //
                      //                     children: [
                      //                       InkWell(
                      //                           onTap: (){
                      //                             setState(() {
                      //                               tileProvider.updateSelectedIndex(-1, 'All');
                      //                             });
                      //                           },
                      //                           child: tileProvider.selectedIndex
                      //                               == -1 ?
                      //                           Container(
                      //                             height: 3 * SizeConfig.heightMultiplier,
                      //                             width:20 * SizeConfig.widthMultiplier,
                      //                             decoration: BoxDecoration(
                      //                                 borderRadius: BorderRadius.circular(10),
                      //                                 color: Colors.black),
                      //                             child: Center(
                      //                                 child: Text(
                      //                                   AppLocale.all.getString(context),
                      //                                   style: text14500white,
                      //                                 )),
                      //                           ):
                      //                           Container(
                      //                             height: 3 * SizeConfig.heightMultiplier,
                      //                             width:20 * SizeConfig.widthMultiplier,
                      //                             decoration: BoxDecoration(
                      //                               borderRadius: BorderRadius.circular(10),
                      //                               border: Border.all(width: 0.5, color: Colors.black)
                      //                             ),
                      //                             child: Center(
                      //                                 child: Text(
                      //                                   AppLocale.all.getString(context),
                      //                                   style: text14500,
                      //                                 )),
                      //                           )),
                      //                       ListView.builder(
                      //                           scrollDirection: Axis.horizontal,
                      //                           shrinkWrap: true,
                      //                           itemCount:snapshot.data!.docs.length,
                      //                           itemBuilder: (context, index) {
                      //                             return Row(
                      //                               mainAxisAlignment: MainAxisAlignment.center,
                      //                               children: [
                      //                                 Padding(
                      //                                   padding:  EdgeInsets.symmetric(horizontal: 8.0),
                      //                                   child: InkWell(
                      //                                     onTap: (){
                      //                                       tileProvider.updateSelectedIndex(index, snapshot.data!.docs[index]['name']);
                      //                                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> Offers_screen()));
                      //                                     },
                      //                                     child:tileProvider.selectedIndex == index? Container(
                      //                                       // height: 3 * SizeConfig.heightMultiplier,
                      //                                       width:25 * SizeConfig.widthMultiplier,
                      //                                       decoration: BoxDecoration(
                      //                                           borderRadius: BorderRadius.circular(10),
                      //                                           color: Colors.black),
                      //                                       child: Center(
                      //                                           child: Text(
                      //                                             localization.currentLocale.toString() == 'en'?
                      //
                      //                                             snapshot.data!.docs[index]['name']:
                      //                                             snapshot.data!.docs[index]['nameAr'],                                                                style: text14500white,
                      //                                           )),
                      //                                     ):
                      //                                     Container(
                      //                                       height: 3 * SizeConfig.heightMultiplier,
                      //                                       width:25 * SizeConfig.widthMultiplier,
                      //                                       decoration: BoxDecoration(
                      //                                           borderRadius: BorderRadius.circular(10),
                      //                                           border: Border.all(color: Colors.black, width: 0.5)
                      //
                      //                                       ),
                      //                                       child: Center(
                      //                                           child: Text(
                      //                                             localization.currentLocale.toString() == 'en'?
                      //
                      //                                             snapshot.data!.docs[index]['name']:
                      //                                             snapshot.data!.docs[index]['nameAr'],
                      //                                             style: text14500,
                      //                                           )),
                      //                                     )
                      //                                   ),
                      //                                 ),
                      //
                      //
                      //
                      //                               ],
                      //                             );
                      //                           }
                      //                       ),
                      //                     ],
                      //                   );
                      //
                      //
                      //
                      //                 }
                      //                 else if( snapshot.hasError){
                      //                   return Center(child: Icon(Icons.error));
                      //                 }
                      //                 else if( snapshot.connectionState == ConnectionState.waiting){
                      //                   return Center(child: CircularProgressIndicator());
                      //                 }
                      //                 return Container();
                      //               }
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //
                      //   ),
                      // ),


                      // SizedBox(
                      //   height: height(context)*0.02,
                      // ),

                      Consumer<HomeScreenTileProvider>(
                        builder: (context, value, child){
                          return Column(
                            children: [
                              BoatCardWidget(name:
                              tileProvider.getName!,

                                streamFeatured:
                                tileProvider.getName == 'All'?   FirebaseFirestore.instance
                                    .collection('BoatData').where('feature', isEqualTo: true).where('boatStatusApproved', isEqualTo: true).where('area', isEqualTo: selectedArea)
                                    .snapshots():
                                FirebaseFirestore.instance
                                    .collection('BoatData')
                                    .where('area', isEqualTo: selectedArea)
                                    .where('feature', isEqualTo: true)
                                    .where('boatStatusApproved', isEqualTo: true)
                                    .where('boatType', isEqualTo: tileProvider.getName!)
                                    .snapshots(),
                                Ste:


                                tileProvider.getName == 'All'?   FirebaseFirestore.instance
                                    .collection('BoatData').where('area', isEqualTo: selectedArea)
                                    .where('boatStatusApproved', isEqualTo: true)
                                    .snapshots()
                                    :
                                FirebaseFirestore.instance
                                    .collection('BoatData')
                              .where('area', isEqualTo: selectedArea).
                                where('boatType', isEqualTo: tileProvider.getName!)
                                    .where('boatStatusApproved', isEqualTo: true)
                                    .snapshots()


                              )
                            ],
                          );
                        },
                      ),

                     const JustForYou(),
                      SizedBox(height: 30,)

                    ],
                  )



                ],
              ),
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
            //   child: Column(
            //     children: [
            //       SizedBox(height: MySize2.size20,),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //
            //           StreamBuilder<QuerySnapshot>(
            //               stream: FirebaseFirestore.instance.collection('area').snapshots(),
            //               builder: (context, snapshot) {
            //                 if(snapshot.hasData){
            //                   List<String> areas = [];
            //
            //                   for(int i = 0; i< snapshot.data!.docs.length; i++){
            //                     areas.add(snapshot.data!.docs[i]['area']);
            //
            //                   }
            //
            //                   // List<String> authorsList = List<String>.from(areas);
            //                   // print(areas);
            //                   return Center(
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(5),
            //                           boxShadow: [
            //                             BoxShadow(
            //                                 blurRadius: 2,
            //                                 spreadRadius: 0,
            //                                 color: grey2.withOpacity(0.9)
            //                             )
            //                           ]
            //                       ),
            //                       child: DropdownButtonHideUnderline(
            //                         child: DropdownButton2<String>(
            //                           isExpanded: true,
            //                           hint:  Row(
            //                             children: [
            //                               SizedBox(
            //                                 width: MySize2.size4,
            //                               ),
            //                               Expanded(
            //                                 child: Row(
            //                                   children: [
            //                                     Icon(Icons.location_on_rounded, color: primaryColor,size: MySize2.size16,),
            //                                     SizedBox(width: MySize2.size10,),
            //                                     Text(
            //                                       AppLocale.selectCity.getString(context),
            //                                       style: TextStyle(
            //                                           fontSize: MySize2.size12,
            //                                           fontWeight: FontWeight.w400,
            //                                           color: Colors.black
            //                                       ),
            //                                       overflow: TextOverflow.ellipsis,
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           items: areas!
            //                               .map((String item) => DropdownMenuItem<String>(
            //                             value: item,
            //                             child: Text(
            //                               item,
            //                               style:  TextStyle(
            //                                 fontSize: MySize2.size14,
            //                                 color: Colors.black,
            //                               ),
            //                               overflow: TextOverflow.ellipsis,
            //                             ),
            //                           ))
            //                               .toList(),
            //                           value: selectedArea,
            //                           onChanged: (value) {
            //                             setState(() {
            //                               selectedArea = value;
            //                             });
            //                           },
            //                           buttonStyleData: ButtonStyleData(
            //                             height: MySize2.size40,
            //                             width: width(context)*0.7,
            //                             padding:  EdgeInsets.only(left: MySize2.size14, right: MySize2.size14),
            //                             decoration: BoxDecoration(
            //
            //                               borderRadius: BorderRadius.circular(5),
            //
            //                               color: Color(0xfff3f4f9),
            //                             ),
            //                             elevation: 0,
            //                           ),
            //                           iconStyleData:  IconStyleData(
            //                             icon: Icon(
            //                               Icons.keyboard_arrow_down_sharp,
            //                             ),
            //                             iconSize: height(context)*0.03,
            //                             iconEnabledColor: Colors.black,
            //                             iconDisabledColor: Colors.black,
            //                           ),
            //                           dropdownStyleData: DropdownStyleData(
            //                             maxHeight: MySize2.size200,
            //                             width: MySize2.size200,
            //                             decoration: BoxDecoration(
            //                               borderRadius: BorderRadius.circular(14),
            //                               color: Colors.white,
            //                             ),
            //                             offset: const Offset(-20, 0),
            //                             scrollbarTheme: ScrollbarThemeData(
            //                               radius: const Radius.circular(40),
            //                               thickness: MaterialStateProperty.all(6),
            //                               thumbVisibility: MaterialStateProperty.all(true),
            //                             ),
            //                           ),
            //                           menuItemStyleData: const MenuItemStyleData(
            //                             height: 40,
            //                             padding: EdgeInsets.only(left: 14, right: 14),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }
            //                 else if(snapshot.hasError){
            //                   return Text('error');
            //                 }else if(snapshot.connectionState == ConnectionState.waiting){
            //                   return CircularProgressIndicator();
            //                 }
            //                 return Container();
            //               }
            //           ),
            //           InkWell(
            //             onTap: (){
            //               // getUsercurrentlocation().then((value) async {
            //               //   var latt = value.latitude;
            //               //   var langg = value.longitude;
            //               //   print(latt);
            //               //   print(langg);
            //               //
            //               // });
            //               Navigator.push(context, MaterialPageRoute(
            //                   builder: (context) =>
            //                       MapsWithMarkers(
            //                       )));
            //               // Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomMarkerInfoWindow()));
            //             },
            //             child: SvgPicture.asset(map,height: MySize2.size24,color: Colors.black,),
            //           ),
            //           InkWell(
            //               onTap: ()async{
            //
            //                 // getUsercurrentlocation().then((value) async{
            //                 //   var latt = value.latitude;
            //                 //   var langg = value.longitude;
            //                 //   print(latt);
            //                 //   print(langg);
            //                 //   Navigator.push(context, MaterialPageRoute(builder: (context)=> MapsGoogle(lat: latt,   long: langg,)));
            //                 // });
            //                 if(FirebaseAuth.instance.currentUser == null){
            //                   showDialogGuest(context);
            //                 }else {
            //                   Navigator.push(context, MaterialPageRoute(
            //                       builder: (context) => const NotificationScreen()));
            //                 }
            //                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomMarkerInfoWindow()));
            //
            //               },
            //               child: FutureBuilder(
            //                 future: checkNotification(),
            //                 builder: (context, AsyncSnapshot<bool> snap){
            //                   bool?  isUnread = snap.data ?? false;
            //                   return isUnread ?
            //                   SvgPicture.asset(bellOn,height: MySize2.size24,):
            //                   SvgPicture.asset(bell,height: MySize2.size24,);
            //                 },
            //               )),
            //
            //         ],
            //       ),
            //       SizedBox(
            //         height: height(context)*0.02,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
