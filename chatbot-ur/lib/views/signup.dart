import 'package:chatbot/constants/colors.dart';
import 'package:chatbot/constants/sizeconf.dart';
import 'package:chatbot/constants/sizeconfig.dart';
import 'package:chatbot/views/login.dart';
import 'package:chatbot/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MySize.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up to Chat',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: MySize.size32),
            ),
            Text(
              'Please fill your detail to access your account.',
              style: TextStyle(fontSize: MySize.size14),
            ),
            SizedBox(
              height: MySize.size50,
            ),
            Text(
              'Full Name',
              style: TextStyle(fontSize: MySize.size14),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            CustomTextField13(
              hintText: "Full Name",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: AppColors.whiteColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field is required";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: MySize.size10,
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: MySize.size14),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            CustomTextField13(
              hintText: "Email",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: AppColors.whiteColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field is required";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: MySize.size10,
            ),
            Text(
              'Password',
              style: TextStyle(fontSize: MySize.size14),
            ),
            SizedBox(
              height: MySize.size10,
            ),
            CustomTextField13(
              hintText: "Password",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: AppColors.whiteColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field is required";
                } else {
                  return null;
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 50,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: MySize.size14,
                          color: AppColors.primaryColor),
                    ))
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(width(context), MySize.size50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.white), // Set the text color to white
              ),
            ),
            SizedBox(
              height: height(context) * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: MySize.size14,
                          color: AppColors.primaryColor),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
