import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/add_post/step1/add_post_one_view.dart';
import 'package:activity_owner/view/bottom_nav_bar/provider/nav_bar_provider.dart';
import 'package:activity_owner/view/home/home_view.dart';
import 'package:activity_owner/view/menu/menu_view.dart';
import 'package:activity_owner/view/my_activity/my_activity_view.dart';
import 'package:activity_owner/view/my_bookings/my_bookings_view.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

List<Widget> screensList = [
  const HomeView(),
  const MyBookingView(),
  Container(color: Colors.green), //not used bcz its setting for bottom nav bar
  const MyActivityView(),
  Container(color: Colors.cyanAccent),
];

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  Widget build(BuildContext context) {
    List<String> appBarTitleList = [
      AppLocalizations.of(context)!.home.toString(),
      "Bookings",
      "", //not used bcz its setting for bottom nav bar
      AppLocalizations.of(context)!.myActivities.toString(),
      "My Store",
    ];
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          extendBody: true,
          backgroundColor: const Color(0xFFF1F5FF),
          appBar: AppBar(
            leading: Padding(
              padding: Spacing.symmetric(horizontal: 16, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: SvgPicture.asset(icMenu),
              ),
            ),
            title: Text(
              appBarTitleList[provider.bottomIndex],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: Spacing.symmetric(horizontal: MySize.size16),
                child: SvgPicture.asset(
                  icBell,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          body: screensList[provider.bottomIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPostOneView(),
                ),
              );
            },
            child: Transform(
              transform: Matrix4.identity()
                ..translate(-10.0, 22.0)
                ..rotateZ(-0.79),
              child: Container(
                width: MySize.size48,
                height: MySize.size48,
                decoration: ShapeDecoration(
                  color: ThemeColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MySize.size10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x052538E8),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close_rounded,
                  color: ThemeColors.bgColor,
                  size: MySize.size34,
                ),
              ),
            ),
          ),
          bottomNavigationBar: DotNavigationBar(
            marginR: Spacing.fromLTRB(
                MySize.size32, 0, MySize.size32, MySize.size20),
            backgroundColor: ThemeColors.mainDark,
            currentIndex: provider.bottomIndex,
            dotIndicatorColor: ThemeColors.mainColor,
            splashColor: Colors.transparent,
            enableFloatingNavBar: true,
            onTap: (p0) {
              if (p0 == 2) {
              } else {
                provider.setBottomValue(p0);
              }
            },
            items: [
              DotNavigationBarItem(
                icon: provider.bottomIndex == 0
                    ? SvgPicture.asset(icHome)
                    : SvgPicture.asset(icHomeOutlined),
              ),
              DotNavigationBarItem(
                icon: provider.bottomIndex == 1
                    ? SvgPicture.asset(icCalender)
                    : SvgPicture.asset(icCalenderOutlined),
              ),
              DotNavigationBarItem(
                icon: SvgPicture.asset(
                  icPost,
                  color: ThemeColors.mainDark,
                ),
              ),
              DotNavigationBarItem(
                icon: provider.bottomIndex == 3
                    ? SvgPicture.asset(icPost)
                    : SvgPicture.asset(icPostOutlined),
              ),
              DotNavigationBarItem(
                icon: provider.bottomIndex == 4
                    ? SvgPicture.asset(icStoreFrontFill)
                    : SvgPicture.asset(icStoreFront),
              ),
            ],
          ),
        );
      },
    );
  }

  paymentDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size30),
          ),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2B000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Payment Method',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://iconape.com/wp-content/files/yo/366974/png/366974.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MySize.size50),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade500,
                              size: 18,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/128/5977/5977576.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MySize.size50),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade500,
                              size: 18,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/128/6124/6124998.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MySize.size50),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade500,
                              size: 18,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/128/5968/5968397.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MySize.size50),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey.shade500,
                              size: 18,
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://iconape.com/wp-content/files/hi/366497/png/366497.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MySize.size50),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey.shade500,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
