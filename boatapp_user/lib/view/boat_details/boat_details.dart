
import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/provider/carousel_provider.dart';
import 'package:boat_app/provider/loading_provider/time_slot_provider.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../custom_widgets/back_arrow.dart';
import '../../provider/fav_provider.dart';
import '../../provider/loading_provider/loading.dart';
import '../../provider/loading_provider/loading_provider.dart';
import '../../utils/global_function.dart';
import '../../utils/textstyles.dart';
import '../../utils/utils.dart';
import '../auth/OTP verification/OTP_verification.dart';
import 'boat_bookings.dart';

class BoatDetails extends StatefulWidget {
  final String boatId;
  // final int index;
  const BoatDetails({Key? key, required this.boatId,
    // required this.index
  }) : super(key: key);

  @override
  State<BoatDetails> createState() => _BoatDetailsState();
}

class _BoatDetailsState extends State<BoatDetails> {


  int currentIndex = 0;
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  bool selected = false;
@override
  void initState() {
Future.delayed(const Duration(seconds: 1), );
setState(() {

});
  // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // mapController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final timeSlot =  Provider.of<TimeSlotProvider>(context, listen: false);
    CarouselProvider carouselProvider =     Provider.of<CarouselProvider>(context, listen: false);
    final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);

    final loadingProvider2 = Provider.of<LoadingProvider2>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },

      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.collection('BoatData').doc(widget.boatId).snapshots(),
          builder: (context, snapshot) {
        
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              // if (kDebugMode) {
              //   print(snapshot.data!['long']);
              // }
              // if (kDebugMode) {
              //   print('--------------------------');
              // }
        
              // String name = snapshot.data!.docs[widget.index]['boatName'];
              // String imageUrl = snapshot.data!.docs[widget.index]['image1'];
              // String price = snapshot.data!.docs[widget.index]['boatPrice'];
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('BoatData').doc(snapshot.data!['boatId']).collection('images').snapshots(),
                                builder: (context, snaps){
                                  if(snaps.hasData){
                                    return
                                      Stack(alignment: Alignment.bottomCenter,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.of(context).size.height / 2.3,
                                            child: ClipRRect(
                                              child: ShaderMask(
                                                shaderCallback: (rect) {
                                                  return const LinearGradient(
                                                    begin: Alignment.centerRight,
                                                    end: Alignment.bottomCenter,
                                                    colors: [Colors.black, Colors.transparent],
                                                  ).createShader(
                                                      Rect.fromLTRB(0, 0, 0, rect.height));
                                                },
                                                blendMode: BlendMode.dstIn,
                                                child:
                                                Consumer<CarouselProvider>(builder: (context, value, child){
                                                  if (kDebugMode) {
                                                    print(snaps.data!.docs.length);
                                                  }
                                                  return snaps.data!.docs.length == 1 ?
                                                  Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    height: height(context),
                                                    width: width(context),//height(context) * 0.4,
                                                    // margin: const EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child:CachedNetworkImage(
                                                      width: width(context),
                                                      height: height(context),
                                                      fit: BoxFit.fill,
                                                      imageUrl:  snaps.data!.docs[0]
                                                      ['URL'],
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    ),
                                                  )
                                                      :
                                                  CarouselSlider(
                                                      items: [
                                                        for (int i = 0;
                                                        i < snaps.data!.docs.length;
                                                        i++)
                                                          Container(
                                                            clipBehavior: Clip.hardEdge,
                                                            height: height(context) ,
                                                            width: height(context) ,
                                                            // margin: const EdgeInsets.all(6.0),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                            ),
                                                            child:CachedNetworkImage(
                                                              width: width(context),
                                                              height: height(context),
                                                              fit: BoxFit.cover,
                                                              imageUrl:  snaps.data!.docs[i]
                                                              ['URL'],
                                                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                                            ),
                                                          ),
                                                        // Container(
                                                        //   clipBehavior: Clip.hardEdge,
                                                        //   height: height(context) * 0.3,
                                                        //   width: height(context) * 0.3,
                                                        //   margin: EdgeInsets.all(6.0),
                                                        //   decoration: BoxDecoration(
                                                        //     borderRadius: BorderRadius.circular(8.0),
                                                        //   ),
                                                        //   child: Image(
                                                        //     height: height(context) * 0.3,
                                                        //     width: height(context) * 0.3,
                                                        //     fit: BoxFit.fill,
                                                        //     image: NetworkImage(
                                                        //       snaps.data!.docs[1]
                                                        //       ['URL'],
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        // Container(
                                                        //   clipBehavior: Clip.hardEdge,
                                                        //   height: height(context) * 0.3,
                                                        //   width: height(context) * 0.3,
                                                        //   margin: EdgeInsets.all(6.0),
                                                        //   decoration: BoxDecoration(
                                                        //     borderRadius: BorderRadius.circular(8.0),
                                                        //   ),
                                                        //   child: Image(
                                                        //     height: height(context) * 0.3,
                                                        //     width: height(context) * 0.3,
                                                        //     fit: BoxFit.fill,
                                                        //     image: NetworkImage(
                                                        //       snaps.data!.docs[3]
                                                        //       ['URL'],
                                                        //     ),
                                                        //   ),
                                                        // ),

                                                      ],
                                                      options: CarouselOptions(
                                                        onPageChanged: (index, value){
                                                          carouselProvider.setCurrentIndex(index) ;
                                                        },
                                                        height: height(context),
                                                        aspectRatio: 16 / 9,
                                                        viewportFraction: 1,
                                                        initialPage: 0,
                                                        enableInfiniteScroll: true,
                                                        reverse: false,
                                                        autoPlay: true,
                                                        autoPlayInterval: const Duration(seconds: 3),
                                                        autoPlayAnimationDuration:
                                                        const Duration(milliseconds: 800),
                                                        autoPlayCurve: Curves.fastOutSlowIn,
                                                        enlargeCenterPage: true,
                                                        enlargeFactor: 0.3,
                                                        scrollDirection: Axis.horizontal,
                                                      ));
                                                })
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 50.0),
                                            child: Consumer<CarouselProvider>(builder: (context, value, child){
                                              return snaps.data!.docs.length == 1 ?
                                              Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Container(
                                                  height: height(context)*0.01,
                                                  width: height(context)*0.01,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Colors.green,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color:
                                                        Colors.green),
                                                  ),
                                                ),
                                              ):

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  for (int i = 0;
                                                  i < snaps.data!.docs.length;
                                                  i++)
                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                        height: height(context)*0.01,
                                                        width: height(context)*0.01,
                                                        decoration: BoxDecoration(
                                                          color: carouselProvider.currentIndex == i
                                                              ? Colors.green
                                                              : Colors.grey,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              color: carouselProvider.currentIndex == i
                                                                  ? Colors.grey
                                                                  : Colors.grey),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          )

                                        ],
                                      );
                                  }
                                  else if(snaps.hasError){
                                    return const Icon(Icons.error);
                                  }
                                  else if(snaps.connectionState == ConnectionState.waiting){
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  return Container();
                                }),
                            Positioned(
                              bottom: -40,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: SizedBox(
                                  width: width(context)*0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width(context)*0.35,
                                            child: Text(
                                              snapshot.data!
                                                  ['boatName'],
                                              style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),
                                              overflow: TextOverflow.ellipsis,
                    
                                            ),
                                          ),
                                          // Text(
                                          //   'Sea View, Premium Lifestyle',
                                          //   style: text14500,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_on,size: 12,color: greyText,),
                                                Text(
                                                    snapshot.data!['area'], style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 10,color: greyText),
                                                ),


                                              ],
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.star, color: primaryColor,size: 20,),
                                              SizedBox(width: width(context)*0.01,),
                                              FutureBuilder(
                                                future: getReviewAvg(snapshot.data!['boatId']),
                                                builder: (context, snapRating){
                    
                                                  if(snapRating.hasError){
                                                    return const Icon(Icons.error);
                                                  }
                                                  if(snapRating.connectionState == ConnectionState.waiting){
                                                    return const Center(child: CircularProgressIndicator());
                                                  }
                                                  if(snapRating.hasData){
                                                    // print(snapRating.data!.toString());
                                                    if(snapRating.data! == 0){
                                                      return const Text('N/A',
                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black));
                                                    }
                                                    else if(snapRating.data! != 0){
                                                      return Text(snapRating.data!.toString(), style: text16500,);
                                                    }
                                                    else{
                                                      const Text('N/A');
                                                    }
                                                  }
                                                  return Container();
                    
                                                },
                    
                                              ),
                                              // Text('N/A', style: text16500white,)
                                            ],
                                          ),
                    
                    
                    
                    
                                        ],
                                      ),
                                      // SizedBox(
                                      //   width: width(context) * 0.1,
                                      // ),
                                      Container(
                                        height: MySize2.size30,
                                        width: MySize2.size120,
                                        padding
                                            : const EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: secondaryColor),

                                        child: Center(
                                            child:Text(  snapshot.data!['boatPrice']+ ' SAR',overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(

                                AppLocale.about.getString(context),
                                style: text15500,
                              ),
                              SizedBox(
                                height: height(context) * 0.01,
                              ),
                              Text(
                                snapshot.data!['aboutBoat'],
                                style: const TextStyle(color: greyText,fontSize: 12,fontWeight: FontWeight.w400),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),

                              Text(
                                AppLocale.facilities.getString(context),
                                style: text14500,
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    snapshot.data!['facility1'] == ''
                                        ? Container()
                                        : Column(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: OvalBorder(),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x14000000),
                                                    blurRadius: 10,
                                                    offset: Offset(2, 2),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(life_vest,
                                                  color: primaryColor,
                                                  // height: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10,),
                                            Text(
                                              snapshot.data!
                                              ['facility1'],
                                              style: text14500,
                                            )
                                          ],
                                        ),
                                    snapshot.data!['facility1'] == ''?
                                        Container():
                                    SizedBox(
                                      width: width(context) * 0.04,
                                    ),
                                    snapshot.data!['facility2'] == ''
                                        ? Container()
                                        : Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x14000000),
                                                blurRadius: 10,
                                                offset: Offset(2, 2),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(dvd,
                                              color: primaryColor,
                                              // height: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          snapshot.data!
                                          ['facility2'],
                                          style: text14500,
                                        )
                                      ],
                                    ),
                                    snapshot.data!['facility2'] == ''?
                                    Container():
                                    SizedBox(
                                      width: width(context) * 0.04,
                                    ),

                                    snapshot.data!['facility3'] == ''
                                        ? Container()
                                        : Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x14000000),
                                                blurRadius: 10,
                                                offset: Offset(2, 2),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(wifi,
                                              color: primaryColor,
                                              // height: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          snapshot.data!
                                          ['facility3'],
                                          style: text14500,
                                        )
                                      ],
                                    ),

                                    snapshot.data!['facility3'] == ''?
                                    Container():
                                    SizedBox(
                                      width: width(context) * 0.04,
                                    ),


                                    snapshot.data!['facility4'] == ''
                                        ? Container()
                                        : Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x14000000),
                                                blurRadius: 10,
                                                offset: Offset(2, 2),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(ac,
                                              color: primaryColor,
                                              // height: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          snapshot.data!
                                          ['facility4'],
                                          style: text14500,
                                        )
                                      ],
                                    ),


                                    snapshot.data!['facility4'] == ''?
                                    Container():
                                    SizedBox(
                                      width: width(context) * 0.04,
                                    ),
                                    snapshot.data!['facility5'] == ''
                                        ? Container()
                                        : Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(),
                                            shadows: [
                                              BoxShadow(
                                                color: Color(0x14000000),
                                                blurRadius: 10,
                                                offset: Offset(2, 2),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(toilet,
                                              color: primaryColor,
                                              // height: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        Text(
                                          snapshot.data!
                                          ['facility5'],
                                          style: text14500,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: height(context) * 0.02,
                              // ),
                              // Text(
                              //   AppLocale.overView.getString(context),
                              //   style: text18600,
                              // ),
                              // SizedBox(
                              //   height: height(context) * 0.01,
                              // ),
                              // StreamBuilder<QuerySnapshot>(
                              //   stream: FirebaseFirestore.instance
                              //       .collection('BoatData')
                              //       .doc(
                              //           snapshot.data!['boatId'])
                              //       .collection('OverView')
                              //       .snapshots(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.hasError) {
                              //       return const Text('error');
                              //     }
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return const CircularProgressIndicator(
                              //         color: primaryColor,
                              //       );
                              //     }
                              //     if (snapshot.hasData) {
                              //
                              //       return Row(
                              //         children: [
                              //           Container(
                              //             clipBehavior: Clip.hardEdge,
                              //             width: width(context) * 0.2,
                              //             height: height(context) * 0.1,
                              //             decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(16)),
                              //             child: CachedNetworkImage(
                              //               // width: width(context),
                              //               // height: height(context),
                              //               fit: BoxFit.cover,
                              //               imageUrl: snapshot.data!.docs[0]
                              //                   ['image'],
                              //               placeholder: (context, url) =>
                              //                   const Center(
                              //                       child:
                              //                           CircularProgressIndicator()),
                              //               errorWidget: (context, url, error) =>
                              //                   const Icon(Icons.error),
                              //             ),
                              //           ),
                              //            SizedBox(
                              //             width: width(context)*0.02,
                              //           ),
                              //           Flexible(
                              //             child: ReadMoreText(
                              //               snapshot.data!.docs[0]['boatOverview'],
                              //               trimLength: 150,
                              //               moreStyle: const TextStyle(color: Colors.green),
                              //               lessStyle: const TextStyle(color: Colors.red),
                              //             ),
                              //           )
                              //         ],
                              //       );
                              //     }
                              //     return const Text('no data');
                              //   },
                              // ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              Text(
                                AppLocale.location.getString(context),
                                style: text14500,
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                              Container(
                                height: MySize2.size200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(snapshot.data!['Latitude'], snapshot.data!['Longitude']),
                                          zoom: 8,

                                        ),
                                        zoomControlsEnabled: false,
                                        onMapCreated: (controller) {
                                          mapController = controller;
                                        },
                                        myLocationButtonEnabled: false,
                                        markers: {
                                          Marker(
                                            markerId: const MarkerId('marker_1'),
                                            position: LatLng(snapshot.data!['Latitude'], snapshot.data!['Longitude']),
                                          ),
                                        },
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: InkWell(
                                          onTap: () async {
                                            // var latlong = await getCoordinates(snapshot3.data!.docs[index]['boatId']);
                                            final double latitude = snapshot.data!['Latitude']; // Replace with your latitude
                                            final double longitude = snapshot.data!['Longitude']; // Replace with your longitude

                                            String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                            print(googleMapsUrl);
                                            var a = Uri.parse(googleMapsUrl);
                                            print(a);
                                            await launchUrl(a, mode: LaunchMode.externalApplication);

                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            height: MySize2.size50,
                                            width: width(context),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset('assets/icons/mapNavigation.svg'),
                                                  const SizedBox(width: 5,),
                                                   Text(AppLocale.viewLocation.getString(context), style: TextStyle(color: primaryColor)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                    
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MySize2.size90,
                    width: width(context),
                    color: Colors.white,
                    child:
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: MySize2.size20),
                      child: Row(
                          children:[
                            FirebaseAuth.instance.currentUser == null ? Container():
                            InkWell(
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
                                builder: (context, value, child){
                                  return  FutureBuilder<bool>(
                                    future: bookmarkProvider.isContainerBookmarked(snapshot.data! ['boatId']),
                                    builder: (context, AsyncSnapshot<bool> snapshotB){
                                      bool isBookmarked = snapshotB.data ?? false;
                                      return isBookmarked ?
                                      Container(
                                        height: MySize2.size44,
                                        width: MySize2.size44,
                                        decoration:  BoxDecoration(
                                            // color: Color(0xfff0f0f0),
                                            border: Border.all(
                                              color:const Color(0xffF0F0F0),
                                            ),
                                            shape: BoxShape.circle),
                                        child:   Icon(
                                          Icons.favorite,
                                          color:   primaryColor,
                                          size: MySize2.size24,
                                        ),
                                      )
                                          :
                                      Container(
                                        height: MySize2.size44,
                                        width: MySize2.size44,
                                        decoration:  BoxDecoration(
                                            // color: Color(0xfff0f0f0),
                                            border: Border.all(
                                                color: const Color(0xffF0F0F0),
                                            ),
                                            shape: BoxShape.circle),
                                        child:   Icon(
                                          Icons.favorite_border,
                                          color:  const Color(0xffF0F0F0),
                                          size: MySize2.size24,
                                        ),
                                      );
                                    },

                                  );
                                },

                              ),
                            ),

                           SizedBox(
                             width:  FirebaseAuth.instance.currentUser == null ?width(context)*0.85:width(context)*0.75,

                             child:  FirebaseAuth.instance.currentUser == null ?
                             Padding(
                               padding:   EdgeInsets.symmetric(vertical: 0.0,horizontal: MySize2.size30),
                               child: AppButton(
                                   height: MySize2.size48,
                                   onPressed: () {
                                     showDialogGuest(context);
                                     // timeSlot.clearSlot();
                                     // Navigator.push(
                                     //     context,
                                     //     MaterialPageRoute(
                                     //         builder: (context) => BookingScreenNew(
                                     //             index: widget.index,
                                     //             boatId: snapshot.data!
                                     //             ['boatId'],
                                     //             ownerId: snapshot
                                     //                 .data!
                                     //             ['userId'])));
                                   },
                                   text: AppLocale.registerPlease.getString(context)),
                             ):
                             Padding(
                               padding:   EdgeInsets.symmetric(vertical: 0.0,horizontal: MySize2.size30),
                               child: StreamBuilder<DocumentSnapshot>(
                                   stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                                   builder: (context, snapshotC) {
                                     if(snapshotC.hasError){
                                       return const Icon(Icons.error);
                                     }
                                     else if(snapshotC.hasData){
                                       // print();

                                       return
                                         snapshotC.data!['status'] == 'Activate'?
                                         snapshotC.data!['verified']?

                                         StreamBuilder<DocumentSnapshot>(
                                             stream: FirebaseFirestore.instance.collection('BoatData').doc(widget.boatId).snapshots(),
                                             builder: (context, snapshotL) {
                                               if(!snapshotL.hasData){
                                                 return const Center(child: CircularProgressIndicator());
                                               }
                                               else if(snapshotL.connectionState == ConnectionState.waiting){
                                                 return const Center(child: CircularProgressIndicator());

                                               }else{
                                                 return
                                                   snapshotL.data!['locked']?
                                                   AppButton(
                                                       height:MySize2.size48,
                                                       onPressed: () {
                                                         // timeSlot.clearSlot();
                                                         // Navigator.push(
                                                         //     context,
                                                         //     MaterialPageRoute(
                                                         //         builder: (context) => BookingScreenNew(
                                                         //             index: widget.index,
                                                         //             boatId: snapshot.data!
                                                         //             ['boatId'],
                                                         //             ownerId: snapshot
                                                         //                 .data!
                                                         //             ['userId'])));
                                                       },
                                                       text: AppLocale.locked.getString(context)):
                                                   AppButton(
                                                       height:MySize2.size48,
                                                       onPressed: () {
                                                         timeSlot.clearSlot();
                                                         Navigator.push(
                                                             context,
                                                             MaterialPageRoute(
                                                                 builder: (context) => BookingScreenNew(
                                                                   // index: widget.index,
                                                                     boatId: snapshot.data!
                                                                     ['boatId'],
                                                                     ownerId: snapshot
                                                                         .data!
                                                                     ['userId'])));
                                                       },
                                                       text:
                                                       // 'Book Now'
                                                     AppLocale.bookNow
                                                           .getString(context)
                                                   );
                                               }
                                             }
                                         ):
                                         Consumer<LoadingProvider>(
                                           builder: (context,value, child){
                                             return AppButton(
                                                 height:MySize2.size48,

                                                 // loading: loadingProvider.loading,
                                                 onPressed: () async {
                                                   bool? isConnected = await Utils.checkInternetConnection();
                                                   if(isConnected){
                                                     // loadingProvider.loginLoading(true);
                                                     showDialog(
                                                         context: context,
                                                         builder: (BuildContext context) {
                                                           return Dialog(
                                                             shape: RoundedRectangleBorder(
                                                               borderRadius: BorderRadius.circular(15),
                                                             ),
                                                             child: Container(
                                                               height: 200,
                                                               width: 240,
                                                               decoration: BoxDecoration(
                                                                 borderRadius: BorderRadius.circular(15),
                                                                 color: primaryColor, // Replace with your desired color
                                                               ),
                                                               child: Column(
                                                                 crossAxisAlignment:
                                                                 CrossAxisAlignment.start,
                                                                 mainAxisAlignment:
                                                                 MainAxisAlignment.spaceBetween,
                                                                 children: [
                                                                   Padding(
                                                                     padding: const EdgeInsets.symmetric(
                                                                       vertical: 8.0,
                                                                       horizontal: 15,
                                                                     ),
                                                                     child: Column(
                                                                       crossAxisAlignment:
                                                                       CrossAxisAlignment.start,
                                                                       mainAxisAlignment:
                                                                       MainAxisAlignment.spaceBetween,
                                                                       children: [

                                                                         Row(
                                                                           crossAxisAlignment: CrossAxisAlignment.center,
                                                                           children: [
                                                                             Image(
                                                                               height: MySize2.size40,
                                                                               width: MySize2.size40,
                                                                               image: AssetImage(
                                                                                   customWindowBoat), // Replace with your logo asset
                                                                             ),
                                                                             const SizedBox(
                                                                               width: 10,
                                                                             ),
                                                                              Column(
                                                                               crossAxisAlignment:
                                                                               CrossAxisAlignment.start,
                                                                               mainAxisAlignment: MainAxisAlignment.start,
                                                                               children: [
                                                                                 Text(
                                                                                   AppLocale.verificationRequired.getString(context),
                                                                                   style: TextStyle(
                                                                                     color: Colors.white,
                                                                                     fontSize: 18,
                                                                                     fontWeight:
                                                                                     FontWeight.w600,
                                                                                   ),
                                                                                 ),
                                                                               ],
                                                                             )
                                                                           ],
                                                                         ),
                                                                          Padding(
                                                                           padding: EdgeInsets.only(left: 50.0),
                                                                           child: Row(
                                                                             children: [
                                                                               SizedBox(
                                                                                 width: width(context)* 0.4,
                                                                                 child: Text(
                                                                                   AppLocale.verificationViaPhone.getString(context),
                                                                                   maxLines: 4,
                                                                                   overflow: TextOverflow.ellipsis,
                                                                                   style: TextStyle(
                                                                                     fontSize: 16,
                                                                                     fontWeight: FontWeight.w400,
                                                                                     color: Colors.white,
                                                                                   ),
                                                                                 ),
                                                                               ),
                                                                             ],
                                                                           ),
                                                                         ),
                                                                       ],
                                                                     ),
                                                                   ),
                                                                   Container(
                                                                     width: double.infinity,
                                                                     height: 40,
                                                                     decoration: const BoxDecoration(
                                                                       color: Colors.white,
                                                                       borderRadius: BorderRadius.only(
                                                                         bottomLeft: Radius.circular(15),
                                                                         bottomRight: Radius.circular(15),
                                                                       ),
                                                                     ),
                                                                     child: Padding(
                                                                       padding: const EdgeInsets.all(4.0),
                                                                       child: Row(
                                                                         mainAxisAlignment:
                                                                         MainAxisAlignment.spaceAround,
                                                                         children: [
                                                                           Consumer<LoadingProvider>(
                                                                             builder: (context, value, child){
                                                                               return InkWell(
                                                                                 onTap: () {
                                                                                   loadingProvider.loginLoading(true);
                                                                                   isLogin();
                                                                                 },
                                                                                 child: loadingProvider.loading == true ? const Center(child: CircularProgressIndicator()): Text(AppLocale.yesContinue.getString(context), style: TextStyle(fontSize: 16,color: Colors.green),),
                                                                               );
                                                                             },
                                                                           ),
                                                                           InkWell(
                                                                             onTap: () {
                                                                               loadingProvider.loginLoading(false);
                                                                               loadingProvider2.loginLoading2(false);

                                                                               Navigator.pop(context);
                                                                             },
                                                                             child:  Text(AppLocale.later.getString(context), style: TextStyle(fontSize: 16,color: Colors.grey),),
                                                                           ),
                                                                         ],
                                                                       ),
                                                                     ),
                                                                   )
                                                                 ],
                                                               ),
                                                             ),
                                                           );
                                                         });

                                                   }else{
                                                     showNoInternetDialog(context);                                       }
                                                 },
                                                 text: 'Continue');
                                           },
                                         )
                                             :
                                         AppButton(
                                             onPressed: () {
                                               checkUserStatusAndLogout(context);

                                               // timeSlot.clearSlot();
                                               // Navigator.push(
                                               //     context,
                                               //     MaterialPageRoute(
                                               //         builder: (context) => BookingScreenNew(
                                               //             index: widget.index,
                                               //             boatId: snapshot.data!
                                               //             ['boatId'],
                                               //             ownerId: snapshot
                                               //                 .data!
                                               //             ['userId'])));
                                             },
                                             text: 'Conitunue')

                                       ;

                                     }else if(snapshotC.connectionState == ConnectionState.waiting){
                                       return const Center(child: CircularProgressIndicator());
                                     }
                                     return Container();
                                   }
                               ),
                             ),
                           )
                          ]),
                    )
                  ),
                  Positioned(
                      top: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: width(context) * 0.9,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: height(context)*0.04,
                                  width: height(context)*0.04,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            spreadRadius: 0

                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Back_Arrow(

                                      color: Colors.black,
                                      ontap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )),

                ],
              );
            }
            return const Text('nothing found');
          },
        ),
      ),
    );
  }


  GoogleMapController? mapController;
  Set<Marker> markers = {}; // Set to store markers

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> isLogin() async {
    String? phoneNumber = await getPhone();
    final loadingProvider =
    Provider.of<LoadingProvider>(context, listen: false);
    final loadingProvider2 = Provider.of<LoadingProvider2>(context, listen: false);


    _auth
        .verifyPhoneNumber(
      timeout: const Duration(seconds: 6),
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Utils.toastMessage(e.toString());
          print(e.toString());
          loadingProvider.loginLoading(false);
          loadingProvider2.loginLoading2(false);

        },
        codeSent: (String verification, int? token) {
          print(phoneNumber);
          loadingProvider.loginLoading(false);
          loadingProvider2.loginLoading2(false);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPVerification(
                    verificationId: verification,
                    phoneNumber: phoneNumber!,
                  )));
        },
        codeAutoRetrievalTimeout: (e) {
          loadingProvider.loginLoading(false);
          loadingProvider2.loginLoading2(false);

          print(e.toString());
        })
        .onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      loadingProvider.loginLoading(false);
      loadingProvider2.loginLoading2(false);

    });
  }
}
