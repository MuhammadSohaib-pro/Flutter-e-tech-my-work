import 'package:boat_app/custom_widgets/ContanerWidget.dart';
import 'package:boat_app/custom_widgets/app_text_field.dart';
import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/custom_widgets/big_divider.dart';
import 'package:boat_app/custom_widgets/custom_textfield.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/provider/filter_provider.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/home/Search/filter.dart';
import 'package:boat_app/view/home/Search/search_result2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/common_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/sizes.dart';
import '../../bottomBar/bottom_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController searchController = TextEditingController();
  List<String> lisat = [];
  Future<List<String>?> recent() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(sp.getStringList('recent'));
    }
    if (sp.getStringList('recent') != null) {
      lisat = sp.getStringList('recent')!;
      setState(() {});
    }
    return sp.getStringList('recent');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recent();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            // AppTextField2(
            //   width: width(context) * 0.7,
            //   hintText: 'Search',
            //   controller: searchController,
            //   onSaved: (value) async {
            //     print('object');
            //     final SharedPreferences prefs = await _prefs;
            //     List<String>? helper = [];
            //     prefs.getStringList('recent') != null
            //         ? helper = prefs.getStringList('recent')
            //         : helper = [];
            //     print('ssssssssssssssssssss');
            //     print(helper);
            //     print(helper?.length);
            //
            //
            //     if(helper!.length > 1){
            //       if(helper.length == 3){
            //         helper.removeAt(2);
            //       }
            //       helper.insert(0, value!);
            //
            //     }
            //     else{
            //       helper.add(value!);
            //     }
            //     // helper!.length > 1
            //     //     ? helper.length == 3
            //     //         ? helper.removeAt(2)
            //     //         : helper.insert(0, value!)
            //     //     : helper.add(value!);
            //     if (3 < helper.length) {
            //       helper.removeRange(3 , helper.length);
            //     }
            //     if (kDebugMode) {
            //       print(helper);
            //       print(helper.length);
            //
            //       print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
            //
            //     }
            //     prefs.setStringList('recent', helper);
            //     if (kDebugMode) {
            //       print(prefs.getStringList('recent'));
            //     }
            //
            //     // prefs.setStringList('recent', []);
            //     setState(() {});
            //     List<Map<String, dynamic>> Mapp =
            //     await getBoatsSearch(context);
            //
            //     if (kDebugMode) {
            //       print(Mapp);
            //     }
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => SearchResult(
            //               search: searchController.text,
            //               searchData: Mapp,
            //             )));
            //   },
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///

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
                      //  // top:
                      //  //      MySize2.size5,
                      //   //SizeConfig.textMultiplier * 3,
                      // ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value){
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
                      print('ssssssssssssssssssss');
                      print(helper);
                      print(helper?.length);

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
                      if (kDebugMode) {
                        print(helper);
                        print(helper.length);

                        print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                      }
                      prefs.setStringList('recent', helper);
                      if (kDebugMode) {
                        print(prefs.getStringList('recent'));
                      }

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
                    onTap: ()  async {
                      print('object');
                      final SharedPreferences prefs = await _prefs;
                      List<String>? helper = [];
                      prefs.getStringList('recent') != null
                          ? helper = prefs.getStringList('recent')
                          : helper = [];
                      print('ssssssssssssssssssss');
                      print(helper);
                      print(helper?.length);

                      if(searchController.text != ''){
                        if (helper!.length > 1) {
                          if (helper.length == 3) {
                            helper.removeAt(2);
                          }
                          helper.insert(0, searchController.text);
                        } else {
                          helper.add(searchController.text);
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
                      if (kDebugMode) {
                        print(helper);
                        print(helper.length);

                        print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                      }
                      prefs.setStringList('recent', helper);
                      if (kDebugMode) {
                        print(prefs.getStringList('recent'));
                      }

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
                    child: Text(
                      AppLocale.search.getString(context),
                      style: TextStyle(
                        color: Color(0xFF0095FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ))
              ],
            ),
            const Big_divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: 30,
                      width: width(context),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: lisat.length == 3 ? 3 : lisat.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: InkWell(
                                  onTap: () async {
                                    // searchController.text = lisat[index];
                                    // List<Map<String, dynamic>> Mapp =
                                    //     await getBoatsSearch(context);

                                    // if (kDebugMode) {
                                    //   print(Mapp);
                                    // }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchResult(
                                              searchh: lisat[index],
                                              // searchData: Mapp,
                                            )));
                                  },
                                  child: Container(
                                    // width: 100,
                                    height: 26,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 6),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          lisat[index],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  // ListTile(
                                  //   leading: const Icon(
                                  //     Icons.watch_later_outlined,
                                  //     color: Colors.grey,
                                  //   ),
                                  //   title: Text(lisat[index]),
                                  //   trailing: const Icon(
                                  //     Icons.subdirectory_arrow_left,
                                  //     color: Colors.grey,
                                  //   ),
                                  // )

                                  ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
