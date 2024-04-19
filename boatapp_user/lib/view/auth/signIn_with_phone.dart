import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/provider/loading_provider/loading_provider.dart';
import 'package:boat_app/utils/utils.dart';
import 'package:boat_app/view/auth/auth_controller.dart';
import 'package:boat_app/view/auth/signin/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/app_button.dart';
import '../../languages/LocaleString.dart';
import '../../utils/sized_box.dart';
import '../../utils/textstyles.dart';
import 'OTP verification/OTP_verification.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  TextEditingController phoneController = TextEditingController();
  var Ccode;
  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin() {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.loginLoading(true);

    _auth
        .verifyPhoneNumber(
            phoneNumber: Ccode + phoneController.text,
            verificationCompleted: (_) {},
            verificationFailed: (e) {
              Utils.toastMessage(e.toString());
              if (kDebugMode) {
                print(e.toString());
              }
              loadingProvider.loginLoading(false);
            },
            codeSent: (String verification, int? token) {
              if (kDebugMode) {
                print(phoneController);
              }
              FirebaseFirestore.instance
                  .collection('User')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'phone': Ccode + phoneController.text}).then(
                      (value) {
                loadingProvider.loginLoading(false);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPVerification(
                              from: 'phone',
                              verificationId: verification,
                              phoneNumber: Ccode + phoneController.text,
                            )));
              }).onError((error, stackTrace) {
                Utils.toastMessage(error.toString());
              });

              if (kDebugMode) {
                print(phoneController);
              }
            },
            codeAutoRetrievalTimeout: (e) {
              loadingProvider.loginLoading(false);

              if (kDebugMode) {
                print(e.toString());
              }
            })
        .onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      loadingProvider.loginLoading(false);
    });
  }

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height(context) * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back_Arrow(
              //   ontap: () {
              //     loadingProvider.loginLoading(false);
              //    authService.signOut().then((value) {
              //                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginView()));
              //                   });
              //   },
              // ),
              IconButton(
                  onPressed: () {
                    authService.signOut().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios)),

              SizedBox(
                height: height(context) * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocale.verifyYourPhone.getString(context),
                      style: text23600,
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    Text(
                      AppLocale.pleaseEnterPhoneNumberHere.getString(context),
                      style: text14500,
                    ),
                    SizedBox(
                      height: height(context) * 0.05,
                    ),
                    IntlPhoneField(
                      // validator: _validatePhone,
                      initialCountryCode: 'SA',
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                        hintText: 'Enter phone number',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          // borderSide: const BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          // borderSide: BorderSide(color: appColor1, width: 3)
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          // borderSide: BorderSide(color: appColor1, width: 3)
                        ),
                      ),
                      onChanged: (phone) {
                        Ccode = phone.countryCode;
                      },
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    Consumer<LoadingProvider>(
                      builder: (context, value, child) {
                        return AppButton(
                            loading: loadingProvider.loading,
                            onPressed: () async {
                              if (kDebugMode) {
                                print(phoneController.text);
                              }
                              bool isConnected =
                                  await Utils.checkInternetConnection();
                              if (isConnected == true) {
                                if (phoneController.text.isEmpty) {
                                  if (kDebugMode) {
                                    print('hello');
                                  }
                                  Utils.toastMessage('Enter Phone Number');
                                } else {
                                  isLogin();
                                }
                              } else {
                                loadingProvider.loginLoading(false);
                                showImageDialog(context);
                              }
                              // if(phoneController.text.length < 4 || phoneController.text != null){
                              //   isLogin();
                              // }else{
                              //   Utils.toastMessage('Enter Phone Number');
                              // }
                            },
                            text: AppLocale.sendOTP.getString(context));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No internet connection'),
        content:
            const Text('Please check your internet connection and try again.'),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
