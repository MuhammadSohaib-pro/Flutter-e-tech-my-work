import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBookingDetailsView extends StatefulWidget {
  const MyBookingDetailsView({super.key, required this.type});

  final String type;

  @override
  State<MyBookingDetailsView> createState() => _MyBookingDetailsViewState();
}

class _MyBookingDetailsViewState extends State<MyBookingDetailsView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          "Booking Details",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size290,
                  decoration: ShapeDecoration(
                    color: ThemeColors.fillColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  padding: Spacing.all(MySize.size20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: ThemeColors.mainColor,
                                  size: MySize.size28,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Pedal Match',
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Saudi Arabia, Riyadh',
                                      style: TextStyle(
                                        color: ThemeColors.grey1,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MySize.size68,
                            height: MySize.size20,
                            decoration: ShapeDecoration(
                              color: widget.type == "completed"
                                  ? ThemeColors.green
                                  : widget.type == "cancelled"
                                      ? ThemeColors.red
                                      : ThemeColors.mainDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              widget.type == "completed"
                                  ? "Completed"
                                  : widget.type == "cancelled"
                                      ? "Cancelled"
                                      : widget.type == "upcoming"
                                          ? "Upcoming"
                                          : "Active",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MySize.size8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size20),
                      const Divider(),
                      SizedBox(height: MySize.size20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking ID',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '#4217431734174',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Wednesday 19 April, 2023',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '11:00pm-12:30pm',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '90 min',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Court',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
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
                              Text(
                                'Padel',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: ThemeColors.mainDark,
                                  fontSize: MySize.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size210,
                  decoration: ShapeDecoration(
                    color: ThemeColors.fillColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  padding: Spacing.all(MySize.size20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(icProductLogo),
                          SizedBox(width: MySize.size7),
                          Text(
                            'Products',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MySize.size15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: MySize.size34,
                                  height: MySize.size34,
                                  decoration: ShapeDecoration(
                                    color: ThemeColors.grey2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(width: MySize.size3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hiking Kit',
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Kitbag, Down jacket, Boots.......',
                                      style: TextStyle(
                                        color: ThemeColors.grey1,
                                        fontSize: MySize.size8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'AED.500',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: MySize.size34,
                                  height: MySize.size34,
                                  decoration: ShapeDecoration(
                                    color: ThemeColors.grey2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(width: MySize.size3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hiking Kit',
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Kitbag, Down jacket, Boots.......',
                                      style: TextStyle(
                                        color: ThemeColors.grey1,
                                        fontSize: MySize.size8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'AED.500',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size10),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: MySize.size34,
                                  height: MySize.size34,
                                  decoration: ShapeDecoration(
                                    color: ThemeColors.grey2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(width: MySize.size3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hiking Kit',
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Kitbag, Down jacket, Boots.......',
                                      style: TextStyle(
                                        color: ThemeColors.grey1,
                                        fontSize: MySize.size8,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'AED.500',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size260,
                  decoration: ShapeDecoration(
                    color: ThemeColors.fillColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  padding: Spacing.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            icWallet,
                            color: ThemeColors.mainColor,
                          ),
                          SizedBox(height: MySize.size7),
                          Text(
                            'Payment Summary',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MySize.size23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Cash',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Per Percipient',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'AED.500.00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Percipients',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '1',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Products Total',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'AED.799.00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MySize.size17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total to Pay',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'AED.13000.00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: ThemeColors.mainDark,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size5),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Booking Date: 17 April 2023',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. C',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size30),
              widget.type == "new"
                  ? Column(
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomButton8(
                            text: "Confirm Booking",
                            backgroundColor: ThemeColors.mainColor,
                            textColor: ThemeColors.bgColor,
                            radius: 30,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Padding(
                          padding: Spacing.horizontal(MySize.size32),
                          child: CustomButton8(
                            text: "Cancel",
                            backgroundColor: ThemeColors.fillColor,
                            textColor: ThemeColors.grey1,
                            radius: 30,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              widget.type == "today"
                  ? Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomButton8(
                        text: "Completed",
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        radius: 30,
                        onPressed: () {},
                      ),
                    )
                  : const SizedBox(),
              widget.type == "upcoming"
                  ? Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomButton8(
                        text: "Cancel",
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        radius: 30,
                        onPressed: () {},
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      ),
    );
  }
}
