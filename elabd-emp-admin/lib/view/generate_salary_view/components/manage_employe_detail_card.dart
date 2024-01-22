import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

class ManageEmployeDetailCard extends StatelessWidget {
  final String? name;
  final String? image;
  final String? type;
  final String? role;
  // final String? currentStatus;
  final String? totalSalary;
  const ManageEmployeDetailCard({
    Key? key,
    this.name,
    this.image,
    this.type,
    // this.currentStatus,
    this.role,
    this.totalSalary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
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
              horizontal: MySize.size15, vertical: MySize.size15),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size10),
                    child:
                     CachedNetworkImage(
                imageUrl: image!,
                height: MySize.size44,
                width: MySize.size44,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                   const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
                    //  Image.network(
                    //   image!,
                    //   height: MySize.size44,
                    //   width: MySize.size44,
                    //   fit: BoxFit.fill,
                    // ),
                    //  Image.asset(
                    //   AppIcons.projectp1,
                    //   height: MySize.size44,
                    //   width: MySize.size44,
                    // ),
                  ),
                  SizedBox(
                    width: MySize.size14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'Jack Sperrow',
                        name!,
                        style: poppinSemiBold.copyWith(fontSize: MySize.size15),
                      ),
                      SizedBox(
                        height: MySize.size6,
                      ),
                      Text(
                        type!,
                        // 'UI & UX Designer',
                        style: poppineRegular.copyWith(
                            color: primaryColor, fontSize: MySize.size12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    AppIcons.arrowforward,
                    height: MySize.size18,
                    width: MySize.size10,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
