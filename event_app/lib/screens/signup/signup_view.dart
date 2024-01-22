// ignore_for_file: use_build_context_synchronously
import 'package:event_app/helper/imports.dart';
import 'package:event_app/screens/signup/signup_provider.dart';
import 'package:event_app/widgets/loader_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  // @override
  // void dispose() {
  //   fullnameController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   emailController.dispose();
  //   contactController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeColors.bgColor,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)!.register.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                child: Text(
                  AppLocalizations.of(context)!.signin.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeColors.mainColor,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ScrollableColumn(
              children: [
                SizedBox(height: MySize.size40),
                Consumer<SignUpProvider>(
                  builder: (context, p, child) => Form(
                    key: _signUpKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: fullnameController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .fullName
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
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
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: contactController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .contact
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size12),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: passwordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .createPassword
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            sufixIcon: p.obsecureText1
                                ? GestureDetector(
                                    onTap: () {
                                      p.setObsecureText1(!p.obsecureText1);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      p.setObsecureText1(!p.obsecureText1);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  ),
                            obscureText: p.obsecureText1,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                        SizedBox(height: MySize.size8),
                        SizedBox(
                          child: Padding(
                            padding: Spacing.horizontal(MySize.size35),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .passwordDetail
                                        .toString(),
                                    style: const TextStyle(
                                      color: ThemeColors.grey1,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomTextField13(
                            controller: confirmPasswordController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            hintText: AppLocalizations.of(context)!
                                .confirmPassword
                                .toString(),
                            fillColor: ThemeColors.fillColor,
                            sufixIcon: p.obsecureText2
                                ? GestureDetector(
                                    onTap: () {
                                      p.setObsecureText2(!p.obsecureText2);
                                    },
                                    child: const Icon(
                                      Icons.visibility_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      p.setObsecureText2(!p.obsecureText2);
                                    },
                                    child: const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ThemeColors.mainColor,
                                    ),
                                  ),
                            obscureText: p.obsecureText2,
                            validator: (value) {
                              return CommonFunctions.validateTextField(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MySize.size30),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Consumer<SignUpProvider>(
                    builder: (context, p, child) => CustomButton8(
                      text: AppLocalizations.of(context)!.signUp.toString(),
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      radius: 30,
                      onPressed: () async {
                        CommonFunctions.closeKeyboard(context);
                        if (_signUpKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            await p.signUpWithEmailPassword(
                                fullnameController.text,
                                emailController.text,
                                contactController.text,
                                passwordController.text,
                                context);
                            clearTextFormFields();
                          } else {
                            CommonFunctions.flushBarErrorMessage(
                                "Password did not match", context);
                          }
                        } else {
                          CommonFunctions.flushBarErrorMessage(
                              AppLocalizations.of(context)!
                                  .fieldRequired
                                  .toString(),
                              context);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: MySize.size50),
                // Text(
                //   AppLocalizations.of(context)!.or.toString(),
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: ThemeColors.grey1,
                //     fontSize: MySize.size10,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // SizedBox(height: MySize.size20),
                // Consumer<SignUpProvider>(
                //   builder: (context, p, child) => Platform.isIOS
                //       ? Padding(
                //           padding: Spacing.horizontal(MySize.size32),
                //           child: CustomSocialButton(
                //             text: AppLocalizations.of(context)!
                //                 .signUpwithApple
                //                 .toString(),
                //             backgroundColor: Colors.black,
                //             textColor: ThemeColors.bgColor,
                //             image: icApplelogo,
                //             onPressed: () {},
                //           ),
                //         )
                //       : Padding(
                //           padding: Spacing.horizontal(MySize.size32),
                //           child: CustomSocialButton(
                //             text: AppLocalizations.of(context)!
                //                 .signUpwithGoogle
                //                 .toString(),
                //             backgroundColor: ThemeColors.fillColor,
                //             textColor: ThemeColors.mainColor,
                //             image: icGoogleLogo,
                //             onPressed: () {},
                //           ),
                //         ),
                // ),
                SizedBox(height: MySize.size30),
              ],
            ),
          ),
        ),
        Consumer<SignUpProvider>(
          builder: (context, p, child) =>
              p.showLoader ? const LoaderView() : Container(),
        ),
      ],
    );
  }

  clearTextFormFields() {
    fullnameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    contactController.clear();
  }
}
