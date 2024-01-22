
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/screens/forgot_password/forgot-password_screen.dart';
import 'package:elabd_tms_app/services/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_field.dart';
import '../../constants/constants.dart';
import '../../services/auth_services.dart';
import '../home/custom_bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var countryCode;
  bool _obscureText = true;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void updateDeviceToken() async {
    NotificationServices firebaseMessaging = NotificationServices();
    String? deviceToken = await firebaseMessaging.getDeviceToken();

    if (deviceToken != null) {
      FirebaseFirestore.instance
          .collection('employees')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {'fcmToken': deviceToken},
        SetOptions(merge: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServiceProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 275.w,
                            height: 200.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/login_img.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Welcome Back!',
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.w, right: 20.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10).r,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: CustomTextField(
                                hinttext: "Enter Your Email",
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 6 * width),
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 20.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4)
                                            .r,
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      controller: passwordController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the border
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.sp),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          child: Icon(
                                            _obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(const ForgotPasswordScreen());
                                  },
                                  child: CustomText(
                                    text: 'Forgot Password',
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              width: 275.w,
                              height: 55.h,
                              textColor: Colors.white,
                              color: const Color(0xff065F14),
                              text: 'Sign in',
                              onPressed: () async {
                                // login(context)
                                // String email = emailController.text;
                                // String password = passwordController.text;
                                // if (loginFormKey.currentState!.validate()) {
                                //   bool signInSuccessful = await authProvider
                                //       .signIn(email, password);
                                //   log("signInSuccessful $signInSuccessful");
                                //   if (signInSuccessful) {
                                //     // updateDeviceToken();
                                //     log("$signInSuccessful",
                                //         name: "signInSuccessful");
                                //     updateDeviceToken();
                                //     // ignore: use_build_context_synchronously
                                //     Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const CustomizedBottomNavigationBar(),
                                //       ),
                                //     );
                                //     getIt<SharedPreferencesModel>()
                                //         .setLoginStatus(true);
                                //   } else {
                                //     Fluttertoast.showToast(
                                //         msg:
                                //             "User does not exit or invalid email or password");
                                //   }
                                // } else {
                                //   Fluttertoast.showToast(
                                //       msg: "Please Fill All Fields");
                                // }

                                _login(context);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // CustomButton(
                            //     width: 275.w,
                            //     height: 55.h,
                            //     textColor: primaryColor,
                            //     color: const Color(0xffEAEAEA),
                            //     text: 'Biometric Sign in',
                            //     onPressed: () {})
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // print(user.email);
        DocumentSnapshot employeeSnapshot =
            await firestore.collection('employees').doc(user.uid).get();
        Map<String, dynamic>? employeeData =
            employeeSnapshot.data() as Map<String, dynamic>?;
        print(employeeData);
        if (employeeSnapshot.exists) {
          Map<String, dynamic>? employeeData =
              employeeSnapshot.data() as Map<String, dynamic>?;
          print(employeeData);
          if (employeeData != null && employeeData['role'] == 'user') {
            debugPrint(employeeData['name']);
            // User is an admin, proceed with app access
            debugPrint(" ------------------------- ${employeeData['id']}");
            debugPrint('User is an User. Logging in...');
            updateDeviceToken();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                         CustomizedBottomNavigationBar()));
            // ignore: use_build_context_synchronously
            Fluttertoast.showToast(
              msg: 'Login Successfully',
            );
          } else {
            // User is not an admin, deny access
            if (employeeData!['role'] == 'Admin') {
              Fluttertoast.showToast(
                  msg: 'Error: Admin cannot login to user app.');
            }
          }
        } else {
          // User not found in employees collection
          // ignore: use_build_context_synchronously
          Fluttertoast.showToast(msg: 'Error: User not found. ----------');
        }
      } else {
        // Handle error
        // ignore: use_build_context_synchronously
        Fluttertoast.showToast(
            msg: 'Error: User not found or incorrect credentials.');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}
