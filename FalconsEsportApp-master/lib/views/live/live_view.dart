import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/live/components/custom_live_card.dart';
import 'package:falconsesportsapp/views/live_details/live_details_view.dart';
import 'package:falconsesportsapp/views/search_streaming/search_streaming_view.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchStreamingView(),
                          ),
                        );
                      },
                      child: Container(
                        height: MySize.size30,
                        width: MySize.size30,
                        decoration: BoxDecoration(
                          color: ThemeColors.borderColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: ThemeColors.grey3,
                          size: MySize.size20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size27),
                child: Text(
                  'Trending',
                  style: TextStyle(
                    color: ThemeColors.green,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size5),
              Padding(
                padding: Spacing.horizontal(MySize.size27),
                child: Text(
                  '#TwitchEsport',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size27),
                child: Row(
                  children: [
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size45,
                      textSize: MySize.size10,
                      backgroundColor: ThemeColors.green,
                      textColor: ThemeColors.mainColor,
                      text: "All",
                      weight: FontWeight.w500,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size8),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size92,
                      textSize: MySize.size10,
                      backgroundColor: Colors.transparent,
                      textColor: ThemeColors.grey1,
                      text: "Live Stream",
                      weight: FontWeight.w500,
                      onPressed: () {},
                    ),
                    SizedBox(width: MySize.size8),
                    FlexibleButton(
                      height: MySize.size20,
                      width: MySize.size72,
                      textSize: MySize.size10,
                      backgroundColor: Colors.transparent,
                      textColor: ThemeColors.grey1,
                      text: "Trending",
                      weight: FontWeight.w500,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size27),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CustomLiveCard(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LiveDetailsView(),
                              ),
                            );
                          },
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: MySize.size20,
                        ),
                    itemCount: 7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
