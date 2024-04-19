import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/view/auth/signin/loginscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/app_button.dart';
import '../../../custom_widgets/app_text_field.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../custom_widgets/loader_view.dart';
import '../../../languages/LocaleString.dart';
import '../../../provider/loader_view_provider.dart';
import '../../../provider/loading_provider/loading_provider.dart';
import '../../../utils/MySize.dart';
import '../../../utils/common_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_function.dart';
import '../../../utils/image_paths.dart';
import '../../../utils/sized_box.dart';
import '../../../utils/textstyles.dart';
import '../../../utils/utils.dart';
import '../auth_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();


  void _submitForm() async {
    print(_emailController);
    //initializing provider for showing loading when needed
    final obj = Provider.of<LoaderViewProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      // Form is valid, perform login or other actions
      String email = _emailController.text;

      //this line of code starts the loading
      obj.changeShowLoaderValue(true);

      bool isConnected = await Utils.checkInternetConnection();
      if (isConnected == true) {

        String? userType = await getUserType(email);
        print(userType);
        //check if user email is valid
        if (userType == 'User') {


          //code for reset password
          _authService.resetPassword(_emailController.text).then((value) {
            //this line of code closes the loading
            obj.changeShowLoaderValue(false);
            Utils.toastMessage('Password reset email sent');
          });
        } else {
          obj.changeShowLoaderValue(false);

          //check if email is invalid or connected with owner account
          bool? userType = await getOwner(email);
          if(userType == true){
            Utils.toastMessage(
                'Email linked with owner account');
          }else{
            Utils.toastMessage(
                'Incorrect email');
          }

        }
      } else {
        showNoInternetDialog(context);
      }

      // } else {
      //   //
      //   print('Authentication failed, display an error message');
      //
      //   // ...
      //
      // }

      // Perform login logic here
      if (kDebugMode) {
        print('Login with Email: $email');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    MySize2().init(context);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocale.resetPassword.getString(context),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,

            // automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MySize.size32, right: MySize.size32, top: MySize.size20),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //custom textfield for email
                        CustomTextField13(
                          hintText:AppLocale.email.getString(context),
                          controller: _emailController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => CommonFunctions.validateTextField(
                              value, context, 'email'),
                        ),

                        SizedBox(
                          height: height(context) * 0.04,
                        ),

                        //custom button
                        CustomButton8(
                          text:
                          AppLocale.resetRequest.getString(context),
                          onPressed: () {
                            //used this method to keep all login functionality out of widget tree
                            _submitForm();
                          },
                          radius: 5,
                          backgroundColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const LoaderView(),
      ],
    );
  }
}
