
import 'package:boat_app/custom_widgets/custom_button.dart';
import 'package:boat_app/custom_widgets/loader_view.dart';
import 'package:boat_app/provider/loader_view_provider.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../languages/LocaleString.dart';
import '../../../provider/loading_provider/loading_provider.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_function.dart';
import '../../../utils/utils.dart';
import '../../auth/OTP verification/OTP_verification.dart';
import '../../auth/resetPassword/forgot_password.dart';

class UpdateProfilePage extends StatefulWidget {
  final Map<String ,dynamic> data;
  const UpdateProfilePage({super.key, required this.data});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController backupEmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool readOnly = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  nameController.text = widget.data['name']??'' ;
  emailController.text = widget.data['email'] ?? '';
  ageController.text = widget.data['age'] ?? '';
    backupEmailController.text = widget.data['backUpEmail'] ?? '';

    phoneController.text = widget.data['phone'] ?? '';
    updatePhoneController.text = widget.data['phone'] ?? '';


  }
  // void updateProfile() {
  // nameController.text = data['name'] ;
  // emailController.text = data['address'] ?? '';
  // aboutController.text = data['about'] ?? '';
  //
  // // You can implement the logic to update the user's profile here.
  //   String name = nameController.text;
  //   String address = emailController.text;
  //   String about = aboutController.text;
  //
  //   // Example: Print the updated profile details.
  //   print('Name: $name');
  //   print('Address: $address');
  //   print('About: $about');
  // }

  @override
  Widget build(BuildContext context) {
    // updateProfile();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(AppLocale.profile.getString(context)),
            actions: [
              InkWell(
                  onTap: (){
                    setState(() {
                      readOnly = !readOnly;
                    });
                  },
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF0095FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,

                    ),
                  )),
              SizedBox(width: 15,)
            ],
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),

                CustomTextField13(
                  title:  AppLocale.fullName.getString(context),
                  readOnly: readOnly,
                  controller: nameController,
                  fillColor: fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText:
                  AppLocale.fullName.getString(context),
                  keyboardType: TextInputType.emailAddress,
                  radius: 5,
                  validator: (value) => CommonFunctions.validateTextField(
                      value, context, 'name'),
                ),
                const SizedBox(height: 10),


                CustomTextField13(
                  title:               AppLocale.email.getString(context),
                  readOnly: true,

                  controller: emailController,
                  fillColor: fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText:
                  AppLocale.email.getString(context),
                  keyboardType: TextInputType.emailAddress,
                  radius: 5,
                  validator: (value) => CommonFunctions.validateTextField(
                      value, context, 'email'),
                ),
                const SizedBox(height: 10),

                //backup email
                CustomTextField13(
                  title: 'Backup Email',
                  readOnly: readOnly,
                  controller: backupEmailController,
                  fillColor: fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Backup email',
                  keyboardType: TextInputType.emailAddress,
                  radius: 5,
                  validator: (value) => CommonFunctions.validateTextField(
                      value, context, 'email'),
                ),
                const SizedBox(height: 10),
                //age
                CustomTextField13(
                  title: 'Age',
                  readOnly: readOnly,

                  controller: ageController,
                  fillColor: fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText:'Age',
                  keyboardType: TextInputType.emailAddress,
                  radius: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter age';
                    }
                    int? age = int.tryParse(value);
                    if (age == null) {
                      return 'Please enter a valid age';
                    }
                    // Additional validation logic if needed
                    // For example, you might want to check if age is within a certain range
                    if (age < 0 || age > 120) {
                      return 'Age should be between 0 and 120';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocale.contact.getString(context),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width(context)*0.75,
                      child: CustomTextField13(
                        readOnly: true,
                        controller: phoneController,
                        fillColor: fillColor,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText:'Phone',
                        keyboardType: TextInputType.number,
                        radius: 5,
                        validator: (value) => CommonFunctions.validateTextField(
                            value, context, 'phone'),
                      ),
                    ),
                    SizedBox(
                      width: MySize2.size10,
                    ),
                    InkWell(
                      onTap: () {
                        if(updatePhoneController.text.length >=11 ){
                          updatePhoneController.text = updatePhoneController.text.replaceRange(0, 3, '');
                        }
                        showPhoneInputDialog(context);
                      },
                      child: Text(
                        AppLocale.update.getString(context),
                        style: const TextStyle(
                          color: Color(0xFF0095FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocale.password.getString(context),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,),
                ),
                const SizedBox(height: 5),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width(context)*0.75,
                      child: CustomTextField13(
                        readOnly: true,

                        // controller: emailController,
                        fillColor: fillColor,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText:
                            '*********',
                        // AppLocale.password.getString(context),
                        keyboardType: TextInputType.emailAddress,
                        radius: 5,
                        validator: (value) => CommonFunctions.validateTextField(
                            value, context, 'email'),
                      ),
                    ),
                    SizedBox(
                      width: MySize2.size10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                      },
                      child: Text(
                        AppLocale.reset.getString(context),
                        style: const TextStyle(
                          color: Color(0xFF0095FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: !readOnly,
                  child: Center(
                    child: Consumer<LoaderViewProvider>(
                      builder: (context, lP, child){
                        return CustomButton8(
                            onPressed: (){
                        lP.changeShowLoaderValue(true);
                               FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).update({
                                 'name': nameController.text,
                                  'backUpEmail': backupEmailController.text,
                                  'age': ageController.text
                               }).then((value) {
                                 Utils.toastMessage('Updated');
                                 lP.changeShowLoaderValue(false);

                                 Navigator.pop(context);
                               }).onError((error, stackTrace) {
                                 Utils.toastMessage(error.toString());
                                 lP.changeShowLoaderValue(false);

                               });


                            }, text: AppLocale.update.getString(context));
                      },
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
        const LoaderView()
      ],
    );
  }
  var Ccode;

  void showPhoneInputDialog(BuildContext context) {
    String initialCountryCode = 'PK';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title:  Text(AppLocale.updatephoneNumber.getString(context)),
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          content: Container(
            height: height(context) * 0.15,

            child: Column(
              children: [
                IntlPhoneField(
                  initialCountryCode: initialCountryCode,
                  keyboardType: TextInputType.phone,
                  controller: updatePhoneController,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  disableLengthCheck: false,
                  showCursor: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: AppLocale.phoneNumber.getString(context),
                    hintStyle: const TextStyle(
                        color: Color(0xff9FA5C0), fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Colors.redAccent, width: 2),
                    ),
                  ),
                  onChanged: (phone) {
                    Ccode = phone.countryCode;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(AppLocale.cancel.getString(context)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child:  Text(AppLocale.update.getString(context)),
              onPressed: () async {

               if(phoneController.text.contains(updatePhoneController.text)){
                 Utils.authErrorSnackbar(context, 'Same phone number', 'Please enter new phone number');
               }else{
                 isLogin();
               }


                // FirebaseFirestore.instance.collection('Owner').doc(FirebaseAuth.instance.currentUser!.uid).update({
                //   'phone': Ccode! + phoneController.text,
                //   'verified': false
                // }).then((value) {
                //   Utils.toastMessage('Phone number Updated');
                // }).onError((error, stackTrace) {
                //   Utils.toastMessage(error.toString());
                // });
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void isLogin() {
    final loadingProvider =
    Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.loginLoading(true);
    _auth
        .verifyPhoneNumber(
        phoneNumber: Ccode + updatePhoneController.text,
        verificationCompleted: (_) {

        },
        verificationFailed: (e) {
          Utils.toastMessage(e.toString());
          if (kDebugMode) {
            print(e.toString());
          }
          loadingProvider.loginLoading(false);
        },
        codeSent: (String verification, int? token) {
          if (kDebugMode) {
            print(phoneController);
          }
          // FirebaseFirestore.instance.collection('Owner').doc(FirebaseAuth.instance.currentUser!.uid).update({
          //   'phone': Ccode + phoneController.text
          // }).then((value) {
          //   loadingProvider.loginLoading(false);
          //
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => OTPVerification(
          //             from: 'phone',
          //             verificationId: verification,
          //             phoneNumber: Ccode+phoneController.text,
          //           )));
          // }).onError((error, stackTrace) {
          //   Utils.toastMessage(error.toString());
          // });
          loadingProvider.loginLoading(false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTPVerification(
                        from: 'phone',
                        verificationId: verification,
                        phoneNumber: Ccode + phoneController.text,
                      )));
          if (kDebugMode) {
            print(phoneController);
          }
        },
        codeAutoRetrievalTimeout: (e) {
          loadingProvider.loginLoading(false);

          if (kDebugMode) {
            print(e.toString());
          }
        })
        .onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      loadingProvider.loginLoading(false);
    });
  }

}