import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/home/home_view.dart';
import 'package:event_owner_app/screens/manage_branches/orders/orders_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class BranchOrdersView extends StatefulWidget {
  const BranchOrdersView({super.key});

  @override
  State<BranchOrdersView> createState() => _BranchOrdersViewState();
}

String selectedTab = "New";

class _BranchOrdersViewState extends State<BranchOrdersView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.orders.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MySize.size15),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = "New";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.neww.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size4),
                        selectedTab == "New"
                            ? Container(
                                width: MySize.size28,
                                height: MySize.size2,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MySize.size20),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = "Ongoing";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.ongoing.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size4),
                        selectedTab == "Ongoing"
                            ? Container(
                                width: MySize.size28,
                                height: MySize.size2,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MySize.size20),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = "Completed";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.completed.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size4),
                        selectedTab == "Completed"
                            ? Container(
                                width: MySize.size28,
                                height: MySize.size2,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MySize.size20),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = "Cancelled";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.cancelled.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size4),
                        selectedTab == "Cancelled"
                            ? Container(
                                width: MySize.size28,
                                height: MySize.size2,
                                decoration: ShapeDecoration(
                                  color: ThemeColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MySize.size20),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size30),
            selectedTab == "New"
                ? newTabData()
                : selectedTab == "Ongoing"
                    ? onGoingTabData()
                    : selectedTab == "Completed"
                        ? completedTabData()
                        : selectedTab == "Cancelled"
                            ? cancelledTabData()
                            : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget newTabData() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BranchOrdersDetailsView(orderStatus: "New"),
                    ),
                  );
                },
                child: NewOrderTile(
                  image: imgProfile,
                  name: 'Mr. Wick',
                  date: 'Today wed 19, 2023',
                  type: AppLocalizations.of(context)!.neww.toString(),
                  orderNo: "3816399163",
                  amount: "1500.00 SAR",
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(height: MySize.size15),
          itemCount: 5),
    );
  }

  Widget onGoingTabData() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BranchOrdersDetailsView(orderStatus: "Ongoing"),
                    ),
                  );
                },
                child: NewOrderTile(
                  image: imgProfile,
                  name: 'Mr. Wick',
                  date: 'Today wed 19, 2023',
                  type: AppLocalizations.of(context)!.preparing.toString(),
                  orderNo: "3816399163",
                  amount: "1500.00 SAR",
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(height: MySize.size15),
          itemCount: 3),
    );
  }

  Widget completedTabData() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BranchOrdersDetailsView(orderStatus: "Completed"),
                    ),
                  );
                },
                child: NewOrderTile(
                  image: imgProfile,
                  name: 'Mr. Wick',
                  date: 'Today wed 19, 2023',
                  type: AppLocalizations.of(context)!.completed.toString(),
                  orderNo: "3816399163",
                  amount: "1500.00 SAR",
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(height: MySize.size15),
          itemCount: 3),
    );
  }

  Widget cancelledTabData() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BranchOrdersDetailsView(orderStatus: "Cancelled"),
                    ),
                  );
                },
                child: NewOrderTile(
                  image: imgProfile,
                  name: 'Mr. Wick',
                  date: 'Today wed 19, 2023',
                  type: AppLocalizations.of(context)!.cancelled.toString(),
                  orderNo: "3816399163",
                  amount: "1500.00 SAR",
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(height: MySize.size15),
          itemCount: 3),
    );
  }
}
