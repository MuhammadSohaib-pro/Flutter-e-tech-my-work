import 'package:flutter/material.dart';

import '../../Auth/component/containetetfeild.dart';
import '../../global/colors.dart';
import '../../global/component/app_text_field.dart';
import '../../global/layout/asset_images.dart';
import '../../global/layout/mySize.dart';
import '../../global/layout/sizeconfig.dart';
import '../../global/layout/sizes_class.dart';
import '../../global/layout/textstyle.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 0,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          'Profile',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        actions: [
          TextButton(onPressed: (){}, child: Text('Edit'))
        ],
        centerTitle: true,
      ),
      body: Column(
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image(image: AssetImage(AssetImages.pencil),height: height(context)*0.01,),
          //     SizedBox(width: width(context)*0.01,),
          //     Text('Edit profile',  style:TextStyle(fontWeight: FontWeight.w400,fontSize: 10),)
          //   ],
          // ),
          SizedBox(
            height: MySize.size20,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MySize.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name',style: TextStyle(fontSize: MySize.size14, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: MySize.size10,
                ),
                ContainerTextField2(
                  horizontalPadding: 1.5,

                  controller: nameController,
                  hintText: 'Name',
                  borderRadius: 5,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: MySize.size20,
                ),
                Text('Email',style: TextStyle(fontSize: MySize.size14, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: MySize.size10,
                ),
                ContainerTextField2(
                  controller: nameController,
                  hintText: 'Email',
                  borderRadius: 5,
                  horizontalPadding: 1.5,

                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(
                  height: MySize.size20,
                ),
                Text('Contact',style: TextStyle(fontSize: MySize.size14, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: MySize.size10,
                ),
                ContainerTextField(
horizontalPadding: 1.5,
                  controller: nameController, hintText: 'Contact', keyboardType: TextInputType.phone,
                  borderRadius: 5, suffixIcon: Container(
                    width: 100,
                    color: Colors.grey.shade200,
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('verified'),
                        Icon(Icons.done)
                      ],
                    ))),
                ),
                SizedBox(
                  height: MySize.size20,
                ),
                Text('Password',style: TextStyle(fontSize: MySize.size14, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: MySize.size10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width(context)*0.7,
                      child: ContainerTextField2(
                        obscureText: true,
                        controller: nameController,
                        hintText: 'Email',
                        horizontalPadding: 1.5,
                        borderRadius: 5,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    TextButton(onPressed: (){}, child: Text('Reset'))
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
