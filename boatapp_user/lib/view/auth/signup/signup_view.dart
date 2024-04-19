import 'package:boat_app/view/auth/signin/provider/obsecure_provider.dart';
import 'package:boat_app/view/auth/signup/provider/signup_obscure_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../custom_widgets/loader_view.dart';
import '../../../custom_widgets/scrollable_column.dart';
import '../../../languages/LocaleString.dart';
import '../../../provider/loader_view_provider.dart';
import '../../../provider/loading_provider/loading_provider.dart';
import '../../../utils/MySize.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_function.dart';
import '../../../utils/utils.dart';
import '../OTP verification/OTP_verification.dart';
import '../auth_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var Ccode;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin() {

    //initializing provider for showing loading when needed
    final obj = Provider.of<LoaderViewProvider>(context,
        listen: false);

    obj.changeShowLoaderValue(false);

    //verifying phone number
    _auth
        .verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: Ccode +
            phoneController.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {

          Utils.toastMessage(e.toString());
          if (kDebugMode) {
            print(e.toString());
          }
          obj.changeShowLoaderValue(false);
        },
        codeSent: (String verification, int? token) {
          if (kDebugMode) {
            print(phoneController);
          }
          obj.changeShowLoaderValue(false);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPVerification(
                    verificationId: verification,
                    phoneNumber: Ccode+
                        phoneController.text,
                  )));
          if (kDebugMode) {
            print(phoneController);
          }
        },
        codeAutoRetrievalTimeout: (e) {
          obj.changeShowLoaderValue(false);

          if (kDebugMode) {
            print(e.toString());
          }
        })
        .onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      obj.changeShowLoaderValue(false);
    });
  }
  final FlutterLocalization localization = FlutterLocalization.instance;

  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  void _submitForm() async{

    //initializing provider for showing loading when needed
    final obj = Provider.of<LoaderViewProvider>(context,
        listen: false);

    //if condition for checking if validators checking
    if (_signUpKey.currentState!.validate()) {
      // Form is valid, perform login or other actions
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;
      String name = _nameController.text;
      String phonee = Ccode+
          phoneController.text;

     if(password == confirmPassword){
       //internet check here
       bool isConnected = await Utils.checkInternetConnection();
       if(isConnected == true){

         //this line of code starts the loading
         obj.changeShowLoaderValue(true);

         //check if phone is already in use or not
         bool? isUsed = await isPhoneNumberUsed(phonee);
         if(isUsed == false){
           final UserCredential? userCredential = await _authService.signUpWithEmail(context,email, password);
           if (userCredential != null) {
             // Authentication successful, navigate to the next screen
             _authService.setData(email,name , 'email',phonee).then((value) {
               isLogin();


             });      } else {
             //this line of code stops the loading
             obj.changeShowLoaderValue(false);



           }
         }else{
           //this line of code stops the loading
           obj.changeShowLoaderValue(false);
           Utils.toastMessage('Phone number is already used');
         }


       }
       else{
         showNoInternetDialog(
             context
         );
       }
     }else{
       Utils.authErrorSnackbar(context, 'Password miss match', 'Your password does not match');

     }

      // Perform login logic here
      if (kDebugMode) {
        print('Login with Email: $email, Password: $password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: bgColor,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocale.register.getString(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [

              //text button to navigate to sign in screen
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                child: Text(
                  AppLocale.signIn.getString(context),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ScrollableColumn(
              children: [
                SizedBox(height: MySize.size40),

                      Form(
                    key: _signUpKey,
                    child: Column(
                      children: [



                        //Consumer widget used for managing the obsecuring of password in both textfields
                        Consumer<SignUpObscureProvider>(
                          builder: (context, p, child) =>   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //custom textfield for name
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: _nameController,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                hintText:     AppLocale.fullName.getString(context),
                                // AppLocalizations.of(context)!
                                //     .fullName
                                //     .toString(),
                                fillColor: fillColor,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(value,context,'name');
                                },
                              ),
                            ),
                            SizedBox(height: MySize.size12),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: _emailController,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                hintText:
                                AppLocale.email.getString(context),
                                fillColor: fillColor,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(value,context,'email');
                                },
                              ),
                            ),

                            //custom textfield for email
                            SizedBox(height: MySize.size12),
                            // SizedBox(height: MySize.size12),

                            //custom textfield for phone
                            ///
                            // Padding(
                            //   padding: Spacing.horizontal(MySize.size32),
                            //   child: CountryFlagNumberTextField(
                            //     controller: phoneController,
                            //     // autoValidateMode:
                            //     // AutovalidateMode.onUserInteraction,
                            //     keyboardType: TextInputType.text,
                            //     hintText: 'Contact',
                            //     // AppLocalizations.of(context)!
                            //     //     .contact
                            //     //     .toString(),
                            //     // fillColor: fillColor,
                            //     validator: (value) {
                            //       return CommonFunctions.validateTextField(value,context,'phone');
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: IntlPhoneField(


                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: ( value) {
                                  // Implement your validation logic here
                                  if ( value!.number.length< 1) {
                                    return AppLocale.enterPhone.getString(context);
                                  }
                                  else if(value.completeNumber.length < 10){
                                    return 'Enter a valid phone number';

                                  }

                                  // Add your specific validation rules, e.g., checking for specific patterns or lengths

                                  return null; // Return null if validation passes
                                },
                                initialCountryCode: 'SA',
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                style: const TextStyle(color: Colors.black, fontSize: 14),
                                disableLengthCheck: false,
                                showCursor: false,

                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(13, 15, 13, 17),
                                  prefixIcon: const Icon(Icons.phone,),
                                  hintText:               AppLocale.phoneNumber.getString(context),
                                  hintStyle: const TextStyle(color:Color(0xff9FA5C0),fontSize:14),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0.5, color: greyText),
                                    borderRadius: BorderRadius.circular(5),

                                    // borderSide: const BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular( 5),
                                      borderSide:  BorderSide(color: primaryColor, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(color: Colors.redAccent, width: 1)

                                    // borderSide: BorderSide(color: appColor1, width: 3)
                                  ),


                                ),
                                onChanged: (phone) {
                                  Ccode = phone.countryCode;

                                },

                              ),
                            ),
                            SizedBox(height: MySize.size12),
                            //custom textfield for password

                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: _passwordController,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                hintText:               AppLocale.enterPassword.getString(context),

                                // AppLocalizations.of(context)!
                                //     .createPassword
                                //     .toString(),
                                fillColor: fillColor,
                                sufixIcon: p.obsecureText1
                                    ? GestureDetector(
                                  onTap: () {
                                    p.setObsecureText1(!p.obsecureText1);
                                  },
                                  child: const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                )
                                    : GestureDetector(
                                  onTap: () {
                                    p.setObsecureText1(!p.obsecureText1);
                                  },
                                  child: const Icon(
                                    Icons.visibility_off_outlined,
                                    color: greyText,
                                  ),
                                ),
                                obscureText: p.obsecureText1,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(value,context,'password');
                                },
                              ),
                            ),
                            // SizedBox(height: MySize.size8),
                            // SizedBox(
                            //   child: Padding(
                            //     padding: Spacing.horizontal(MySize.size35),
                            //     child: const Row(
                            //       children: [
                            //         Expanded(
                            //           child: Text(
                            //             'Confirm password',
                            //             // AppLocalizations.of(context)!
                            //             //     .passwordDetail
                            //             //     .toString(),
                            //             style: TextStyle(
                            //               color: grey1,
                            //               fontSize: 10,
                            //               fontWeight: FontWeight.w400,
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: MySize.size10),

                            //custom textfield for confirm password
                            Padding(
                              padding: Spacing.horizontal(MySize.size32),
                              child: CustomTextField13(
                                controller: _confirmPasswordController,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                hintText:               AppLocale.confirmPassword.getString(context),

                                // AppLocalizations.of(context)!
                                //     .confirmPassword
                                //     .toString(),
                                fillColor: fillColor,
                                sufixIcon: p.obsecureText2
                                    ? GestureDetector(
                                  onTap: () {
                                    p.setObsecureText2(!p.obsecureText2);
                                  },
                                  child: const Icon(
                                    Icons.visibility_outlined,
                                    color: greyText,
                                  ),
                                )
                                    : GestureDetector(
                                  onTap: () {
                                    p.setObsecureText2(!p.obsecureText2);
                                  },
                                  child: const Icon(
                                    Icons.visibility_off_outlined,
                                    color: greyText,
                                  ),
                                ),
                                obscureText: p.obsecureText2,
                                validator: (value) {
                                  return CommonFunctions.validateTextField(value,context, 'password' );
                                },
                              ),
                            ),
                          ],
                        ),),
                        // Padding(
                        //   padding: const EdgeInsets.all(32),
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text('Password not matched')),
                        // ),
                      ],
                    ),

                ),
                SizedBox(height: MySize.size30),

                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  //custom button for signup

                  child: CustomButton8(
                    text:
                    AppLocale.signUp.getString(context),
                    backgroundColor:primaryColor,
                    textColor: bgColor,
                    radius: 5,
                    onPressed: () async {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> OTPVerification(verificationId: '', phoneNumber: phoneController.text,)));
                      //used this method to keep all signup functionality out of widget tree
                      _submitForm();
                      print(phoneController.text);
                      print(Ccode);

                      ///
                      // final obj =
                      //     Provider.of<AppLanguage>(context, listen: false);
                      // obj.changeShowLoaderValue(true);
                      // if (_signUpKey.currentState!.validate()) {
                      //   if (passwordController.text ==
                      //       confirmPasswordController.text) {
                      //     String text = await p.signUpWithEmailPassword(
                      //         emailController.text, passwordController.text);
                      //     if (text == "success") {
                      //       FirebaseAuth auth = FirebaseAuth.instance;
                      //       FirebaseFirestore.instance
                      //           .collection("Users")
                      //           .doc(auth.currentUser!.uid)
                      //           .set(
                      //         {
                      //           "id": auth.currentUser!.uid,
                      //           "fullname": fullnameController.text,
                      //           "email": emailController.text,
                      //           "contact": contactController.text,
                      //           "password": passwordController.text,
                      //           "image": ""
                      //         },
                      //       );
                      //       obj.changeShowLoaderValue(false);
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) =>
                      //               const BottomNavBarView(),
                      //         ),
                      //       );
                      //       fullnameController.clear();
                      //       passwordController.clear();
                      //       confirmPasswordController.clear();
                      //       emailController.clear();
                      //       contactController.clear();
                      //     } else {
                      //       obj.changeShowLoaderValue(false);
                      //       CommonFunctions.flushBarErrorMessage(
                      //           "Error Occured", context);
                      //     }
                      //   } else {
                      //     obj.changeShowLoaderValue(false);
                      //     CommonFunctions.flushBarErrorMessage(
                      //         "Password did not match", context);
                      //   }
                      // } else {
                      //   obj.changeShowLoaderValue(false);
                      //   CommonFunctions.flushBarErrorMessage(
                      //       AppLocalizations.of(context)!
                      //           .fieldRequired
                      //           .toString(),
                      //       context);
                      // }
                    },
                  ),
                  // Consumer<SignUpProvider>(
                  //   builder: (context, p, child) =>
                  //       CustomButton8(
                  //     text:'Sign Up',
                  //     // AppLocalizations.of(context)!.signUp.toString(),
                  //     backgroundColor:mainColor,
                  //     textColor: bgColor,
                  //     radius: 30,
                  //     onPressed: () async {
                  //       // final obj =
                  //       //     Provider.of<AppLanguage>(context, listen: false);
                  //       // obj.changeShowLoaderValue(true);
                  //       // if (_signUpKey.currentState!.validate()) {
                  //       //   if (passwordController.text ==
                  //       //       confirmPasswordController.text) {
                  //       //     String text = await p.signUpWithEmailPassword(
                  //       //         emailController.text, passwordController.text);
                  //       //     if (text == "success") {
                  //       //       FirebaseAuth auth = FirebaseAuth.instance;
                  //       //       FirebaseFirestore.instance
                  //       //           .collection("Users")
                  //       //           .doc(auth.currentUser!.uid)
                  //       //           .set(
                  //       //         {
                  //       //           "id": auth.currentUser!.uid,
                  //       //           "fullname": fullnameController.text,
                  //       //           "email": emailController.text,
                  //       //           "contact": contactController.text,
                  //       //           "password": passwordController.text,
                  //       //           "image": ""
                  //       //         },
                  //       //       );
                  //       //       obj.changeShowLoaderValue(false);
                  //       //       Navigator.push(
                  //       //         context,
                  //       //         MaterialPageRoute(
                  //       //           builder: (context) =>
                  //       //               const BottomNavBarView(),
                  //       //         ),
                  //       //       );
                  //       //       fullnameController.clear();
                  //       //       passwordController.clear();
                  //       //       confirmPasswordController.clear();
                  //       //       emailController.clear();
                  //       //       contactController.clear();
                  //       //     } else {
                  //       //       obj.changeShowLoaderValue(false);
                  //       //       CommonFunctions.flushBarErrorMessage(
                  //       //           "Error Occured", context);
                  //       //     }
                  //       //   } else {
                  //       //     obj.changeShowLoaderValue(false);
                  //       //     CommonFunctions.flushBarErrorMessage(
                  //       //         "Password did not match", context);
                  //       //   }
                  //       // } else {
                  //       //   obj.changeShowLoaderValue(false);
                  //       //   CommonFunctions.flushBarErrorMessage(
                  //       //       AppLocalizations.of(context)!
                  //       //           .fieldRequired
                  //       //           .toString(),
                  //       //       context);
                  //       // }
                  //     },
                  //   ),
                  // ),
                ),
                SizedBox(height: MySize.size50),
                // Text(
                //   AppLocalizations.of(context)!.or.toString(),
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: ThemeColors.grey1,
                //     fontSize: MySize.size10,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // SizedBox(height: MySize.size20),
                // Consumer<SignUpProvider>(
                //   builder: (context, p, child) => Platform.isIOS
                //       ? Padding(
                //           padding: Spacing.horizontal(MySize.size32),
                //           child: CustomSocialButton(
                //             text: AppLocalizations.of(context)!
                //                 .signUpwithApple
                //                 .toString(),
                //             backgroundColor: Colors.black,
                //             textColor: ThemeColors.bgColor,
                //             image: icApplelogo,
                //             onPressed: () {},
                //           ),
                //         )
                //       : Padding(
                //           padding: Spacing.horizontal(MySize.size32),
                //           child: CustomSocialButton(
                //             text: AppLocalizations.of(context)!
                //                 .signUpwithGoogle
                //                 .toString(),
                //             backgroundColor: ThemeColors.fillColor,
                //             textColor: ThemeColors.mainColor,
                //             image: icGoogleLogo,
                //             onPressed: () {},
                //           ),
                //         ),
                // ),
                // SizedBox(height: MySize.size30),
              ],
            ),
          ),
        ),

        // this a reusable widget used for showing loading
        const LoaderView(),
      ],
    );
  }
}
