import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global/layout/asset_images.dart';
import '../../global/layout/textstyle.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.ticketcolor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'About Us',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MySize.size50,
              ),
            Center(child: Image(image: AssetImage(AssetImages.applogoblk),height: MySize.size132,)),
              SizedBox(
                height: MySize.size20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Activity',
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: MySize.size20),),
                  Text(' App',
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: MySize.size20,color: AppColors.primaryColor),),
                ],
              ),
        SizedBox(
          height: MySize.size50,
        ),
              Text('Contact Us',
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: MySize.size16,),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  SvgPicture.asset(AssetImages.facebook),
                    SvgPicture.asset(AssetImages.twitter),
                    SvgPicture.asset(AssetImages.insta),
                    SvgPicture.asset(AssetImages.linkd),
                    SvgPicture.asset(AssetImages.gmail)
                  ],
                ),
              ),
              Text('About Us',
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: MySize.size16,),
              ),
              SizedBox(
                height: MySize.size15,
              ),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.'
                'Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. Aenean feugiat ex eu vestibulum vestibulum. Morbi a eleifend magna. Nam metus lacus, porttitor eu mauris a, blandit ultrices nibh. Mauris sit amet magna non ligula vestibulum eleifend. Nulla varius volutpat turpis sed lacinia. Nam eget mi in purus lobortis eleifend. Sed nec ante dictum sem condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis nisi, ac posuere leo.'
                , style: TextStyle(fontWeight: FontWeight.w400,fontSize: MySize.size10,),)
        
          ],),
        ),
      ),

    );
  }
}
