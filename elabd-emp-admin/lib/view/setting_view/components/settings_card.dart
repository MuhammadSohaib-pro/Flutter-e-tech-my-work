import 'package:elabd_ems_admin/helper/import_helper.dart';

class SettingCard extends StatelessWidget {
  const SettingCard(
      {super.key,
      this.traling,
      required this.image,
      required this.title,
      required this.onTap});
  final Widget? traling;
  final String image;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // height: MySize.screenHeight * 0.1,
        height: MySize.scaleFactorHeight * 70,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(MySize.size10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(2, 2),
                  color: blackColor.withOpacity(0.10))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20),
          child: Row(children: [
            Image.asset(
              image,
              height: MySize.size20,
              width: MySize.size20,
            ),
            SizedBox(
              width: MySize.size20,
            ),
            Text(
              title,
              style: poppinMedium.copyWith(fontSize: MySize.size14),
            ),
            const Spacer(),
            traling!,
          ]),
        ),
      ),
    );
  }
}
