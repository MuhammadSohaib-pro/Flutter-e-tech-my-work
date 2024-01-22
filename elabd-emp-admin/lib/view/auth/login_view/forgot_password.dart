import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final resetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(title: 'Forgot Passwor'),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MySize.screenHeight * 0.1,
          ),
          Padding(
            padding: EdgeInsets.all(MySize.size18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Reset Password',
                    style: poppinBold.copyWith(fontSize: MySize.size14),
                  ),
                ),
                SizedBox(
                  height: MySize.size20,
                ),
                TextFieldWidget(
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    keyBoadType: TextInputType.emailAddress,
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
                    controller: resetEmailController,
                    hintText: 'Type your register Email'),
                SizedBox(
                  height: MySize.size50,
                ),


                // MaterialButton(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(MySize.size10)),
                //   height: MySize.size56,
                //   color: primaryColor,
                //   onPressed: () {
                //     if (resetEmailController.text.isEmpty) {
                //       getFlushBar(context,
                //           title: 'Please provide a reset password');
                //     } else {}
                //   },
                //   child: Text(
                //     'Reset Password',
                //     style: poppinMedium.copyWith(
                //         fontSize: MySize.size20, color: whiteColor),
                //   ),
                // ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MySize.size16),
                  child: ButtonWidget(
                    title: 'Reset Password',
                    ontap: () async {
                      if (resetEmailController.text.isEmpty) {
                        getFlushBar(context, title: 'Please provide an email');
                      } else {
                        SmartDialog.showLoading();
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: resetEmailController.text.trim())
                              .then((value) {
                            getFlushBar(context,
                                title: 'Password reset email has sent');
                            SmartDialog.dismiss();
                          });
                        } on FirebaseException catch (e) {
                          SmartDialog.dismiss();
                          print(e);
                          getFlushBar(context, title: 'Error ${e.toString()}');
                        }

                        // await authProvider
                        //     .resetPasswor(
                        //         context: context,
                        //         email: emailController.text.toString())
                        // .then((value) {});
                      }
                    },
                    fontSize: MySize.size14,
                  ),
                ),
                SizedBox(
                  height: MySize.size10,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
