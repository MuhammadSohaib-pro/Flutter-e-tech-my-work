
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  //final TextEditingController PhoneCon = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController PhoneCon = TextEditingController();
  String initialCountry = 'UAE';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  PhoneNumber? numberstring;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: SizeConfig.widthMultiplier * 5.5,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: MyEdgeInsets.appPadding,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter Your Number',
                  style: MyTextStyles.interTextstyle(
                      SizeConfig.textMultiplier * 3, FontWeight.w600),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),

              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: SizeConfig.widthMultiplier * 65,
                  child: Text(
                    'Korem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis..',
                    style: MyTextStyles.interTextstyle(
                        SizeConfig.textMultiplier * 1.6, FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Form(
                key: formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height(context)*0.055,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: SingleChildScrollView(
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },

                              selectorConfig: const SelectorConfig(
                                selectorType: PhoneInputSelectorType.DIALOG,
                                // setSelectorButtonAsPrefixIcon = true,
                              ),
                              // inputDecoration: InputDecoration(
                              //   //labelText: 'Phone Number',
                              //   // You can customize the input decoration to include an icon
                              //   suffixIcon: Icon(Icons.arrow_drop_down),
                              // ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),

                              initialValue: number,
                              textFieldController: PhoneCon,
                              formatInput: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              // inputBorder: OutlineInputBorder(),

                              onSaved: (PhoneNumber number) {
                                numberstring=number;
                                print('On Saved: $number');
                                print('numberstring $numberstring');
                              },
                            ),
                          ),
                        ),
                      ),

                    ],

                  ),
                ),
              ),

              // SizedBox(height: SizeConfig.heightMultiplier*3,),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyButtonContainer(
                    containerColor: const Color(0xFF2538E8),
                    textColor: Colors.white,
                    onTap: () {
                      //formKey.currentState?.validate();
                      if (formKey.currentState?.validate() == true) {
                        formKey.currentState?.save();
                        Navigator.of(context).push(_createRoute());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the valid number'),
                          ),
                        );
                      }

                      print('$PhoneCon');
                    },
                    buttonText: 'Continue',
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PhoneNumberVerifyOTPScreen(number: numberstring ?? PhoneNumber()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    PhoneCon.dispose();
    super.dispose();
  }
}

class PhoneNumberVerifyOTPScreen extends StatefulWidget {
  PhoneNumber number;
  PhoneNumberVerifyOTPScreen({Key? key, required this.number})
      : super(key: key);

  @override
  State<PhoneNumberVerifyOTPScreen> createState() =>
      _PhoneNumberVerifyOTPScreenState();
}

class _PhoneNumberVerifyOTPScreenState
    extends State<PhoneNumberVerifyOTPScreen> {

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    print('${widget.number}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: SizeConfig.widthMultiplier * 5.5,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: MyEdgeInsets.appPadding,
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verify Your OTP',
                  style: MyTextStyles.interTextstyle(
                      SizeConfig.textMultiplier * 2.5, FontWeight.w600),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 70,
                child: Text(
                  'Dorem ipsum dolor sit amet, consectetur adipiscing elit.  Class apt ad +',
                  style: MyTextStyles.interTextstyle(
                      SizeConfig.textMultiplier * 1.6, FontWeight.w400),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 8,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          return value == '2222' ? null : 'Pin is incorrect';
                        },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                           // borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //    focusNode.unfocus();
                    //     formKey.currentState!.validate();
                    //   },
                    //   child: const Text('Validate'),
                    // ),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              TextButton(
                onPressed:() {

                },
                child:Text('Didn’t Received OTP',
              style:MyTextStyles.myTextStyleappbar,),),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyButtonContainer(
                    containerColor: const Color(0xFF2538E8),
                    textColor: Colors.white,
                    onTap: () {
                      //formKey.currentState?.validate();
                      focusNode.unfocus();
                      if ( formKey.currentState!.validate() == true) {


                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the valid OTP'),
                          ),
                        );
                      }


                    },
                    buttonText: 'Confirm',
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
