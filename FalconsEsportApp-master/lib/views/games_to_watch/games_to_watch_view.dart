import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/games_to_watch/components/game_tile_widget.dart';
import 'package:falconsesportsapp/views/games_to_watch/components/games_card.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class GamesToWatchView extends StatefulWidget {
  const GamesToWatchView({super.key});

  @override
  State<GamesToWatchView> createState() => _GamesToWatchViewState();
}

class _GamesToWatchViewState extends State<GamesToWatchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Games to Watch',
          style: TextStyle(
            color: ThemeColors.bgColor,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: Spacing.left(MySize.size27),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size45,
                      backgroundColor: ThemeColors.green,
                      text: "All",
                      textColor: ThemeColors.mainColor,
                      textSize: MySize.size10,
                      weight: FontWeight.w500,
                      radius: 30,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size10),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size105,
                      backgroundColor: ThemeColors.mainColor,
                      text: "Shooting Game",
                      textColor: ThemeColors.grey1,
                      textSize: MySize.size10,
                      weight: FontWeight.w500,
                      radius: 30,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size10),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size80,
                      backgroundColor: ThemeColors.mainColor,
                      text: "Car Game",
                      textColor: ThemeColors.grey1,
                      textSize: MySize.size10,
                      weight: FontWeight.w500,
                      radius: 30,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size10),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size145,
                      backgroundColor: ThemeColors.mainColor,
                      text: "New Upcoming Streams",
                      textColor: ThemeColors.grey1,
                      textSize: MySize.size10,
                      weight: FontWeight.w500,
                      radius: 30,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size10),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size105,
                      backgroundColor: ThemeColors.mainColor,
                      text: "Bike Game",
                      textColor: ThemeColors.grey1,
                      textSize: MySize.size10,
                      weight: FontWeight.w500,
                      radius: 30,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MySize.size35),
            Padding(
              padding: Spacing.left(MySize.size27),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const GamesCard(
                      backgroundColor: ThemeColors.grey6,
                      borderColor: ThemeColors.green,
                    ),
                    SizedBox(width: MySize.size20),
                    const GamesCard(
                      backgroundColor: ThemeColors.green,
                      borderColor: ThemeColors.bgColor,
                    ),
                    SizedBox(width: MySize.size20),
                    const GamesCard(
                      backgroundColor: ThemeColors.grey6,
                      borderColor: ThemeColors.green,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MySize.size30),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Color(0x19D9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x23000000),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: Spacing.all(MySize.size27),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              const GameTileWidget(),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              Column(children: [
                            SizedBox(height: MySize.size5),
                            Divider(color: ThemeColors.bgColor.withOpacity(.1),),
                            SizedBox(height: MySize.size5),
                          ]),
                          itemCount: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
