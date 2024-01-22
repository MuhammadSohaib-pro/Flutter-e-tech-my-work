import 'package:flutter/material.dart';

import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/background_widget.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';
import 'package:nawaz_salon/widgets/custom_textfields.dart';

class AccountRequestView extends StatefulWidget {
  const AccountRequestView({super.key});

  @override
  State<AccountRequestView> createState() => _AccountRequestViewState();
}

class _AccountRequestViewState extends State<AccountRequestView> {
  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  height: 74,
                  width: 74,
                  decoration: const ShapeDecoration(
                    color: ThemeColors.grey2,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 28,
                      color: ThemeColors.bgColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(33, 50, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Shop Name",
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
                  padding: const EdgeInsets.fromLTRB(33, 20, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Owner Name",
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
                  padding: const EdgeInsets.fromLTRB(33, 20, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
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
                  padding: const EdgeInsets.fromLTRB(33, 20, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Contact",
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
                  padding: const EdgeInsets.fromLTRB(33, 20, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Shop Address",
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
                  padding: const EdgeInsets.fromLTRB(33, 20, 33, 20),
                  child: CustomTextField13(
                    // controller: email,
                    hintText: "Description",
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    fillColor: Colors.transparent,
                    maxLines: 5,
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
                  padding: const EdgeInsets.fromLTRB(33, 40, 33, 30),
                  child: CustomButton8(
                    text: "Submit",
                    onPressed: () {},
                    backgroundColor: ThemeColors.yellow,
                    textColor: ThemeColors.bgColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Container(
//   clipBehavior: Clip.antiAlias,
//   decoration: const BoxDecoration(
//      image: DecorationImage(
//          image: AssetImage(background),
//          alignment: Alignment.bottomRight,
//      ),
//   ),
// ),