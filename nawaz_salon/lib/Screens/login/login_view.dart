import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/Screens/account_request/account_request_view.dart';
import 'package:nawaz_salon/Screens/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/background_widget.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';
import 'package:nawaz_salon/widgets/custom_textfields.dart';
import 'package:nawaz_salon/widgets/scrollable_column.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
      child: Scaffold(
        body: SafeArea(
          child: ScrollableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 70),
                child: Center(
                  child: SizedBox(
                    width: 181,
                    height: 83,
                    child: SvgPicture.asset(imgLogo),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(33, 0, 0, 5),
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Color(0xFF2A2733),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(33, 0, 0, 20),
                child: Text(
                  'Please Enter Your Details To Login.',
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(33, 40, 33, 20),
                      child: CustomTextField13(
                        controller: email,
                        hintText: "Email",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: Colors.transparent,
                        validator: (value) {
                          if (value == null) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(33, 0, 33, 5),
                      child: CustomTextField13(
                        controller: password,
                        hintText: "Password",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: Colors.transparent,
                        // sufixIcon: const Icon(Icons.visibility_off),
                        // const Icon(Icons.visibility)
                        validator: (value) {
                          if (value == null) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 40, top: 10, bottom: 38),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showCustomBottomSheet(context);
                    },
                    child: const Text(
                      'Forgot Password?',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(33, 0, 33, 20),
                child: CustomButton8(
                  text: "Login",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBarView(),
                        ));
                  },
                  backgroundColor: ThemeColors.yellow,
                  textColor: ThemeColors.bgColor,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountRequestView(),
                        ));
                  },
                  child: const Text(
                    'Request for Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 50),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Terms & Conditions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showCustomBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 250,
                decoration: const BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(33, 40, 33, 40),
                      child: CustomTextField13(
                        // controller: email,
                        hintText: "Email Address",
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: Colors.transparent,
                        validator: (value) {
                          if (value == null) {
                            return "Field is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: CustomButton8(
                        text: "Reset",
                        onPressed: () {},
                        backgroundColor: ThemeColors.yellow,
                        textColor: ThemeColors.bgColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(background),
            //       alignment: Alignment.bottomRight,
            //     ),
            //   ),
            // ),