import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';
import 'package:nawaz_salon/widgets/custom_textfields.dart';
import 'package:nawaz_salon/widgets/scrollable_column.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        toolbarHeight: 100,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: 141,
            height: 64,
            child: SvgPicture.asset(imgLogo),
          ),
        ),
      ),
      body: ScrollableColumn(
        children: [
          Container(
            height: 110,
            width: 110,
            margin: const EdgeInsets.fromLTRB(0, 80, 0, 12),
            decoration: const ShapeDecoration(
              image: DecorationImage(
                  image: AssetImage(imgSettingCircle), fit: BoxFit.fill),
              shape: CircleBorder(),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: ThemeColors.bgColor,
              size: 45,
            ),
          ),
          const Text(
            'NAWAZ SALOON',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.bgColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icEdit),
                const SizedBox(width: 5),
                const Text(
                  'EDIT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.yellow,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(33, 0, 33, 10),
            child: CustomTextField13(
              // controller: email,
              hintText: "Name",
              title: 'Name',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: ThemeColors.fillColor,
              textColor: ThemeColors.bgColor,
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
            padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
            child: CustomTextField13(
              // controller: email,
              hintText: "Email",
              title: 'Email',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: ThemeColors.fillColor,
              textColor: ThemeColors.bgColor,
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
            padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
            child: CustomTextField13(
              // controller: email,
              hintText: "Contact",
              title: 'Contact',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: ThemeColors.fillColor,
              textColor: ThemeColors.bgColor,
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
            padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
            child: CustomTextField13(
              // controller: email,
              hintText: "Address",
              title: 'Address',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: ThemeColors.fillColor,
              textColor: ThemeColors.bgColor,
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
            padding: const EdgeInsets.fromLTRB(33, 10, 33, 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Password",
                    title: 'Password',
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: ThemeColors.fillColor,
                    textColor: ThemeColors.bgColor,
                    obscureText: true,
                    validator: (value) {
                      if (value == null) {
                        return "Field is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Reset',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: CustomButton8(
                  text: "Edit",
                  radius: 10,
                  onPressed: () {},
                  backgroundColor: ThemeColors.yellow,
                  textColor: ThemeColors.bgColor,
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     SizedBox(
          //       height: 40,
          //       width: 100,
          //       child: CustomButton8(
          //         text: "Cancel",
          //         radius: 10,
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         backgroundColor: ThemeColors.darkGrey,
          //         textColor: ThemeColors.bgColor,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 40,
          //       width: 100,
          //       child: CustomButton8(
          //         text: "Save",
          //         radius: 10,
          //         onPressed: () {},
          //         backgroundColor: ThemeColors.yellow,
          //         textColor: ThemeColors.bgColor,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
