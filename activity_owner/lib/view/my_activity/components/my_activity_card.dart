import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';


class MyActivitiesCard extends StatelessWidget {
  const MyActivitiesCard({
    super.key,
    required this.image,
    required this.activityName,
    required this.location,
    required this.rating,
    required this.totalRating,
    required this.amount,
    required this.status,
  });

  final String image;
  final String activityName;
  final String location;
  final String rating;
  final String totalRating;
  final String amount;
  final String status;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size100,
        decoration: ShapeDecoration(
          color: ThemeColors.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: Spacing.all(MySize.size10),
          child: Row(
            children: [
              Container(
                width: MySize.size80,
                height: MySize.size80,
                decoration: ShapeDecoration(
                  color: ThemeColors.grey2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: MySize.size10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activityName,
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ThemeColors.grey1,
                          size: MySize.size20,
                        ),
                        Text(
                          location,
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: ThemeColors.mainColor,
                          size: MySize.size20,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: rating,
                                style: TextStyle(
                                  color: ThemeColors.black1,
                                  fontSize: MySize.size11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '/$totalRating+',
                                style: TextStyle(
                                  color: ThemeColors.grey1,
                                  fontSize: MySize.size11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$$amount',
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MySize.size95,
                    height: MySize.size28,
                    decoration: ShapeDecoration(
                      color: status == "Active"
                          ? ThemeColors.mainColor
                          : status == "Deactivated"
                              ? ThemeColors.fillColor
                              : status == "Under Review"
                                  ? ThemeColors.mainDark
                                  : status == "Rejected"
                                      ? ThemeColors.red
                                      : ThemeColors.black1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: status == "Active" ||
                                status == "Under Review" ||
                                status == "Rejected"
                            ? ThemeColors.bgColor
                            : ThemeColors.grey1,
                        fontSize: MySize.size11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
