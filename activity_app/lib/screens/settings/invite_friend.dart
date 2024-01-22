import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/sizes_class.dart';
import 'package:flutter/material.dart';

import '../../global/layout/mySize.dart';

class InviteFriendScreen extends StatelessWidget {
  const InviteFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Invite'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Invite Your Friend!'
                , style: TextStyle(fontWeight: FontWeight.w600,
                    fontSize: MySize.size16),),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MySize.size30),
                child: Text('Yorem ipsum dolor sit amet,'
                    ' consectetur adipiscing elit. '
                    'Nunc vulputate libero et velit'
                    ' interdum, ac aliquet odio mattis.'
                  ,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400,
                    fontSize: MySize.size10,color: AppColors.greyText),),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:MySize.size50,vertical: MySize.size30),
                child: Image(image: AssetImage(AssetImages.inviteFirend)),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MySize.size30),
                child: Text('Porem ipsum dolor sit amet,'
                    ' consectetur adipiscing elit.'
                    ' Nunc vulputate libero et velit interdum'
                    ', ac aliquet odio mattis. Class aptent '
                    'taciti sociosqu ad litora torquent per conubia nostra,'
                    ' per inceptos himenaeos.' ,textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400,
                    fontSize: MySize.size12,),),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:MySize.size12,vertical: MySize.size30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MySize.size240,
                      height: MySize.size48,
                      decoration: BoxDecoration(
                        color: AppColors.greyText.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        )
                      ),
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('http://hsgxsakhvdakvdakh', style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: MySize.size12,)),
                          Icon(Icons.copy, color: AppColors.primaryColor,size: MySize.size16,)
                        ],
                      )),
                    ),
                    Container(
                      width: MySize.size96,
                      height: MySize.size48,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          )
                      ),
                      child: Center(child: Text('Share',
                        style: TextStyle(color: Colors.white,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500
                      ),)),
                    ),
        
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
