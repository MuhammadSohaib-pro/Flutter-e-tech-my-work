import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/sizes_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global/layout/sizeconfig.dart';
import '../../../global/layout/textstyle.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize2().init(context);
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text(
          'Notifications',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){}, child: Text('Mark as read',style: TextStyle(color: AppColors.primaryColor,fontSize: 12),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
                height: MySize2.size80,
                // width:width(context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10, color: Colors.grey.shade300
                    )
                  ]
                ),
                child:
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetImages.notif),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Bike event coming soon!',style: TextStyle(fontSize: MySize2.size14,fontWeight: FontWeight.w600),),
                          Container(
                            width: MySize2.size260,
                            child: Text('Bike event coming soon happening and you should come and join usBike event coming soon happening and you should come and join us',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: MySize2.size10,
                                    fontWeight: FontWeight.w400)),
                          )

                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),

    );
  }
}
