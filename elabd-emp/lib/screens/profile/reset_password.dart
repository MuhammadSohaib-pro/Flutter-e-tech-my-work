import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:elabd_tms_app/components/custom_button.dart';
import 'package:elabd_tms_app/providers/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../components/text_field_widget.dart';
import '../../constants/colors.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PickImage authProvider = Provider.of<PickImage>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset Password',
        textColor: black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          TextFieldWidget(
              prefixIcon: const Padding(
                padding: EdgeInsets.all(
                  15,
                ),
                child: Icon(Icons.email),
              ),
              controller: emailController,
              hintText: 'Enter your Email'),
          const SizedBox(
            height: 40,
          ),
          CustomButton(
            color: primaryColor,
            height: 50,
            textColor: white,
            text: 'Reset Password',
            fontSize: 16,
            width: MediaQuery.of(context).size.width * 0.8,
            onPressed: () async {
              if (emailController.text.isEmpty) {
                Fluttertoast.showToast(msg: "Email is requied");
              } else {
                await authProvider
                    .resetPasswor(
                        context: context,
                        email: emailController.text.toString())
                    .then((value) {
                  emailController.clear();
                });
              }
            },
          )
        ]),
      ),
    );
  }
}
