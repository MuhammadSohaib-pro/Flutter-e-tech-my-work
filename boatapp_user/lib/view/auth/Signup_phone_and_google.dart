

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/app_button.dart';
import '../../custom_widgets/app_text_field.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/loader_view.dart';
import '../../languages/LocaleString.dart';
import '../../provider/loader_view_provider.dart';
import '../../provider/loading_provider/loading_provider.dart';
import '../../utils/colors.dart';
import '../../utils/common_function.dart';
import '../../utils/constants.dart';
import '../../utils/global_function.dart';
import '../../utils/image_paths.dart';
import '../../utils/sized_box.dart';
import '../../utils/textstyles.dart';
import '../../utils/utils.dart';
import 'OTP verification/OTP_verification.dart';

class SignUpWIthPhoneAndEmail extends StatefulWidget {
  final String name,email;
  const SignUpWIthPhoneAndEmail({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  State<SignUpWIthPhoneAndEmail> createState() => _SignUpWIthPhoneAndEmailState();
}

class _SignUpWIthPhoneAndEmailState extends State<SignUpWIthPhoneAndEmail> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin() {
    final loadingProvider =
    Provider.of<LoaderViewProvider>(context,
        listen: false);

    _auth
        .verifyPhoneNumber(
        phoneNumber: Ccode + phoneController.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Utils.toastMessage(e.toString());
          if (kDebugMode) {
            print(e.toString());
          }
          loadingProvider.changeShowLoaderValue(false);

        },
        codeSent: (String verification, int? token) {
          if (kDebugMode) {
            print(phoneController);
          }
          loadingProvider.changeShowLoaderValue(false);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPVerification(
                    verificationId: verification,
                    phoneNumber: Ccode+ phoneController.text,
                  )));
          if (kDebugMode) {
            print(phoneController);
          }
        },
        codeAutoRetrievalTimeout: (e) {
          loadingProvider.changeShowLoaderValue(false);

          if (kDebugMode) {
            print(e.toString());
          }
        })
        .onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      loadingProvider.changeShowLoaderValue(false);
    });
  }
  final FlutterLocalization localization = FlutterLocalization.instance;

  // final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var Ccode;


  void _submitForm(BuildContext context) async{
    final loadingProvider =
     Provider.of<LoaderViewProvider>(context,
        listen: false);
      // Form is valid, perform login or other actions
      // String email = widget.email;
      // String name = widget.name;
      String phonee = Ccode+phoneController.text;


      bool isConnected = await Utils.checkInternetConnection();
      if(isConnected == true){

        loadingProvider.changeShowLoaderValue(true);
        bool? isUsed = await isPhoneNumberUsed(phonee);
        if(isUsed == false){
          FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
            'phone': phonee
          }).then((value) {
            isLogin();

          }).onError((error, stackTrace) {
            Utils.toastMessage(error.toString());
            loadingProvider.changeShowLoaderValue(false);
          });
        }else{
          loadingProvider.changeShowLoaderValue(false);
          Utils.toastMessage('Phone number is already used');
        }


      }
      else{
        showNoInternetDialog(context);
      }

      // Perform login logic here

    }

  @override
  void initState() {
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final loadingProvider =
    Provider.of<LoadingProvider>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:  EdgeInsets.only(left: 20.0, right: 20, top: height(context)*0.08),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                      'Registration',
                          //AppLocale.'registration'.getString(context),
                          style: text22700,
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        Text(
                          'Enter account',
                          // AppLocale.'pleaseEnterAccount'.getString(context),
                          style: text15500color,
                        ),

                          SizedBox(
                            height: height(context) * 0.03,
                          ),
                        CustomTextField13(
                          readOnly: true,
                          controller: _nameController,
                          fillColor: fillColor,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          hintText:
                          AppLocale.email.getString(context),
                          keyboardType: TextInputType.emailAddress,
                          radius: 5,
                          validator: (value) => CommonFunctions.validateTextField(
                              value, context, 'email'),
                        ),
                          // AppTextField(
                          //   testFieldEnabled: false,
                          //   controller: _nameController,
                          //   prefixIconButton: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5.0, horizontal: 10),
                          //     child: SizedBox(
                          //         height: 30,
                          //         child:ColorFiltered(
                          //           colorFilter: const ColorFilter.mode(Color(0xff2E3E5C), BlendMode.srcIn),
                          //           child: Image.asset(
                          //             person, // Replace with the actual path to your PNG image
                          //             height: height(context) * 0.03,
                          //             width: height(context) * 0.03,
                          //           ),
                          //         )
                          //     ),
                          //   ),
                          //   hintTextColor: const Color(0xff9FA5C0),
                          //   borderColor: const Color(0xffD0DBEA),
                          //   hintText: AppLocale.fullName.getString(context),
                          // ),
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                        CustomTextField13(
                          readOnly: true,

                          controller: _emailController,
                          autoValidateMode:
                          AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          hintText:
                          AppLocale.email.getString(context),
                          fillColor: fillColor,
                          validator: (value) {
                            return CommonFunctions.validateTextField(value,context,'email');
                          },
                        ),
                          // AppTextField(
                          //   testFieldEnabled: false,
                          //   controller: _emailController,
                          //   prefixIconButton: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         vertical: 5.0, horizontal: 10),
                          //     child: SizedBox(
                          //       height: 30,
                          //       child: SvgPicture.asset(email),
                          //     ),
                          //   ),
                          //   hintTextColor: const Color(0xff9FA5C0),
                          //   borderColor: const Color(0xffD0DBEA),
                          //   hintText: AppLocale.emailOrPhoneNumber.getString(context),
                          // ),
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                          SizedBox(
                            height: 75,

                            child: IntlPhoneField(


                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: ( value) {
                                // Implement your validation logic here
                                print('object');
                                if ( value!.number.length< 1) {
                                  return AppLocale.enterPhone.getString(context);
                                }
                                else if(value.completeNumber.length < 10){
                                  return 'Enter a valid phone number';

                                }

                                // Add your specific validation rules, e.g., checking for specific patterns or lengths

                                return null; // Return null if validation passes
                              },
                              initialCountryCode: 'SA',
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              style: const TextStyle(color: Colors.black, fontSize: 14),
                              disableLengthCheck: false,
                              showCursor: false,

                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(13, 15, 13, 17),
                                prefixIcon: const Icon(Icons.phone,),
                                hintText:               AppLocale.phoneNumber.getString(context),
                                hintStyle: const TextStyle(color:Color(0xff9FA5C0),fontSize:14),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 0.5, color: greyText),
                                  borderRadius: BorderRadius.circular(5),

                                  // borderSide: const BorderSide(),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular( 5),
                                    borderSide:  BorderSide(color: primaryColor, width: 1)

                                  // borderSide: BorderSide(color: appColor1, width: 3)
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.redAccent, width: 1)

                                  // borderSide: BorderSide(color: appColor1, width: 3)
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.redAccent, width: 1)

                                  // borderSide: BorderSide(color: appColor1, width: 3)
                                ),


                              ),
                              onChanged: (phone) {
                                Ccode = phone.countryCode;

                              },

                            ),
                          ),


                          SizedBox(
                            height: height(context) * 0.04,
                          ),
                          Consumer<LoadingProvider>(
                            builder: (context, value,child){
                              return AppButton(
                                height: height(context)*0.065,

                                loading: loadingProvider.loading,
                                onPressed: () {

                                  _submitForm(context);
                                },
                                text: AppLocale.next.getString(context),
                              );
                            },
                          ),

                          SizedBox(
                            height: height(context) * 0.02,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

        ),
        // this a reusable widget used for showing loading
        const LoaderView(),
      ],
    );
  }





}
