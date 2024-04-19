import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/games_to_watch/games_to_watch_view.dart';
// import 'package:falconsesportsapp/views/home/components/custom_games_widget.dart';
import 'package:falconsesportsapp/views/home/components/custom_live_widget.dart';
// import 'package:falconsesportsapp/views/home/components/custom_product_widget.dart';
// import 'package:falconsesportsapp/views/home/components/custom_quests_widget.dart';
import 'package:falconsesportsapp/views/home/components/custom_story_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> nameList = [
    "boroscs",
    "MagiskCS",
    "SnappiCSGO",
    "BanderitaX",
    "byJoka",
    "xSMA333",
    "LLE_97",
    "Bo3omar22",
    "iopiiLz",
  ];
  List<String> imageList = [
    imgPone,
    imgPtwo,
    imgPthree,
    imgPfour,
    imgPfive,
    imgPsix,
    imgPseven,
    imgPeight,
    imgPnine,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MySize.size20),
          Padding(
            padding: Spacing.horizontal(MySize.size27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SvgPicture.asset(icEllipse),
                        Padding(
                          padding: Spacing.all(4),
                          child: Container(
                            width: MySize.size40,
                            height: MySize.size40,
                            decoration: const ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(imgPerson),
                                fit: BoxFit.cover,
                              ),
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: MySize.size10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3,876 pts',
                          style: TextStyle(
                            color: ThemeColors.green,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size6),
                        Text(
                          'Daniel!',
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: MySize.size30,
                //     width: MySize.size30,
                //     decoration: BoxDecoration(
                //       color: ThemeColors.borderColor,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Icon(
                //       Icons.search_rounded,
                //       color: ThemeColors.grey3,
                //       size: MySize.size20,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: MySize.size30),
          Padding(
            padding: Spacing.horizontal(MySize.size26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POPULAR',
                      style: TextStyle(
                        color: ThemeColors.green,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MySize.size2),
                    Text(
                      'Top Streamers',
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MySize.size18),
          Container(
            margin: Spacing.left(MySize.size27),
            height: MySize.size100,
            child: ListView.separated(
              itemCount: nameList.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  SizedBox(width: MySize.size10),
              itemBuilder: (context, index) {
                return (index == 0 || index == 1)
                    ? CustomLiveWidget(
                        image: imageList[index],
                        name: nameList[index],
                      )
                    : CustomStoryWidget(
                        image: imageList[index],
                        name: nameList[index],
                      );
              },
            ),
          ),
          SizedBox(height: MySize.size10),
          Padding(
            padding: Spacing.horizontal(MySize.size26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top  Games to Watch',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GamesToWatchView(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: MySize.size10),
          // Padding(
          //   padding: Spacing.left(MySize.size15),
          //   child: SizedBox(
          //     height: MySize.size240,
          //     child: ListView.separated(
          //       itemCount: 3,
          //       scrollDirection: Axis.horizontal,
          //       separatorBuilder: (context, index) =>
          //           SizedBox(width: MySize.size15),
          //       itemBuilder: (context, index) => const CustomGamesWidget(),
          //     ),
          //   ),
          // ),
          SizedBox(height: MySize.size10),
          Padding(
            padding: Spacing.horizontal(MySize.size26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quests',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: Spacing.left(MySize.size27),
          //   child: SizedBox(
          //     height: MySize.size171,
          //     child: ListView.separated(
          //       itemCount: 2,
          //       scrollDirection: Axis.horizontal,
          //       separatorBuilder: (context, index) =>
          //           SizedBox(width: MySize.size15),
          //       itemBuilder: (context, index) => const CustomQuestsWidget(),
          //     ),
          //   ),
          // ),
          SizedBox(height: MySize.size30),
          Padding(
            padding: Spacing.all(MySize.size27),
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: const Color(0x19D9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x23000000),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding: Spacing.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MORE FOR YOU',
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size5),
                      Text(
                        'Products',
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // ListView.separated(
                      //   itemBuilder: (context, index) =>
                      //       const CustomProductWidget(),
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   separatorBuilder: (context, index) =>
                      //       SizedBox(height: MySize.size20),
                      //   itemCount: 5,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MySize.size20),
        ],
      ),
    );
  }
}
