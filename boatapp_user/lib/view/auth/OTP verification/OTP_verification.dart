import 'dart:async';

import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/custom_widgets/loader_view.dart';
import 'package:boat_app/provider/loading_provider/loading_provider.dart';
import 'package:boat_app/utils/utils.dart';
import 'package:boat_app/view/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/app_button.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../languages/LocaleString.dart';
import '../../../provider/loader_view_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/sized_box.dart';
import '../../../utils/textstyles.dart';
import '../../bottomBar/bottom_bar.dart';

class OTPVerification extends StatefulWidget {
  final String verificationId, phoneNumber,from;


  const OTPVerification({Key? key,required this.verificationId, required this.phoneNumber, this.from= 'All'}) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  StreamController<ErrorAnimationType>? errorController;
  final FlutterLocalization localization = FlutterLocalization.instance;

  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance ;

  TextEditingController verificationCodeController = TextEditingController();
  AuthService authService = AuthService();
  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    final obj = Provider.of<LoaderViewProvider>(context, listen: false);

    return Stack(
      children: [
        
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
    ),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()
              {
                if(widget.from =='All'){
                  FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
                    'verified': false
                  }).then((value) {
                    authService.signOut().then((value) {
                      Navigator.pop(context);
                    });
                  });
                }else if (widget.from == 'phone'){
                  Navigator.pop(context);
          
          
                }
              },),
            ),
            body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                       Text(AppLocale.otpVerification.getString(context)
                        , style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
          
                      SizedBox(
                          height:  height(context)*0.03
                      ),
          
                      SizedBox(
                        width: 284,
                        child: Text.rich(
                          TextSpan(
                            children: [
                               TextSpan(
                                text: AppLocale.enterYourOTPSentToYourPhone.getString(context),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: widget.phoneNumber,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
          
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
          
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    // obscureText: true,
                                    // obscuringCharacter: '*',
                                    // obscuringWidget: const Icon(Icons.star,
                                    //   size: 24,
                                    // ),
                                    // blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v!.length < 6) {
                                        return "Enter 6 digit code";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: hasError ? Colors.red : Colors.white,
                                      activeColor: grey6,
                                      inactiveFillColor: Colors.white,
                                      inactiveColor: Colors.white,
                                      selectedColor: Colors.white,
                                      selectedFillColor: Colors.white,

                                    ),
                                    cursorColor: Colors.black,
                                    animationDuration: const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    errorAnimationController: errorController,
                                    controller: verificationCodeController,
                                    keyboardType: TextInputType.number,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],

                                    // onTap: () {
                                    //   print("Pressed");
                                    // },
                                    onChanged: (value) {},
                                    beforeTextPaste: (text) {
                                      debugPrint("Allowing to paste $text");
                                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                      return true;
                                    },
                                  )),
                            ),
                          ),


                        ],),

                      Visibility(
                          visible: isVisible,
                          child: TextButton(onPressed: (){
                            resentCode();
                          }, child: Text(AppLocale.didNotReceivedOTP.getString(context)))),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: CustomButton8(
                      //     text: AppLocale.verifyLater.getString(context),
                      //
                      //     radius: 5,
                      //     backgroundColor: grey6,
                      //     onPressed: (){
                      //       FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
                      //         'verified': false
                      //       }).then((value) {
                      //         // loadingProvider.loginLoading(false);
                      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()));
                      //       });
                      //
                      //     },
                      //   ),
                      // ),
                      Expanded(child:   Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap:  (){
                                FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                  'verified': false
                                }).then((value) {
                                  // loadingProvider.loginLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()));
                                });
          
                              },
                              child: Text(AppLocale.verifyLater.getString(context),style: TextStyle(color: primaryColor),)),
                        ],
                      ),)
                    ],
                  ),
                )),
          
            persistentFooterButtons: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                    child: CustomButton8(
                      text:
                      'Verify', //AppLocalizations.of(context)!.signIn.toString(),
                      onPressed: ()     async {
                        obj.changeShowLoaderValue(true);
                        final credential =PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: verificationCodeController.text.toString());
                        try{
          
                          await FirebaseAuth.instance.currentUser?.linkWithCredential(credential).then((value) {
                            FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
                              'verified': true
                            }).then((value) {
                              obj.changeShowLoaderValue(false);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()));
                            });
          
                          }).onError((error, stackTrace) {
                            obj.changeShowLoaderValue(false);
          
                            Utils.toastMessage(error.toString());
                          });
          
          
          
                        }catch(e){
                          obj.changeShowLoaderValue(false);
          
                          if (kDebugMode) {
                            print(e.toString());
                          }
                        }
          
          
          
          
          
          
          
                      },
                      radius: 5,
                      backgroundColor: primaryColor,
                    ),
                  ),
          
                ],
              ),
            ],
          
          ),
        ),
        LoaderView()
      ],
    );
  }
  bool isVisible = false;
  int secondsRemaining = 60;
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
          isVisible = true; // Make the button visible
        }
      });
    });
  }

  void resentCode(){
    // Call the Firebase Phone Auth API to resend the verification code
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: const Duration(seconds: 60), // Timeout duration
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure (e.g., invalid phone number)
      },
      codeSent: (String verificationId, int? resendToken) {
        // The verification code has been sent to the user
        // Store the verificationId and resendToken for later use
        // You can also update the UI to inform the user
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).then((value) {
      Utils.toastMessage('code resent');
    });
    secondsRemaining = 60;
    isVisible = false;
    startTimer();
  }
}
