import 'package:chatbot/constants/colors.dart';
import 'package:chatbot/constants/sizeconf.dart';
import 'package:chatbot/constants/sizeconfig.dart';
import 'package:chatbot/views/chatpage.dart';
import 'package:chatbot/views/signup.dart';
import 'package:chatbot/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              'Login to Chat',
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
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ChatPage(),
                  ),
                );
              },
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
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: height(context) * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don’t have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
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
