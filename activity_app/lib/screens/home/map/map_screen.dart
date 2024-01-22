import 'package:activityapp/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/layout/sizeconfig.dart';
import '../../../global/layout/textstyle.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        // flexibleSpace: ,
        toolbarHeight: 70,
        leading: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 0,
          ),
          child: Icon(Icons.close,color: Colors.black,)
        ),
        title: Consumer<HomeCtrl>(
          builder:(context,provider,child) =>Padding(
            padding: EdgeInsets.only( right: 5 * SizeConfig.widthMultiplier,),
            child: GestureDetector(
            onTap: () async {

            },
            child:
               Container(
             //    width: double.infinity,
                  height: 5.5 * SizeConfig.heightMultiplier,
                  // width: 50 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // color: AppColors.primaryColor,
                    border: Border.all(color: const Color(0xffA6A6A6)),
                  ),
                  padding: EdgeInsets.only(
                      right: 2.5 * SizeConfig.widthMultiplier,
                      left: 2.5 * SizeConfig.widthMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.s,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: SizeConfig.textMultiplier * 2.5,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 2,
                          ),
                          SizedBox(
                            //height: 50,
                            width: SizeConfig.widthMultiplier*60,
                            child: TextField(

                              controller: provider.searchController,  // You may want to use a TextEditingController to manage the text input
                              decoration: InputDecoration(
                                hintText: 'Dubai Internatinal City',
                                hintStyle: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 1.8,
                                  FontWeight.w400,
                                ),
                                border: InputBorder.none, // Remove the border
                              ),
                              style: MyTextStyles.latoTextstyle(
                                SizeConfig.textMultiplier * 1.8,
                                FontWeight.w400,
                              ),
                            ),
                          )

                        ],
                      ),
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  )),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
