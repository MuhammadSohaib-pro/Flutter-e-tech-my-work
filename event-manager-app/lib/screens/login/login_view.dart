// ignore_for_file: use_build_context_synchronously

import 'package:event_manager_app/helper/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController forgetPasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    forgetPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: ScrollableColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icLoginLogo),
                SizedBox(height: MySize.size10),
                Text(
                  AppLocalizations.of(context)!.welcomeToBack.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size2),
                Text(
                  AppLocalizations.of(context)!
                      .welcomeBackDescription
                      .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MySize.size25),
                Consumer<LoginProvider>(
                  builder: (context, p, child) => Form(
                    key: _loginKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: emailController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            hintText:
                                AppLocalizations.of(context)!.email.toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size15),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: passwordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .password
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            sufixIcon: p.obsecureText
                                ? InkWell(
                                    onTap: () {
                                      p.setObsecureText(!p.obsecureText);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      p.setObsecureText(!p.obsecureText);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  ),
                            obscureText: p.obsecureText,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MySize.size10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: InkWell(
                        onTap: () {
                          resetPasswordBottomSheet(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!
                              .forgetpassword
                              .toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size30),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Consumer<LoginProvider>(
                    builder: (context, p, child) => CustomButton8(
                      text: AppLocalizations.of(context)!.signin.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      radius: MySize.size30,
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBarView()),
                          (route) => false,
                        );

                        // if (_loginKey.currentState!.validate()) {
                        //   await p.signInWithEmailPassword(emailController.text,
                        //       passwordController.text, context);
                        // } else {
                        //   CommonFunctions.flushBarErrorMessage(
                        //     "Field is Required",
                        //     context,
                        //   );
                        // }
                      },
                    ),
                  ),
                ),
                SizedBox(height: MySize.size40),
              ],
            ),
          ),
        ),
        Consumer<LoginProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  resetPasswordBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MySize.size30),
          topRight: Radius.circular(MySize.size30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: InkWell(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: MySize.size320,
                decoration: BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MySize.size30),
                    topRight: Radius.circular(MySize.size30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: Spacing.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!
                              .resetPassword
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomTextField13(
                        controller: forgetPasswordController,
                        hintText:
                            AppLocalizations.of(context)!.email.toString(),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        fillColor: ThemeColors.fillColor,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return CommonFunctions.validateTextField(value);
                        },
                      ),
                    ),
                    SizedBox(height: MySize.size10),
                    Padding(
                      padding:
                          Spacing.fromLTRB(MySize.size32, 0, MySize.size32, 0),
                      child: Text(
                        AppLocalizations.of(context)!
                            .forgetPasswordLink
                            .toString(),
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Consumer<LoginProvider>(
                      builder: (context, p, child) => Padding(
                        padding: Spacing.fromLTRB(
                            MySize.size32, 0, MySize.size32, MySize.size20),
                        child: p.showLoader
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : CustomButton8(
                                text: AppLocalizations.of(context)!
                                    .reset
                                    .toString(),
                                onPressed: () async {
                                  // if (forgetPasswordController
                                  //     .text.isNotEmpty) {
                                  //   await p.forgotPassword(
                                  //       forgetPasswordController.text, context);
                                  //   clearTextFormFields();
                                  // } else {
                                  //   CommonFunctions.flushBarErrorMessage(
                                  //     "Field is Required",
                                  //     context,
                                  //   );
                                  // }
                                },
                                backgroundColor: ThemeColors.mainColor,
                                textColor: ThemeColors.bgColor,
                                radius: MySize.size30,
                              ),
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

  clearTextFormFields() {
    forgetPasswordController.clear();
    passwordController.clear();
    emailController.clear();
  }
}
