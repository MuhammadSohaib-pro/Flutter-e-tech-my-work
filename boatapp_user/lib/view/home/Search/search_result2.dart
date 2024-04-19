import 'package:boat_app/provider/filter_provider.dart';
import 'package:boat_app/view/home/Search/filter.dart';
import 'package:boat_app/view/home/Search/searchScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../languages/LocaleString.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/sized_box.dart';
import '../../../utils/sizes_class.dart';
import '../../../utils/textstyles.dart';
import '../../boat_details/boat_details.dart';
import '../../bottomBar/bottom_bar.dart';

class SearchResult extends StatefulWidget {
  final String? searchh;
  
  final bool? fromFilter;
  // List<Map<String,dynamic>> searchData;
  SearchResult({
    super.key,
    required this.searchh,
    this.fromFilter,
    // required this.searchData
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  TextEditingController searchController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Map<String, dynamic>> boatsList = [];
  List<Map<String, dynamic>> filteredBoats = [];
  List<Map<String, dynamic>> filteredBoats2 = [];

  Future<void> getAllBoats() async {
    // Assuming getBoatsSearch is an asynchronous function that fetches data from Firebase
    boatsList = await getBoatsSearch(context);
    filteredBoats = boatsList;
    // print(boatsList.length);
    // print('ttttttttttttttttttttttttttttt');

    // After updating the data, trigger a UI refresh using setState
    setState(() {});
  }

  void nameFilter(String text) {
    // Use lowercase for case-insensitive comparison
    text = text.toLowerCase();
    // print(widget.searchh);

    // Filter the boatsList based on boatName
    filteredBoats = boatsList
        .where((boat) => boat['boatName'].toLowerCase().contains(text))
        .toList();

    // Print the number of filtered boats and the list itself


    // boatFilter();


  }

  // void boatFilter() {
  //   final fP = Provider.of<FilterProvider>(context,listen: false);
  //   String? boatType = fP.boatType;
  //   int minPrice = fP.sprice!;
  //   int maxPrice = fP.eprice!;
  //   int minPassengers = fP.spassengers!;
  //   int maxPassengers = fP.epassengers!;
  //   // Filter the boatsList based on boatType, price, and number of passengers
  //   // Filter the boatsList based on boatType, price, and number of passengers
  //   filteredBoats2 = filteredBoats.where((boat) {
  //     // final boatName = boat['boatName'].toLowerCase();
  //     final typeMatches = fP.boatType == 'All' ? boat['boatType']:
  //         boat['boatType'].toLowerCase() == boatType?.toLowerCase();
  //     final priceMatches =
  //         boat['boatPrice'] >= minPrice && boat['boatPrice'] <= maxPrice;
  //     final passengersMatches =
  //         boat['maxPerson'] >= minPassengers && boat['maxPerson'] <= maxPassengers;
  //
  //     return typeMatches && priceMatches && passengersMatches;
  //   }).toList();
  //   print(filteredBoats2.length);
  //   // Trigger a UI refresh using setState
  //   setState(() {});
  // }



  late bool noResult = false;
  @override
  void initState() {
    // TODO: implement initState
    getAllBoats().then((value) {
      nameFilter(widget.searchh!);
    });
    searchController.text = widget.searchh!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.searchh);
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => const SearchScreen()));
      //     },
      //     child: const Icon(Icons.arrow_back_ios_new),
      //   ),
      //   title: const Text('Search Results'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

        
                Container(
                  // height: MySize2.size42,
                  width: width(context) * 0.7,
                  decoration: ShapeDecoration(
                      color: grey7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: [
                        BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: MySize2.size16,
                        color: Colors.grey,
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      // contentPadding: EdgeInsets.only(
                      //   left: MySize2.size25,
                      //   right: MySize2.size25,
                      //
                      //   // top:
                      //   // MySize2.size5,
                      //   //SizeConfig.textMultiplier * 3,
                      // ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      nameFilter(value);
                      setState(() {

                      });
                    },
                    // obscureText: _isObscured,
                    onFieldSubmitted: (value) async {
                      print('object');
                      final SharedPreferences prefs = await _prefs;
                      List<String>? helper = [];
                      prefs.getStringList('recent') != null
                          ? helper = prefs.getStringList('recent')
                          : helper = [];
                      // print('ssssssssssssssssssss');
                      // print(helper);
                      // print(helper?.length);
        
                      if(value != ''){
                        if (helper!.length > 1) {
                          if (helper.length == 3) {
                            helper.removeAt(2);
                          }
                          helper.insert(0, value!);
                        } else {
                          helper.add(value!);
                        }
                      }
                      // helper!.length > 1
                      //     ? helper.length == 3
                      //         ? helper.removeAt(2)
                      //         : helper.insert(0, value!)
                      //     : helper.add(value!);
                      if (3 < helper!.length) {
                        helper.removeRange(3, helper.length);
                      }
                      // if (kDebugMode) {
                      //   print(helper);
                      //   print(helper.length);
                      //
                      //   print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                      // }
                      prefs.setStringList('recent', helper);
                      // if (kDebugMode) {
                      //   print(prefs.getStringList('recent'));
                      // }
        
                      // prefs.setStringList('recent', []);
                      // setState(() {});
                      // List<Map<String, dynamic>> Mapp =
                      // await getBoatsSearch(context);
                      //
                      // if (kDebugMode) {
                      //   print(Mapp);
                      // }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(
                                searchh: searchController.text,
                                // searchData: Mapp,
                              )));
                    },
                  ),
                ),
        
                searchController.text.isEmpty?
                InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(
                          filterProvider.boatindex,
                        );
                      }
                      if (kDebugMode) {
                        print(
                          filterProvider.epassengers,
                        );
                      }
                      if (kDebugMode) {
                        print(
                          filterProvider.eprice,
                        );
                      }
        
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          BottomBarScreen()), (Route<dynamic> route) => false);
                    },
                    child: Text(
                      AppLocale.cancel.getString(context),
                      style: TextStyle(
                        color: Color(0xFF0095FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ))
                    :
                InkWell(
                    onTap: () async{
                      if (kDebugMode) {
                        print(filterProvider.spassengers);
                      }
                      if (kDebugMode) {
                        print(filterProvider.epassengers);
                      }
                     var value = await getBoatWithHighestMaxPerson().then((value) {
                       print(value['maxPerson']);
                       print('%%%%%%%%%');

                       Navigator.push(context, MaterialPageRoute(builder: (context)=> FilterScreen(searchText: searchController.text,maxPerson:value['maxPerson'] ,)));

                     });
                    },
                    // async {
                    //   print('object');
                    //   final SharedPreferences prefs = await _prefs;
                    //   List<String>? helper = [];
                    //   prefs.getStringList('recent') != null
                    //       ? helper = prefs.getStringList('recent')
                    //       : helper = [];
                    //   print('ssssssssssssssssssss');
                    //   print(helper);
                    //   print(helper?.length);
                    //
                    //   if(searchController.text != ''){
                    //     if (helper!.length > 1) {
                    //       if (helper.length == 3) {
                    //         helper.removeAt(2);
                    //       }
                    //       helper.insert(0, searchController.text);
                    //     } else {
                    //       helper.add(searchController.text);
                    //     }
                    //   }
                    //   // helper!.length > 1
                    //   //     ? helper.length == 3
                    //   //         ? helper.removeAt(2)
                    //   //         : helper.insert(0, value!)
                    //   //     : helper.add(value!);
                    //   if (3 < helper!.length) {
                    //     helper.removeRange(3, helper.length);
                    //   }
                    //   if (kDebugMode) {
                    //     print(helper);
                    //     print(helper.length);
                    //
                    //     print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                    //   }
                    //   prefs.setStringList('recent', helper);
                    //   if (kDebugMode) {
                    //     print(prefs.getStringList('recent'));
                    //   }
                    //
                    //   // prefs.setStringList('recent', []);
                    //   // setState(() {});
                    //   // List<Map<String, dynamic>> Mapp =
                    //   // await getBoatsSearch(context);
                    //   //
                    //   // if (kDebugMode) {
                    //   //   print(Mapp);
                    //   // }
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => SearchResult(
                    //             searchh: searchController.text,
                    //             // searchData: Mapp,
                    //           )));
                    // },
                    child: SvgPicture.asset(filterC))
              ],
            ),
            // ListView.builder(
            //                       shrinkWrap: true,
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       itemCount: filteredBoats.length,
            //                           // .length, //noResult == false ? snapshot.data!.docs.length : 1,
            //                       itemBuilder: (context, index) {
            //                         String boatId = filteredBoats[index]['boatId'];
            //
            //                         String name = filteredBoats[index]['boatName'];
            //                         String imageUrl = filteredBoats[index]['image1'];
            //                         String price = filteredBoats[index]['boatPrice'];
            //                         String location = filteredBoats[index]['area'];
            //                         String maxPerson = filteredBoats[index]['maxPerson'];
            //                         String boatType = filteredBoats[index]['boatType'];
            //                         if (kDebugMode) {
            //                           print(filterProvider.spassengers);
            //                         }
            //                         if (kDebugMode) {
            //                           print(filterProvider.epassengers);
            //                         }
            //
            //                         if (kDebugMode) {
            //                           print(search);
            //                         }
            //                         if (!name
            //                             .toLowerCase()
            //                             .contains(search!.toLowerCase())) {
            //                           noResult = true;
            //                           if (kDebugMode) {
            //                             print(noResult);
            //                           }
            //                           return Container(
            //                             // height: 10,
            //                             // width: 90,
            //                             // color: Colors.pink,
            //                           );
            //                            // Return an empty widget if the condition is false
            //                         } else {
            //                           return Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 horizontal: 10.0, vertical: 30),
            //                             child: InkWell(
            //                               onTap: () {
            //                                 Navigator.push(
            //                                     context,
            //                                     MaterialPageRoute(
            //                                         builder: (context) =>
            //                                             BoatDetails(
            //                                               // index: index,
            //                                               boatId:
            //                                                  boatId,
            //                                             )));
            //                               },
            //                               child: Stack(
            //                                 clipBehavior: Clip.none,
            //                                 children: [
            //                                   Container(
            //                                     width: width(context) * 0.95,
            //                                     height: height(context) * 0.2,
            //                                     clipBehavior: Clip.antiAlias,
            //                                     decoration: BoxDecoration(
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                                 16)),
            //                                     child: CachedNetworkImage(
            //                                       width: width(context),
            //                                       height: height(context),
            //                                       fit: BoxFit.cover,
            //                                       imageUrl: imageUrl,
            //                                       placeholder: (context,
            //                                               url) =>
            //                                           const Center(
            //                                               child:
            //                                                   CircularProgressIndicator()),
            //                                       errorWidget:
            //                                           (context, url, error) =>
            //                                               const Icon(Icons.error),
            //                                     ),
            //                                   ),
            //                                   Positioned(
            //                                     bottom: -45,
            //                                     child: Container(
            //                                       width:
            //                                           width(context) * 0.95,
            //                                       decoration: BoxDecoration(
            //                                           boxShadow: const [
            //                                             BoxShadow(
            //                                                 blurRadius: 5,
            //                                                 color:
            //                                                     Colors.grey,
            //                                                 offset:
            //                                                     Offset(0, 2))
            //                                           ],
            //                                           borderRadius:
            //                                               BorderRadius
            //                                                   .circular(16),
            //                                           color: Colors.white),
            //                                       child: Padding(
            //                                         padding:
            //                                             const EdgeInsets.all(
            //                                                 8.0),
            //                                         child: Row(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .spaceBetween,
            //                                           children: [
            //                                             Column(
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .start,
            //                                               children: [
            //                                                 Row(
            //                                                   crossAxisAlignment:
            //                                                       CrossAxisAlignment
            //                                                           .center,
            //                                                   children: [
            //                                                     Container(
            //                                                       width: width(context)* 0.6,
            //                                                       child: Text(
            //                                                         name,
            //                                                         maxLines: 1,
            //                                                         overflow: TextOverflow.ellipsis,
            //                                                         style:
            //                                                             text18600,
            //                                                       ),
            //                                                     ),
            //                                                   ],
            //                                                 ),
            //                                                 const Text(
            //                                                   'location',
            //                                                 ),
            //                                                 Row(
            //                                                   children: [
            //                                                     const Icon(
            //                                                       Icons.star,
            //                                                       size: 15,
            //                                                       color: Color(
            //                                                           0xff494AFF),
            //                                                     ),
            //                                                     const Icon(
            //                                                       Icons.star,
            //                                                       size: 15,
            //                                                       color: Color(
            //                                                           0xff494AFF),
            //                                                     ),
            //                                                     const Icon(
            //                                                       Icons.star,
            //                                                       size: 15,
            //                                                       color: Color(
            //                                                           0xff494AFF),
            //                                                     ),
            //                                                     const Icon(
            //                                                       Icons.star,
            //                                                       size: 15,
            //                                                       color: Color(
            //                                                           0xff494AFF),
            //                                                     ),
            //                                                     Icon(
            //                                                       Icons.star,
            //                                                       size: 15,
            //                                                       color: Colors
            //                                                           .grey
            //                                                           .shade500,
            //                                                     ),
            //                                                     Text(
            //                                                       AppLocale
            //                                                           .rating
            //                                                           .getString(
            //                                                               context),
            //                                                       style:
            //                                                           text11400,
            //                                                     )
            //                                                   ],
            //                                                 )
            //                                               ],
            //                                             ),
            //                                             Column(
            //                                               mainAxisAlignment:
            //                                                   MainAxisAlignment
            //                                                       .spaceBetween,
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .end,
            //                                               children: [
            //                                                 Row(
            //                                                   children: [
            //                                                     Image(
            //                                                         height:
            //                                                             20,
            //                                                         width: 20,
            //                                                         image: AssetImage(
            //                                                             profile)),
            //                                                     Text(
            //                                                       maxPerson,
            //                                                       style:
            //                                                           text11400,
            //                                                     ),
            //                                                     const SizedBox(
            //                                                       width: 5,
            //                                                     )
            //                                                   ],
            //                                                 )
            //                                               ],
            //                                             )
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                           );
            //                         }
            //                       },
            //                     ),
           filteredBoats.isNotEmpty ?
           Expanded(
               child: Padding(
                 padding: EdgeInsets.symmetric(vertical: height(context) * 0.01, horizontal: MySize2.size20),
                 child: GridView.builder(
                     physics: const AlwaysScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                       maxCrossAxisExtent: 200,
                       childAspectRatio: 1.7 / 2,
                       crossAxisSpacing: 15,
                       // mainAxisSpacing: 40
                     ),
                     // shrinkWrap: true,
                     // physics: const NeverScrollableScrollPhysics(),
                     itemCount: filteredBoats.length,
                     itemBuilder: (context, index) {
                       var snap = filteredBoats[index];

                       return Padding(
                         padding: EdgeInsets.only(
                             top: height(context) * 0.07, bottom: MySize2.size10),
                         child: InkWell(
                           onTap: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => BoatDetails(
                                       // index: index,
                                       boatId: snap['boatId'],
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
                                           child: Text('${snap['boatPrice']} SAR',
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
                     }),
               )):
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(child: Text('No boat Found')),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<Map<String, dynamic>> getBoatWithHighestMaxPerson() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BoatData')
        .orderBy('maxPerson', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final QueryDocumentSnapshot document = querySnapshot.docs.first;
      return document.data() as Map<String, dynamic>;
    } else {
      return {}; // Return an empty map if no documents are found
    }
  }
}
