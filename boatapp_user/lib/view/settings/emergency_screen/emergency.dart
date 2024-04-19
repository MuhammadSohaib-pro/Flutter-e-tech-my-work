import 'package:boat_app/view/settings/emergency_screen/update_emergency_screen.dart';
// import 'package:boat_app/view/profile/settings.dart';
// import 'package:boat_app/view/profile/update_emergency_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../custom_widgets/app_button.dart';
import '../../../custom_widgets/back_arrow.dart';
import '../../../languages/LocaleString.dart';
import '../../../utils/colors.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/sized_box.dart';
import '../../../utils/textstyles.dart';
import '../../booking/booking_details.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.emergencyInfo.getString(context)),
      ),
      body: SingleChildScrollView(
        child: SafeArea (

          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('emergencyDetails').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Icon(Icons.error);
              }
              else if(snapshot.hasData){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 20),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(dp),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.collection('User').doc(id).snapshots(),
                            builder: (context, snapshot2){
                              if(snapshot2.hasError){
                                return const Text('Network Error');
                              }
                              if(snapshot2.hasData){
                                return Text(
                                  'Abdullah', style: text17700,);
                              }
                              return Container();
                            },),


                        ],
                      ),

                    ),
//tab here
                    Center(
                      child: TabBar(
                        unselectedLabelColor: const Color(0xff9FA5C0),
                        labelColor: primaryColor,
                        indicatorColor: primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        tabs: [

                          Tab(text:AppLocale.info.getString(context),),
                          Tab(text: AppLocale.contact.getString(context)),
                        ],
                      ),
                    ),
                    Container(
                      height: height(context)*0.45,
                      width: width(context),// Adjust the height as per your requirement
                      child: TabBarView(
                        controller: _tabController,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(AppLocale.address.getString(context), style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ),),
                                         Text(snapshot.data!['address'], style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(AppLocale.bloodGroup.getString(context), style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ),),
                                         Text(snapshot.data!['bloodGroup'], style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(),



                              ],
                            ),
                          ),
                           Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    height: 0.4 * height(context),
                                    child: ListView.builder(
                                        itemCount: (snapshot.data!['contacts'] as List<dynamic>).length,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context, index){
                                      return        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data!['contacts'][index]['name'], style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700
                                              ),),
                                              Text(snapshot.data!['contacts'][index]['phone'], style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey
                                              ),),
                                              const Divider(),
                                            ],
                                          ),

                                        ],
                                      );
                                    }),
                                  ),
                                ),



                              ],
                            ),
                          )


                        ],
                      ),
                    ),
                    AppButton(onPressed: (){
                      // print(snapshot.data!['contacts']);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateEmergencyDetails()));
                    }, text: 'Edit', width: width(context)* 0.8,)
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
    );
  }
}
