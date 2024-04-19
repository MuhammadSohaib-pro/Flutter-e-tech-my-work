
import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/boat_details/boat_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../utils/colors.dart';
import '../../utils/image_paths.dart';

class MapsWithMarkers extends StatefulWidget {
  // final double lat,long;
  const MapsWithMarkers({Key? key,
    // required this.lat, required this.long
  }) : super(key: key, );

  @override
  State<MapsWithMarkers> createState() => _MapsWithMarkersState();
}

class _MapsWithMarkersState extends State<MapsWithMarkers> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final List<Marker> _marker = <Marker>[];

  final List<LatLng> _list = <LatLng>[
  ];
  Future<void> setList()async {
    print('----------------------------------');

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BoatData')
    .where('boatStatusApproved', isEqualTo: true)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for(int i = 0; i< querySnapshot.docs.length; i++){
        LatLng lalo = LatLng(
            double.parse(querySnapshot.docs[i]['Latitude'].toString()), // Convert to String first
            double.parse(querySnapshot.docs[i]['Longitude'].toString()) // Convert to String first
        );
        _list.add(lalo);
        loadData();

      //   print(_list);
      // print('----------------------------------');

      }
    } else {
    }
  }


  Future<Uint8List> getBytesfromassets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi =await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))! .buffer.asUint8List();
  }
  List<String> images = [
    customWindow,
  ];

  @override
  void initState() {
    // TODO: implement initState
    setList();
    super.initState();
  }

  loadData() async {

    print(_list.length);
    for (int i = 0; i < _list.length; i++) {
      final Uint8List markerIcon = await getBytesfromassets(images[0], 80);

      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),

          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MySize2.size40,vertical: MySize2.size20),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('BoatData').snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Icon(Icons.error);
                        }
                        else if(snapshot.hasData){
                          var snap =snapshot.data!.docs[i];
                          String boatId = snap['boatId'];
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -MySize2.size40,
                                 left: MySize2.size15,
                                child: Container(
                                    height: MySize2.size80,
                                    width:MySize2.size140,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: snap['image1'],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),)
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: MySize2.size15, top: MySize2.size15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       height: 80,
                                        //       width: 120,
                                        //       child: CachedNetworkImage(
                                        //         imageUrl: snap['image1'],
                                        //         fit: BoxFit.cover,
                                        //         placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        //         errorWidget: (context, url, error) => const Icon(Icons.error),)
                                        //     ),
                                        //     SizedBox(width: 10,),
                                        //
                                        //   ],
                                        // ),
                                        SizedBox(height: MySize2.size30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Text(snap['boatType'], style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MySize2.size12, fontWeight: FontWeight.w500
                                            ),),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_on, color: Colors.white.withOpacity(0.5),size: 8,),

                                            Text(snap['area'], style: TextStyle(
                                                fontSize: MySize2.size6, fontWeight: FontWeight.w400,
                                                color: Colors.white
                                            ),overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children: [

                                            Container(
                                              width: width(context)*0.2,
                                              child: Text('\$ '+snap['boatPrice'], style: TextStyle(
                                                  fontSize: MySize2.size10, fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),overflow: TextOverflow.ellipsis,),
                                            ),
                                          ],
                                        ),




                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: width(context),
                                    height: MySize2.size40,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.all(MySize2.size8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                                    BoatDetails(boatId: snap['boatId'],
                                                        // index: i
                                                    )));
                                              },
                                              child: Text(AppLocale.viewDetails.getString(context),
                                                style: TextStyle(fontSize: MySize2.size10, fontWeight: FontWeight.w400, color: greyText),)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        return Container();
                      }
                    ),
                  ),
                ),
                _list[i]);
          },
          position: _list[i],
          // infoWindow: InfoWindow(title: 'My Home')
        ),
      );
      setState(() {});
    }
  }

  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // foregroundColor: Colors.white,
        title: Text('Map'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.close),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Stack(
        children: [

          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(23.8859, 45.0792)),
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            markers: Set<Marker>.of(_marker),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: MySize2.size180,
            width: MySize2.size250,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
