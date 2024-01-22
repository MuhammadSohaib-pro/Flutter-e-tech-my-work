import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/home/home_view.dart';
import 'package:event_owner_app/screens/ordersdetail/orders_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

String selectedTab = "New";

class _OrdersViewState extends State<OrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        SizedBox(height: MySize.size25),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Builder(
            builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: SvgPicture.asset(icMenu, color: ThemeColors.black1),
                  ),
                  Text(
                    AppLocalizations.of(context)!.orders.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Orders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  // SvgPicture.asset(icBell, color: ThemeColors.bgColor),
                ],
              );
            },
          ),
        ),
        SizedBox(height: MySize.size26),
        
        DefaultTabController(
          length: 4,
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(
              color: ThemeColors.grey1,
              fontSize: MySize.size14,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: TextStyle(
              color: ThemeColors.black1,
              fontSize: MySize.size14,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelColor: ThemeColors.grey1,
            labelColor: ThemeColors.black1,
            labelPadding: const EdgeInsets.all(0),
            tabs: [
              Text(
                AppLocalizations.of(context)!.neww.toString(),
              ),
              Text(
                AppLocalizations.of(context)!.ongoing.toString(),
              ),
              Text(
                AppLocalizations.of(context)!.completed.toString(),
              ),
              Text(
                AppLocalizations.of(context)!.cancelled.toString(),
              ),
            ],
          ),
        ),

        SizedBox(height: MySize.size30),

        Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      newTabData(),
                    ],
                  ),
                  Column(
                    children: [
                      onGoingTabData(),
                    ],
                  ),
                  Column(
                    children: [
                      completedTabData()
                    ],
                  ),
                  Column(
                    children: [
                      cancelledTabData()
                    ],
                  ),
                ],
              ),
            ),
      ],
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
                          OrdersDetailsView(orderStatus: "New"),
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
                          OrdersDetailsView(orderStatus: "Ongoing"),
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
                          OrdersDetailsView(orderStatus: "Completed"),
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
                          OrdersDetailsView(orderStatus: "Cancelled"),
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
