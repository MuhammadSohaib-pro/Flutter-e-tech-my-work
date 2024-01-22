import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/providers/auth_provider.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();

  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Reset Password',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MySize.size30,
          ),
          Text(
            'We will send you a reset password link',
            style: poppinMedium.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 6,
          ),
          TextFieldWidget(
              readOnly: true,
              prefixIcon: Padding(
                  padding: EdgeInsets.all(
                    MySize.size15,
                  ),
                  child: const Icon(Icons.email)),
              controller: emailController,
              hintText: ''),
          SizedBox(
            height: MySize.size40,
          ),
          ButtonWidget(
            title: 'Reset Password',
            fontSize: MySize.size16,
            fontWeigth: FontWeight.w400,
            ontap: () async {
              if (emailController.text.isEmpty) {
                getFlushBar(context, title: "Email is requied");
              }
              // else if (!validateEmail(emailController.text.toString())) {
              //   getFlushBar(context, title: 'Invalid Email');
              // }
              else {
                await authProvider
                    .resetPasswor(
                        context: context,
                        email: emailController.text.toString())
                    .then((value) {
                  emailController.clear();
                });
              }
            },
          )
        ]),
      ),
    );
  }
}
