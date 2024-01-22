import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/routes/routes_const.dart';

import 'components/person_card.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.size50),
            child: Column(
              children: [
                SizedBox(
                  height: MySize.screenHeight * 0.1,
                ),
                Text(
                  'You Successfully Paid',
                  style: poppinMedium.copyWith(
                      fontSize: MySize.size15, color: primaryColor),
                ),
                Text(
                  'Thank You',
                  style: poppinMedium.copyWith(
                      fontSize: MySize.size24, color: primaryColor),
                ),
                SizedBox(
                  height: MySize.size50,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const PersonCar();
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                          child: VerticalDivider(
                            thickness: 3,
                            color: primaryColor,
                          ),
                        ),
                    itemCount: 5),
                SizedBox(
                  height: MySize.size30,
                ),
                ButtonWidget(
                  title: 'Back to home',
                  ontap: () {
                    Navigator.pushReplacementNamed(context, bottomNavigation);
                  },
                  textColor: whiteColor,
                  fontSize: MySize.size16,
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                ButtonWidget(
                  title: 'Paymore',
                  backColor: whiteColor,
                  borderColor: primaryColor,
                  textColor: primaryColor,
                  fontSize: MySize.size16,
                  ontap: () {},
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
