import 'package:elabd_ems_admin/helper/import_helper.dart';

class PersonCar extends StatelessWidget {
  const PersonCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MySize.screenWidth * 0.6,
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
            padding: EdgeInsets.symmetric(
                horizontal: MySize.size10, vertical: MySize.size15),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size10),
                    child: Image.asset(
                      AppIcons.projectp3,
                      height: MySize.size44,
                      width: MySize.size44,
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  width: MySize.size20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jack Sperrow',
                      style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                    ),
                    Text(
                      'UI & UX Designer',
                      style: poppineRegular.copyWith(
                          color: primaryColor, fontSize: MySize.size10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
