import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/sizes_class.dart';
import 'package:activityapp/screens/settings/about_us.dart';
import 'package:activityapp/screens/settings/invite_friend.dart';
import 'package:activityapp/screens/settings/privacyAndTerms.dart';
import 'package:activityapp/screens/settings/profile_screen.dart';
import 'package:activityapp/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global/layout/mySize.dart';
import '../../global/layout/sizeconfig.dart';
import '../../global/layout/textstyle.dart';
import '../../languages/LocaleString.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(

      // appBar: AppBar(
      //
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   leading: InkWell(
      //     onTap: (){
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(
      //         left: SizeConfig.widthMultiplier * 0,
      //       ),
      //       child: const Icon(
      //         Icons.close,
      //         color: Colors.black,
      //         size: 20,
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     'Settings',
      //     style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),

      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AssetImages.circle),alignment: Alignment.topLeft)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: MySize.size160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'dp',
                  child: Center(
                    child: Container(
                      height: MySize.size180,
                      width: MySize.size180,
                      decoration: BoxDecoration(
                        color: Color(0xffeeeffe),
                        shape: BoxShape.circle

                      ),
                    child:  Center(
                      child: Container(
                        height: MySize.size140,
                        width: MySize.size140,
                        decoration: BoxDecoration(
                            color: Color(0xffe2e4fc),
                            shape: BoxShape.circle

                        ),
                        child: Center(
                          child: CircleAvatar(
                            radius: MySize.size48,
                            backgroundColor: Colors.lightGreen,
                          ),
                        ),
                      ),
                    ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context)*0.01,
                ),
                Center(child: Text('Name', style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w600,fontSize: 16),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(AssetImages.pencil),height: height(context)*0.01,),
                    SizedBox(width: width(context)*0.01,),
                    Text('Edit profile',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),)
                  ],
                ),

                SizedBox(height: MySize.size40,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: MySize.size20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // profile info
                      Text('Profile & Information',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SizedBox(
                        height: height(context)* 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                        },
                        child: Container(
                          width: width(context),
                          height: height(context)*0.07,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: height(context)*0.01,horizontal: width(context)*0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetImages.profile),
                                SizedBox(width: width(context)*0.02,),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text(AppLocale.profile.getString(context),  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),

                                    Text('Profile Information, Profile Picture',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size20,),

                      //invite
                      Text('Invite',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SizedBox(
                        height: height(context)* 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> InviteFriendScreen()));

                        },
                        child: Container(

                          width: width(context),
                          height: height(context)*0.07,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: height(context)*0.01,horizontal: width(context)*0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetImages.invite),
                                SizedBox(width: width(context)*0.02,),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text('Invite Friend',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),

                                    Text('Share link, Share on social media',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: MySize.size20,),

                      // settings
                      Text('Settings',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SizedBox(
                        height: height(context)* 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsScreen()));

                        },
                        child: Container(

                          width: width(context),
                          height: height(context)*0.07,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: height(context)*0.01,horizontal: width(context)*0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetImages.settings),
                                SizedBox(width: width(context)*0.02,),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text(AppLocale.settings.getString(context),  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),

                                    Text(AppLocale.settings.getString(context)+', '+
                                      AppLocale.language.getString(context)+', '+
                                        'Delete Account'+', '+ AppLocale.logOut.getString(context)  ,
                                      style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: MySize.size20,),

                      Text('Policies & About Us',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SizedBox(
                        height: height(context)* 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));

                        },
                        child: Container(

                          width: width(context),
                          height: height(context)*0.07,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: height(context)*0.01,horizontal: width(context)*0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetImages.privacy),
                                SizedBox(width: width(context)*0.02,),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text('Privacy Policy & Terms',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),

                                    // Text('Notification, Language, Delete Account, Logout',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context)* 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
                        },

                        child: Container(

                          width: width(context),
                          height: height(context)*0.07,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: height(context)*0.01,horizontal: width(context)*0.03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AssetImages.about),
                                SizedBox(width: width(context)*0.02,),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text('About Us',  style:TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),

                                    // Text('Notification, Language, Delete Account, Logout',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: MySize.size30,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
