// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:elabd_ems_admin/helper/import_helper.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    this.title,
    this.status,
  }) : super(key: key);
  final String? title;
  final String? status;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(MySize.size10),
          boxShadow: [
            BoxShadow(
                color: blackColor.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(-1, -1))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size12, vertical: MySize.size16),
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MySize.size10),
                color: const Color(0xff7DC247).withOpacity(0.18)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MySize.size12, vertical: MySize.size12),
              child: Image.asset(
                AppIcons.website,
                height: MySize.size20,
                width: MySize.size20,
              ),
            ),
          ),
          SizedBox(
            width: MySize.size20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: poppinBold.copyWith(fontSize: MySize.size14),
              ),
              SizedBox(
                height: MySize.size6,
              ),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: poppineRegular.copyWith(
                        fontSize: MySize.size10, color: primaryColor),
                  ),
                  SizedBox(
                    width: MySize.size8,
                  ),
                  Text(
                    status!,
                    style: poppinBold.copyWith(
                        color: primaryColor, fontSize: MySize.size10),
                  ),
                  SizedBox(
                    width: MySize.size8,
                  ),
                  Image.asset(
                    AppIcons.completedicon,
                    height: MySize.size10,
                    width: MySize.size10,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Image.asset(
            AppIcons.arrowforward,
            height: MySize.size18,
            width: MySize.size10,
          )
        ]),
      ),
    );
  }
}
