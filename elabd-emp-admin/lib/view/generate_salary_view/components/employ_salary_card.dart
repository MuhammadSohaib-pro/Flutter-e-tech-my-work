import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

class EmployeSalaryCard extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  final String salary;
  final String team;
  final String salaryStatus;

  const EmployeSalaryCard({
    super.key,
    required this.image,
    required this.name,
    required this.type,
    required this.salary,
    required this.team,
    required this.salaryStatus,
  });

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
            horizontal: MySize.size10, vertical: MySize.size15),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(MySize.size10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: MySize.size44,
                      width: MySize.size44,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                    // Image.network(
                    //   image,
                    //   height: MySize.size44,
                    //   width: MySize.size44,
                    //   fit: BoxFit.fill,
                    // ),
                    ),
              ),
              SizedBox(
                width: MySize.size10,
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: poppinSemiBold.copyWith(fontSize: MySize.size14),
                      ),
                      SizedBox(
                        height: MySize.size6,
                      ),
                      Text(
                        team,
                        style: poppineRegular.copyWith(
                          color: primaryColor,
                          fontSize: MySize.size10,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: RichText(
                  text: TextSpan(
                    text: 'Role ',
                    style: poppinSemiBold.copyWith(
                        fontSize: MySize.size12, color: blackColor),
                    children: [
                      TextSpan(
                          text: type,
                          style:
                              poppineRegular.copyWith(fontSize: MySize.size12)),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MySize.size20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MySize.size10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Current Status: ',
                    style: poppineRegular.copyWith(
                        fontSize: MySize.size12, color: primaryColor),
                    children: [
                      TextSpan(
                        text: salaryStatus,
                        style: poppinBold.copyWith(
                            fontSize: MySize.size12,
                            color: salaryStatus == 'UnPaid'
                                ? redColor
                                : primaryColor),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Total Salary: ',
                    style: poppineRegular.copyWith(
                        fontSize: MySize.size12, color: primaryColor),
                    children: [
                      TextSpan(
                          text: salary.toString(),
                          style: poppinBold.copyWith(
                              fontSize: MySize.size12, color: primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
