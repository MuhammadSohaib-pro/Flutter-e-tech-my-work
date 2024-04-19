import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class PaidThankYouScreen extends StatelessWidget {
   PaidThankYouScreen({Key? key}) : super(key: key);
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Back_Arrow(
                    ontap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          BottomBarScreen()), (Route<dynamic> route) => false);                    },
                    image: close,),
                  Padding(
                    padding: const EdgeInsets.
                    symmetric(vertical: 58.0),
                    child: Column(
                      children: [
                        Text(AppLocale.thankYou.getString(context), style: text23600,),
                        SizedBox(
                          height: height(context)*0.02,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('User').doc(id).snapshots(),
                          builder: (context, snapshot){
                            if(snapshot.hasError){
                              return const Text('Network Error');
                            }
                            if(snapshot.hasData){
                              return Text('${'${AppLocale.dear.getString(context)} '
                                  + snapshot.data!['name']} ${AppLocale.bookingConfirmedDear.getString(context)}', style: text14500,);
                            }
                            return Container();
                          },),

                        SizedBox(
                          height: height(context)*0.04,
                        ),
                        Image(image: AssetImage(paymentDone)),
                        SizedBox(
                          height: height(context)*0.04,
                        ),
                        Text(AppLocale.justSitBack.getString(context), style: text16500,),
                        SizedBox(
                          height: height(context)*0.02,
                        ),
                        Center(
                          child: Text('You need to get to the boat location 10 minutes before the boat time'
                              ' otherwise your booking will be automatically canceled.', style: text11400op,
                            textAlign: TextAlign.center,),
                        ),
                      ],

                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: width(context),
                decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2
                      )
                    ]
                ),

              ),
            ),
            Positioned(
              bottom: 10,
              left: 40,
              child: AppButton(
                height: 50,
                width: width(context)*0.8,
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      BottomBarScreen()), (Route<dynamic> route) => false);
                  }, text:AppLocale.goToHome.getString(context),),
            ),
          ],
        ),
      ),
    );
  }
}
