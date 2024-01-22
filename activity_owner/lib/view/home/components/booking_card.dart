import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingCard extends StatelessWidget {
  const BookingCard(
      {super.key,
      required this.bookingName,
      required this.date,
      required this.time,
      required this.bookingId,
      required this.firstBtnText,
      required this.firstBtnColor,
      required this.firstBtnPressed,
      this.secondBtnPressed,
      this.secondBtnShow,
      this.detailsPressed,
      required this.firstBtnTextColor});

  final String bookingName;
  final String date;
  final String time;
  final String bookingId;
  final String firstBtnText;
  final Color firstBtnColor;
  final Color firstBtnTextColor;
  final VoidCallback? firstBtnPressed;
  final VoidCallback? secondBtnPressed;
  final VoidCallback? detailsPressed;
  final bool? secondBtnShow;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size155,
        decoration: BoxDecoration(
          color: ThemeColors.bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: Spacing.horizontal(MySize.size15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size16),
              Row(
                children: [
                  Container(
                    width: MySize.size66,
                    height: MySize.size66,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: MySize.size8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bookingName,
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: detailsPressed,
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ThemeColors.black1,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$date\n$time',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking ID',
                              style: TextStyle(
                                color: ThemeColors.grey1,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '#$bookingId',
                              style: TextStyle(
                                color: ThemeColors.mainDark,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MySize.size20),
              const Divider(color: ThemeColors.grey1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: firstBtnPressed,
                        child: Container(
                          width: MySize.size68,
                          height: MySize.size22,
                          decoration: ShapeDecoration(
                            color: firstBtnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(300),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            firstBtnText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: firstBtnTextColor,
                              fontSize: MySize.size8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      secondBtnShow == null
                          ? Padding(padding: Spacing.zero)
                          : SizedBox(width: MySize.size10),
                      secondBtnShow == null
                          ? Padding(padding: Spacing.zero)
                          : GestureDetector(
                              onTap: secondBtnPressed,
                              child: Container(
                                width: MySize.size68,
                                height: MySize.size22,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.black1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(300),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Confirm",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeColors.bgColor,
                                    fontSize: MySize.size8,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: MySize.size24,
                        height: MySize.size24,
                        decoration: const ShapeDecoration(
                          color: ThemeColors.mainColor,
                          shape: CircleBorder(),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(icRacket),
                      ),
                      SizedBox(width: MySize.size4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.pedal.toString(),
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .pedalDescrp
                                .toString(),
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
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
