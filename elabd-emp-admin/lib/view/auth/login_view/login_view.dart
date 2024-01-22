import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/auth/login_view/forgot_password.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/internet_check.dart';
import '../../../services/notification_services.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});

  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> obsecureText = ValueNotifier<bool>(true);
  final formkey = GlobalKey<FormState>();
  void updateDeviceToken() async {
    NotificationServices firebaseMessaging = NotificationServices();
    String? deviceToken = await firebaseMessaging.getDeviceToken();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('employees').doc(user!.uid).update({
      'fcmToken': deviceToken,
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppIcons.login,
                  height: MySize.screenHeight * 0.4,
                  width: MySize.screenWidth,
                ),
              ),
              SizedBox(
                height: MySize.size5,
              ),
              Text(
                'Welcome Back!',
                style: poppinMedium.copyWith(fontSize: MySize.size24),
              ),
              SizedBox(
                height: MySize.size15,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                          keyBoadType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return '';
                          },
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(
                              MySize.size15,
                            ),
                            child: const Icon(
                              Icons.email,
                              color: blackColor,
                            ),
                            // child: ImageIcon(
                            //   const AssetImage(
                            //     AppIcons.email,
                            //   ),
                            //   size: MySize.size20,
                            //   color: blackColor,
                            // ),
                          ),
                          controller: emailController,
                          hintText: 'Type your email'),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      ValueListenableBuilder(
                        valueListenable: obsecureText,
                        builder: (context, value, child) {
                          return TextFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '';
                                }
                                return '';
                              },
                              isObsecure: obsecureText.value,
                              sufixIcon: GestureDetector(
                                onTap: () {
                                  obsecureText.value = !obsecureText.value;
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(MySize.size20),
                                  child: Image.asset(
                                    height: MySize.size20,
                                    width: MySize.size20,
                                    color: lightGrey,
                                    obsecureText.value
                                        ? AppIcons.eyeoff
                                        : AppIcons.eye,
                                  ),
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(
                                  MySize.size15,
                                ),
                                child: ImageIcon(
                                  const AssetImage(
                                    AppIcons.password,
                                  ),
                                  size: MySize.size20,
                                  color: blackColor,
                                ),
                              ),
                              keyBoadType: TextInputType.text,
                              controller: passwordController,
                              hintText: 'Type password');
                        },
                      ),
                      
                      
                      SizedBox(
                        height: MySize.size12,
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
                child: Padding(
                  padding: EdgeInsets.all(MySize.size4),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Password',
                      style: poppinMedium.copyWith(
                          color: lightGrey, fontSize: MySize.size12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MySize.size15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size30),
                child: ButtonWidget(
                  title: 'Sign in',
                  fontSize: MySize.size19,
                  ontap: () async {
                    if (emailController.text.isEmpty) {
                      getFlushBar(context, title: 'Please provide email');
                    } else if (passwordController.text.isEmpty) {
                      getFlushBar(context, title: 'Please provide password');
                    } else {
                      bool isConnected = await checkInternetConnection();
                      if (isConnected) {
                        await _login(context).then((value) {
                          updateDeviceToken();
                        });
                      } else {
                        showNoInternetDialog(context);
                      }
                    }
                    // // if (formkey.currentState!.validate()) {}
                    // if (emailController.text.isEmpty) {
                    //   getFlushBar(context, title: 'Email is Required');
                    // } else if (passwordController.text.isEmpty) {
                    //   getFlushBar(context, title: 'Password is Required');
                    // } else {
                    //   bool loginSuccess = await authProvider.signIn(
                    //       // email: emailController.text,
                    //       // password: passwordController.text,
                    //       email: 'rafii@gmail.com',
                    //       password: '12345678',
                    //       context: context);
                    //   if (loginSuccess) {
                    //     updateDeviceToken();
                    //     SmartDialog.dismiss();
                    //     // ignore: use_build_context_synchronously
                    //     Navigator.pushReplacementNamed(
                    //         context, bottomNavigation);
                    //   } else {
                    //     SmartDialog.dismiss();
                    //     // ignore: use_build_context_synchronously
                    //     getFlushBar(context,
                    //         title: 'Erro while sign in a Admin');
                    //   }
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _login(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      SmartDialog.showLoading();
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Successfully authenticated, now check user's role in Firestore
        DocumentSnapshot employeeSnapshot =
            await firestore.collection('employees').doc(user.uid).get();
        if (employeeSnapshot.exists) {
          Map<String, dynamic>? employeeData =
              employeeSnapshot.data() as Map<String, dynamic>?;
          if (employeeData != null && employeeData['role'] == 'Admin') {
            // User is an admin, proceed with app access
            SmartDialog.dismiss();
            debugPrint('User is an admin. Logging in...');
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarView(
                          index: 0,
                        )));
            // ignore: use_build_context_synchronously
            getFlushBar(context,
                title: 'Login Successfully',
                color: primaryColor,
                isSuccess: true);
          } else {
            // User is not an admin, deny access
            SmartDialog.dismiss();
            getFlushBar(context, title: 'Error: User is not an admin.');
          }
        } else {
          // User not found in employees collection
          // ignore: use_build_context_synchronously
          SmartDialog.dismiss();
          getFlushBar(context, title: 'Error: User not found.');
        }
      } else {
        // Handle error
        SmartDialog.dismiss();
        // ignore: use_build_context_synchronously
        getFlushBar(context,
            title: 'Error: User not found or incorrect credentials.');
      }
    } catch (e) {
      SmartDialog.dismiss();
      getFlushBar(context, title: 'Error: $e');
    }
  }

  // Future<void> resetPasswordDialog(
  //     BuildContext context, AuthProvider authProvider) async {
  //   return showDialog<void>(
  //     context: context,
  //     // barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         // insetPadding: EdgeInsets.zero,
  //         backgroundColor: whiteColor,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(MySize.size8)),
  //         child: Container(
  //           decoration: ShapeDecoration(
  //               color: whiteColor,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(MySize.size8))),
  //           child: SingleChildScrollView(
  //             child: Padding(
  //               padding: EdgeInsets.all(MySize.size18),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     'Reset Password',
  //                     style: poppinMedium,
  //                   ),
  //                   SizedBox(
  //                     height: MySize.size8,
  //                   ),
  //                   TextFieldWidget(
  //                       keyBoadType: TextInputType.emailAddress,
  //                       prefixIcon: Padding(
  //                         padding: EdgeInsets.all(
  //                           MySize.size15,
  //                         ),
  //                         child: const Icon(
  //                           Icons.email,
  //                           color: blackColor,
  //                         ),
  //                         // child: ImageIcon(
  //                         //   const AssetImage(
  //                         //     AppIcons.email,
  //                         //   ),
  //                         //   size: MySize.size20,
  //                         //   color: blackColor,
  //                         // ),
  //                       ),
  //                       controller: resetEmailController,
  //                       hintText: 'Enter your register Email'),
  //                   SizedBox(
  //                     height: MySize.size50,
  //                   ),
  //                   // MaterialButton(
  //                   //   shape: RoundedRectangleBorder(
  //                   //       borderRadius: BorderRadius.circular(MySize.size10)),
  //                   //   height: MySize.size56,
  //                   //   color: primaryColor,
  //                   //   onPressed: () {
  //                   //     if (resetEmailController.text.isEmpty) {
  //                   //       getFlushBar(context,
  //                   //           title: 'Please provide a reset password');
  //                   //     } else {}
  //                   //   },
  //                   //   child: Text(
  //                   //     'Reset Password',
  //                   //     style: poppinMedium.copyWith(
  //                   //         fontSize: MySize.size20, color: whiteColor),
  //                   //   ),
  //                   // ),
  //                   Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: MySize.size16),
  //                     child: ButtonComp(
  //                       title: 'Reset Password',
  //                       onTap: () async {
  //                         if (resetEmailController.text.isEmpty) {
  //                           getFlushBar(context,
  //                               title: 'Please provide an email');
  //                         } else {
  //                           try {
  //                             await FirebaseAuth.instance
  //                                 .sendPasswordResetEmail(
  //                                     email: resetEmailController.text.trim())
  //                                 .then((value) {
  //                               getFlushBar(context,
  //                                   title: 'Password reset email has sent');
  //                             });
  //                           } on FirebaseException catch (e) {
  //                             print(e);
  //                             getFlushBar(context,
  //                                 title: 'Error ${e.toString()}');
  //                           }
  //                           // await authProvider
  //                           //     .resetPasswor(
  //                           //         context: context,
  //                           //         email: emailController.text.toString())
  //                           // .then((value) {});
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: MySize.size10,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
