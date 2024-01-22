// ignore_for_file: must_be_immutable

import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/home/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BranchOrdersDetailsView extends StatefulWidget {
  BranchOrdersDetailsView({super.key, required this.orderStatus});
  String orderStatus;
  @override
  State<BranchOrdersDetailsView> createState() => _BranchOrdersDetailsViewState();
}

class _BranchOrdersDetailsViewState extends State<BranchOrdersDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.orderDetails.toString(),
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
              FourOrderStepTile(
                widget: widget,
              ),
              SizedBox(height: MySize.size20),
              NewOrderTile(
                image: imgProfile,
                name: 'Mr. Wick',
                date: 'Today wed 19, 2023',
                type: widget.orderStatus == "New"
                    ? AppLocalizations.of(context)!.neww.toString()
                    : widget.orderStatus == "Ongoing"
                        ? AppLocalizations.of(context)!.onWay.toString()
                        : widget.orderStatus == "Completed"
                            ? AppLocalizations.of(context)!.completed.toString()
                            : widget.orderStatus == "Cancelled"
                                ? AppLocalizations.of(context)!.cancelled.toString()
                                : '',
                orderNo: "3816399163",
                amount: "1500.00 SAR",
              ),
              SizedBox(height: MySize.size25),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.customerDetails.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: MySize.size22),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.phone.toString(),
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    SvgPicture.asset(icphone),
                    SizedBox(width: MySize.size8),
                    Expanded(
                      child: Text(
                        '+1 63296492649',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: MySize.size61,
                      height: MySize.size22,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.call.toString(),
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size6),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: const Divider(color: ThemeColors.grey3),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    SvgPicture.asset(icmail),
                    SizedBox(width: MySize.size8),
                    Expanded(
                      child: Text(
                        'abc@gmail.com',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: MySize.size61,
                      height: MySize.size22,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.email.toString(),
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size6),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: const Divider(color: ThemeColors.grey3),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: ThemeColors.mainColor,
                      size: MySize.size14,
                    ),
                    SizedBox(width: MySize.size8),
                    Expanded(
                      child: Text(
                        'Saudi Arabia, Riyadh 40168',
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: MySize.size61,
                      height: MySize.size22,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.openMap.toString(),
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size6),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: const Divider(color: ThemeColors.grey3),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.message.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size8),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size120,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 2, color: ThemeColors.grey3),
                      borderRadius: BorderRadius.circular(MySize.size10),
                    ),
                  ),
                  child: Padding(
                    padding: Spacing.all(MySize.size12),
                    child: Text(
                      AppLocalizations.of(context)!.getMoreCustomersDescrip.toString(),
                      style: TextStyle(
                        color: ThemeColors.grey1,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.orderDetails.toString(),
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: MySize.size18),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  height: MySize.size28,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: ThemeColors.grey3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MySize.size4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.items.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.price.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size8),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => OrderItemsTile(
                        image: imgFavoriteFood,
                        title: 'Full Lamb\nRoasted',
                        quantity: '1',
                        amount: "200.00 SAR",
                      ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: MySize.size10),
                  itemCount: 5),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppLocalizations.of(context)!.deliveryCharges.toString()} ',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size9,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '200',
                            style: TextStyle(
                              color: ThemeColors.mainColor,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size3),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.orderStatus == "New" ||
                              widget.orderStatus == "Ongoing"
                          ? ""
                          : widget.orderStatus == "Completed"
                              ? AppLocalizations.of(context)!.orderCompleted.toString()
                              : AppLocalizations.of(context)!.orderCancelled.toString(),
                      style: TextStyle(
                        color: widget.orderStatus == "Completed"
                            ? ThemeColors.green
                            : ThemeColors.red,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppLocalizations.of(context)!.total.toString()} ',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: '1500.00 SAR',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItemsTile extends StatelessWidget {
  OrderItemsTile({
    super.key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.amount,
  });
  String image;
  String title;
  String quantity;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: SizedBox(
        height: MySize.size50,
        child: Row(
          children: [
            Container(
              width: MySize.size45,
              height: MySize.size45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgFavoriteFood),
                ),
              ),
            ),
            SizedBox(width: MySize.size4),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Full Lamb\nRoasted',
                    maxLines: 3,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'X1',
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '200.00 SAR',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourOrderStepTile extends StatelessWidget {
  const FourOrderStepTile({
    super.key,
    required this.widget,
  });

  final BranchOrdersDetailsView widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size70,
        decoration: ShapeDecoration(
          color: ThemeColors.grey3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: MySize.size14),
            CustomCircleProgressIndicator(
              value: widget.orderStatus == "New"
                  ? "1/4"
                  : widget.orderStatus == "Ongoing"
                      ? "2/4"
                      : widget.orderStatus == "Completed"
                          ? "4/4"
                          : "0/0",
              indicatorValue: widget.orderStatus == "New"
                  ? 0.25
                  : widget.orderStatus == "Ongoing"
                      ? 0.50
                      : widget.orderStatus == "Completed"
                          ? 1.0
                          : 0.0,
            ),
            SizedBox(width: MySize.size16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderStatus == "New"
                        ? AppLocalizations.of(context)!.newOrder.toString()
                        : widget.orderStatus == "Ongoing"
                            ? AppLocalizations.of(context)!.preparing.toString()
                            : widget.orderStatus == "Completed"
                                ? AppLocalizations.of(context)!.orderCompleted.toString()
                                : AppLocalizations.of(context)!.orderCancelled.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.followstep.toString(),
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: Spacing.all(MySize.size8),
                  child: Text(
                    widget.orderStatus == "New"
                        ? AppLocalizations.of(context)!.newOrder.toString()
                        : widget.orderStatus == "Ongoing"
                            ? AppLocalizations.of(context)!.preparing.toString()
                            : widget.orderStatus == "Completed"
                                ? AppLocalizations.of(context)!.completed.toString()
                                : AppLocalizations.of(context)!.cancelled.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.mainColor,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomCircleProgressIndicator extends StatelessWidget {
  CustomCircleProgressIndicator({
    super.key,
    required this.value,
    required this.indicatorValue,
  });
  String value;
  double indicatorValue;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 1.0,
                  color: ThemeColors.grey6,
                  strokeWidth: MySize.size6,
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            CircularProgressIndicator(
              value: indicatorValue,
              color: ThemeColors.mainColor,
              strokeWidth: MySize.size6,
            ),
          ],
        ),
      ],
    );
  }
}
