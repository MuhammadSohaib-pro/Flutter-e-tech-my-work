import 'package:event_manager_app/helper/exports.dart';
import 'package:pinput/pinput.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

bool view_edit_flag = false;

class _ProfileViewState extends State<ProfileView> {
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 20,
        color: ThemeColors.mainColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: ThemeColors.grey3,
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.profile.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  view_edit_flag = !view_edit_flag;
                });
              },
              child: Text(
                view_edit_flag
                    ? AppLocalizations.of(context)!.save.toString()
                    : AppLocalizations.of(context)!.edit.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MySize.size70,
                width: MySize.safeWidth,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: MySize.size95,
                    height: MySize.size95,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600"),
                        fit: BoxFit.cover,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MySize.size25,
                      height: MySize.size25,
                      decoration: const ShapeDecoration(
                        color: ThemeColors.mainColor,
                        shape: CircleBorder(),
                      ),
                      margin: Spacing.horizontal(MySize.size6),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: MySize.size18,
                        color: ThemeColors.bgColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MySize.size6),
              Text(
                'Azeema',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MySize.size18),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText:
                      AppLocalizations.of(context)!.restaurantName.toString(),
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
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.ownerName.toString(),
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
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.category.toString(),
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
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.email.toString(),
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
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.phone.toString(),
                  fillColor: ThemeColors.fillColor,
                  sufixIcon: Icon(Icons.verified,
                      color: ThemeColors.mainColor, size: MySize.size18),
                  readOnly: true,
                  onTap: () {
                    customChangePhoneNumber(context);
                  },
                  validator: (value) {
                    return CommonFunctions.validateTextField(value);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.location.toString(),
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
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  hintText:
                      AppLocalizations.of(context)!.description.toString(),
                  fillColor: ThemeColors.fillColor,
                  maxLines: 5,
                  validator: (value) {
                    return CommonFunctions.validateTextField(value);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextField13(
                        controller: TextEditingController(),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        hintText:
                            AppLocalizations.of(context)!.password.toString(),
                        fillColor: ThemeColors.fillColor,
                        sufixIcon: const Icon(
                          Icons.visibility_outlined,
                          color: ThemeColors.mainColor,
                        ),
                        validator: (value) {
                          return CommonFunctions.validateTextField(value);
                        },
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    Container(
                      width: MySize.size60,
                      height: MySize.size25,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          // side: const BorderSide(
                          //     width: 0.50, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.reset.toString(),
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size35),
            ],
          ),
        ),
      ),
    );
  }

  customChangePhoneNumber(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.verification.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size22),
                  child: Text(
                    'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CountryFlagNumberTextField(
                    initialvalue: "+966",
                    title: AppLocalizations.of(context)!
                        .enterPhoneNumber
                        .toString(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.continuee.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {
                      Navigator.pop(context);
                      customOTPVerfication(context);
                    },
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }

  customOTPVerfication(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.oTP.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                    padding: Spacing.horizontal(MySize.size22),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum,',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n+966 21753713',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Column(
                    children: [
                      Pinput(
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        validator: (s) {
                          return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(height: MySize.size25),
                      Text(
                        AppLocalizations.of(context)!
                            .didntReceivedOTP
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.verify.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }
}
