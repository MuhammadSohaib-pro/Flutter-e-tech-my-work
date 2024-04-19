import 'dart:io';

import 'package:boat_app/custom_widgets/loader_view.dart';
import 'package:boat_app/languages/LocaleString.dart';
import 'package:boat_app/view/auth/signin/provider/obsecure_provider.dart';
import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:boat_app/view/home/homescreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../custom_widgets/reusablecircle.dart';
import '../../../provider/loader_view_provider.dart';
import '../../../provider/loading_provider/loading_provider.dart';
import '../../../utils/MySize.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_function.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/utils.dart';
import '../auth_controller.dart';
import '../resetPassword/forgot_password.dart';
import '../signup/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthService _authService = AuthService();

  final FlutterLocalization localization = FlutterLocalization.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bgColor,
            elevation: 0.0,
            actions: [
              //Button for going to Sign up screen
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
                child: Text(
                   AppLocale.signUp.getString(context),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            leading: IconButton(onPressed:
   () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            AppLocale.language.getString(context)),
                        content: SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  localization.translate('en');
                                  Navigator.pop(context);
                                },
                                title: const Text("English"),
                              ),
                              ListTile(
                                onTap: () {
                                  localization.translate('ar');
                                  Navigator.pop(context);
                                },
                                title: const Text("Arabic"),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                // Get.find<LocalizationController>().toggleLanguage();
              },

             icon: Icon(Icons.language, color: primaryColor,)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: MySize.size60),
                    SvgPicture.asset(logodark),
                    SizedBox(height: MySize.size15),
                    Text(
                      AppLocale.signIn.getString(context),
                      style: TextStyle(
                        color: black1,
                        fontSize: MySize.size20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocale.enterRegisteredEmailAndPassword.getString(context),
                      style: TextStyle(
                        color: greyText,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MySize.size50),

                    //custom text field here for email
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomTextField13(
                        controller: _emailController,
                        fillColor: fillColor,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText:
                        AppLocale.email.getString(context),
                        keyboardType: TextInputType.emailAddress,
                        radius: 5,
                        validator: (value) => CommonFunctions.validateTextField(
                            value, context, 'email'),
                      ),
                    ),
                    SizedBox(height: MySize.size15),

                    //custom text field here for password
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: Consumer<ObscureProvider>(
                        builder: (context, p, child) {
                          return CustomTextField13(
                            controller: _passwordController,
                            fillColor: fillColor,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText:
                            AppLocale.password.getString(context),
                            keyboardType: TextInputType.text,
                            radius: 5,
                            sufixIcon: p.obsecureText
                                ? GestureDetector(
                                    onTap: () {
                                      p.setObsecureText(!p.obsecureText);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: greyText,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      p.setObsecureText(!p.obsecureText);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: greyText,
                                    ),
                                  ),
                            obscureText: p.obsecureText,

                            validator: (value) =>
                                CommonFunctions.validateTextField(
                                    value, context, 'password'),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: MySize.size8),

                    //Text button here for reset Password

                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ForgotPassword()));
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              AppLocale.resetPassword.getString(context),
                              // AppLocalizations.of(context)!.forgotPassword.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MySize.size15),

                    //Custom button for Sign in
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomButton8(
                        text:
                        AppLocale.signIn.getString(context),
                        onPressed: () {
                          //used this method to keep all login functionality out of widget tree
                          _submitForm();
                        },
                        radius: 5,
                        backgroundColor: primaryColor,
                      ),
                    ),
                    SizedBox(height: MySize.size35),
                    //here are two custom buttons for apple login and google login,
                    // The apple login button will be visible in ios devices while google sign in will be visible in android devices
                    if (Platform.isIOS)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // InkWell(
                          //     onTap: () async {
                          //       // _authService.signOut();
                          //       bool isConnected =
                          //           await Utils.checkInternetConnection();
                          //       if (isConnected == true) {
                          //        _authService.googleLogin(context);
                          //       } else {
                          //         showImageDialog(context);
                          //       }
                          //     },
                          //     child: ReusableCircle(image: google)),
                          InkWell(
                              onTap: () async {
                                bool isConnected =
                                    await Utils.checkInternetConnection();
                                if (isConnected == true) {
                                  _authService.handleAppleSignIn(context);
                                } else {
                                  showNoInternetDialog(context);
                                }
                              },
                              child: ReusableCircleSocial(image: apple)),
                          InkWell(
                              onTap: () async {
                                // _authService.signOut();
                                bool isConnected =
                                await Utils.checkInternetConnection();
                                if (isConnected == true) {
                                  _authService.googleLogin(context);
                                } else {
                                  showNoInternetDialog(context);
                                }
                              },
                              child: ReusableCircleSocial(image: google)),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () async {
                                // _authService.signOut();
                                bool isConnected =
                                    await Utils.checkInternetConnection();
                                if (isConnected == true) {
                                  _authService.googleLogin(context);
                                } else {
                                  showNoInternetDialog(context);
                                }
                              },
                              child: ReusableCircleSocial(image: google)),
                        ],
                      ),

                    //Text button for Continue as guest
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MySize.size30),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomBarScreen()));
                          },
                          child: Text(
                            AppLocale.continueAsGuest.getString(context),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: primaryColor),
                          )),
                    ),

                    //Text button for Continue as guest
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: MySize.size30),
                    //   child: InkWell(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => BottomBarScreen()));
                    //       },
                    //       child: Text(
                    //         'change language(Ar)',//AppLocale.continueAsGuest.getString(context),
                    //         style: TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.w400,
                    //             color: primaryColor),
                    //       )),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),

        // this a reusable widget used for showing loading
        const LoaderView(),
      ],
    );
  }

  void _submitForm() async {
    //initializing provider for showing loading when needed
    final obj = Provider.of<LoaderViewProvider>(context, listen: false);

    //if condition for checking if validators checking
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform login or other actions
      String email = _emailController.text;
      String password = _passwordController.text;

      bool isConnected = await Utils.checkInternetConnection();
      //internet check here


      //this line of code starts the loading
      obj.changeShowLoaderValue(true);

      if (isConnected == true) {
        String? userType = await getUserType(email);
        String? userStatus = await getUserStatus(email);
        bool? userDeleteStatus = await getUserDeleteStatus(email);

        // obj.changeShowLoaderValue(true);

        //check if email is available for user or not
        if (userType == 'User') {
          //check if status of user is active or not
          if (userStatus == 'Activate') {
            //check if user account is deleted or not
            if (userDeleteStatus == false) {
              // try {
                final UserCredential? userCredential = await _authService
                    .signInWithEmail(context, email, password);
                if (userCredential != null) {
                  //this line of code stops the loading
                  obj.changeShowLoaderValue(false);

                  // Authentication successful, navigate to the next screen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomBarScreen()));
                }
              // } catch (e) {
              //   //this line of code stops the loading
              //   // obj.changeShowLoaderValue(false);
              //
              //   if (kDebugMode) {
              //     print('Exception is here bro: $e, Type: ${e.runtimeType}');
              //   }
              //
              //   if (e is FirebaseAuthException) {
              //     // obj.changeShowLoaderValue(false);
              //
              //     String errorMessage = '';
              //     switch (e.code) {
              //       case 'invalid-email':
              //         errorMessage = 'Invalid email address.';
              //         // obj.changeShowLoaderValue(false);
              //
              //         break;
              //       case 'user-not-found':
              //         errorMessage = 'User not found. Please sign up.';
              //         // obj.changeShowLoaderValue(false);
              //
              //         break;
              //       case 'wrong-password':
              //         errorMessage = 'Invalid password.';
              //         // obj.changeShowLoaderValue(false);
              //
              //         break;
              //       // Add more cases as per your requirements
              //       default:
              //         errorMessage =
              //             'An error occurred. Please try again later.';
              //         // obj.changeShowLoaderValue(false);
              //     }
              //     obj.changeShowLoaderValue(false);
              //
              //     // CommonFunctions.loginFailedDialog(
              //     //   context,
              //     //   errorMessage,
              //     //   () {
              //     //     print(obj.showLoader);
              //     //     // obj.changeShowLoaderValue(false);
              //     //     print(obj.showLoader);
              //     //
              //     //     // Navigator.of(context).pop();
              //     //   },
              //     // );
              //     // obj.changeShowLoaderValue(false);
              //   } else {
              //     obj.changeShowLoaderValue(false);
              //     // Handle other types of exceptions or unknown errors
              //   }
              // }
            } else {
              obj.changeShowLoaderValue(false);

              //show the dialog if account is deleted
              Utils.showDeletedDialog(context);
            }
          } else {
            //show the dialog if account is deactivated
            userDeactiveDialog(
                context, 'User is deactivated by admin, Kindly contact admin');
          }
        } else {
          // obj.changeShowLoaderValue(false);

          // User not found or error occurred
          Utils.toastMessage('User not found or error occurred');
          if (kDebugMode) {
            print('User not found or error occurred');
          }
          obj.changeShowLoaderValue(false);
        }
      } else {
        obj.changeShowLoaderValue(false);
        //show the dialog if internet is not available
        showNoInternetDialog(context);
      }
    }
  }

  void userDeactiveDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'User Inactive',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Utils.launchSocialApps('mailto:taimoor00777@gmail.com');
                final loadingProvider =
                    Provider.of<LoadingProvider>(context, listen: false);
                loadingProvider.loginLoading(false);
                Navigator.of(context).pop();
              },
              child: const Text('Contact'),
            ),
            TextButton(
              onPressed: () {
                final loadingProvider =
                    Provider.of<LoadingProvider>(context, listen: false);
                loadingProvider.loginLoading(false);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
  // Widget appleSignInButton() {
  //   return ;
  // }
}
