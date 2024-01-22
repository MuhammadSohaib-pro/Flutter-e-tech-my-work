import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/home/components/booking_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MySize.size30),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Text(
            AppLocalizations.of(context)!.newBookings.toString(),
            style: TextStyle(
              color: ThemeColors.black1,
              fontSize: MySize.size14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        CarouselSlider.builder(
          itemCount: 5,
          options: CarouselOptions(
            height: MySize.size193,
            aspectRatio: (16 / 9),
            viewportFraction: 1.2,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayCurve: Curves.easeIn,
            onPageChanged: (index, reason) {
              // provider.setIndicatorIndex(index);
            },
          ),
          itemBuilder: (context, index, realIndex) => Container(
            width: MySize.screenWidth,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(imgCarasolBg), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: Spacing.fromLTRB(0, MySize.size30, 0, 0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(imgBike),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: Spacing.horizontal(MySize.size19),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .bikeEventTomorrow
                                        .toString(),
                                    style: TextStyle(
                                      color: ThemeColors.bgColor,
                                      fontSize: MySize.size16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: MySize.size8),
                                Padding(
                                  padding: Spacing.horizontal(MySize.size19),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .bikeEventTomorrowDescrp
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                                0.3400000035762787),
                                            fontSize: MySize.size10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: Spacing.horizontal(MySize.size14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MySize.size85,
                              height: MySize.size25,
                              decoration: ShapeDecoration(
                                color: Colors.white
                                    .withOpacity(0.3400000035762787),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    color: Colors.white
                                        .withOpacity(0.4399999976158142),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .decline
                                    .toString(),
                                style: TextStyle(
                                  color: ThemeColors.bgColor,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(width: MySize.size10),
                            Container(
                              width: MySize.size85,
                              height: MySize.size25,
                              decoration: ShapeDecoration(
                                color: Colors.white
                                    .withOpacity(0.3400000035762787),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    color: Colors.white
                                        .withOpacity(0.4399999976158142),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.accept.toString(),
                                style: TextStyle(
                                  color: ThemeColors.bgColor,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MySize.size16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: MySize.size30),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Text(
            AppLocalizations.of(context)!.upcomingBookings.toString(),
            style: TextStyle(
              color: ThemeColors.black1,
              fontSize: MySize.size14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Text(
            AppLocalizations.of(context)!.upcomingBookingsDescrp.toString(),
            style: TextStyle(
              color: ThemeColors.grey1,
              fontSize: MySize.size10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Expanded(
          child: ListView.separated(
            itemCount: 7,
            separatorBuilder: (context, index) =>
                SizedBox(height: MySize.size10),
            itemBuilder: (context, index) {
              return BookingCard(
                bookingName: "Padel",
                bookingId: "73515318351",
                date: "Wednesday 17 April, 2023",
                time: "11:00 AM - 01:00 PM",
                firstBtnColor: ThemeColors.mainDark,
                firstBtnTextColor: ThemeColors.bgColor,
                firstBtnPressed: () {},
                firstBtnText: "Active",
              );
            },
          ),
        ),
        SizedBox(height: MySize.size20),
      ],
    );
  }
}
