import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/home/components/booking_card.dart';
import 'package:activity_owner/view/my_bookings/provider/my_bookings_provider.dart';
import 'package:activity_owner/view/my_bookings_detail/my_bookings_detail_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookingView extends StatefulWidget {
  const MyBookingView({super.key});

  @override
  State<MyBookingView> createState() => _MyBookingViewState();
}

class _MyBookingViewState extends State<MyBookingView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        SizedBox(height: MySize.size15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Consumer<MyBookingsProvider>(
            builder: (context, provider, child) => Row(
              children: [
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: "New",
                  isSelected: provider.tabIndex == 0 ? true : false,
                  onPressed: () {
                    provider.settabValue(0);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: "Today",
                  isSelected: provider.tabIndex == 1 ? true : false,
                  onPressed: () {
                    provider.settabValue(1);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: "Upcoming",
                  isSelected: provider.tabIndex == 2 ? true : false,
                  onPressed: () {
                    provider.settabValue(2);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: "Completed",
                  isSelected: provider.tabIndex == 3 ? true : false,
                  onPressed: () {
                    provider.settabValue(3);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: "Cancelled",
                  isSelected: provider.tabIndex == 4 ? true : false,
                  onPressed: () {
                    provider.settabValue(4);
                  },
                ),
                SizedBox(width: MySize.size5),
              ],
            ),
          ),
        ),
        Consumer<MyBookingsProvider>(
          builder: (context, provider, child) => provider.tabIndex == 0
              ? newBookings()
              : provider.tabIndex == 1
                  ? todayBookings()
                  : provider.tabIndex == 2
                      ? upComingBookings()
                      : provider.tabIndex == 3
                          ? completedBookings()
                          : provider.tabIndex == 4
                              ? cancelledBookings()
                              : Container(),
        ),
      ],
    );
  }

  Widget noBookings() {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(imgNoBookings),
          Text(
            "No Bookings Found!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.mainColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.grey1,
              fontSize: MySize.size12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget newBookings() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => BookingCard(
                bookingName: "Activity",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.fillColor,
                firstBtnTextColor: ThemeColors.grey1,
                firstBtnPressed: () {},
                detailsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyBookingDetailsView(type: "new"),
                    ),
                  );
                },
                firstBtnText: "Cancel",
                secondBtnShow: true,
                secondBtnPressed: () {},
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget todayBookings() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => BookingCard(
                bookingName: "Activity",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.mainDark,
                firstBtnTextColor: ThemeColors.bgColor,
                firstBtnPressed: () {},
                detailsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyBookingDetailsView(type: "today"),
                    ),
                  );
                },
                firstBtnText: "Active",
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget upComingBookings() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => BookingCard(
                bookingName: "Activity",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.fillColor,
                firstBtnTextColor: ThemeColors.grey1,
                firstBtnPressed: () {},
                detailsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyBookingDetailsView(type: "upcoming"),
                    ),
                  );
                },
                firstBtnText: "Upcoming",
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget completedBookings() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => BookingCard(
                bookingName: "Activity",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.mainColor,
                firstBtnTextColor: ThemeColors.bgColor,
                firstBtnPressed: () {},
                detailsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MyBookingDetailsView(type: "completed"),
                    ),
                  );
                },
                firstBtnText: "Completed",
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget cancelledBookings() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => BookingCard(
                bookingName: "Activity",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.red,
                firstBtnTextColor: ThemeColors.bgColor,
                firstBtnPressed: () {},
                detailsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyBookingDetailsView(type: "cancelled"),
                    ),
                  );
                },
                firstBtnText: "Cancelled",
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
