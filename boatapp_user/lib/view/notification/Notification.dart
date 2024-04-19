import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/custom_widgets/reuseable_container.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocale.notification.getString(context),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
        leading: IconButton(icon: Icon(Icons.close),onPressed: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()));
        },),
        actions: [
          InkWell(
            onTap: (){
              FirebaseFirestore.instance.collection('notifications').get().then((snapshot) {
                for (DocumentSnapshot ds in snapshot.docs) {
                  ds.reference.update({
                    'status': 'read', //True or false
                  });
                }
              });
            },
            child: Text(AppLocale.markAsRead.getString(context),
                style: TextStyle(
                    fontSize: 1.5 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.w500,
                  color: primaryColor
                )),
          ),
          SizedBox(width: 15,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(2*SizeConfig.heightMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('notifications').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Icon(Icons.error);
                    }
                    else if(snapshot.hasData){
                      if(snapshot.data!.docs.isEmpty){

                        return Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1* SizeConfig.heightMultiplier,
                              ),
                              Text(AppLocale.nothingHere.getString(context), style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 2* SizeConfig.textMultiplier
                              ),),
                              SizedBox(
                                height: 1* SizeConfig.heightMultiplier,
                              ),
                              SvgPicture.asset(noNotifications),
                            ],
                          ),
                        );
                      }else{
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemBuilder: (context, index){
                              return Padding(
                                padding:  EdgeInsets.all(0.6 * SizeConfig.heightMultiplier),
                                child: ReusableContainerWithHW(
                                  height: MySize2.size60,
                                    width: width(context),
                                    bgColor: snapshot.data!.docs[index]['status'] == 'unread'? white1 :grey7,

                                    child:
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal:2 *SizeConfig.heightMultiplier),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            snapshot.data!.docs[index]['status'] == 'unread'?
                                            notificationUnread : notification,
                                            height: 4 *SizeConfig.heightMultiplier,
                                            width: 5* SizeConfig.widthMultiplier,),
                                          SizedBox(
                                            width:3*  SizeConfig.widthMultiplier,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data!.docs[index]['title'],style: TextStyle(fontSize: MySize2.size14, fontWeight: FontWeight.w600,
                                              color: snapshot.data!.docs[index]['status'] == 'unread'? Colors.black: greyText ),),
                                              Text(snapshot.data!.docs[index]['body'],style: TextStyle(fontSize: MySize2.size10, fontWeight: FontWeight.w400,
                                                  color: snapshot.data!.docs[index]['status'] == 'unread'? Colors.black: greyText ),),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            });

                      }
                    }
                    else if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
                    return Container();
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
