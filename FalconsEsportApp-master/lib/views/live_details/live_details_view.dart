// ignore_for_file: deprecated_member_use

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/live/components/custom_live_card.dart';
import 'package:falconsesportsapp/views/live_streaming/live_streaming_view.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class LiveDetailsView extends StatefulWidget {
  const LiveDetailsView({super.key});

  @override
  State<LiveDetailsView> createState() => _LiveDetailsViewState();
}

class _LiveDetailsViewState extends State<LiveDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: ThemeColors.bgColor,
                height: MySize.size280,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: Spacing.left(MySize.size24),
                                child: Text(
                                  'PUBG\nGameplay',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: MySize.size8),
                              Padding(
                                padding: Spacing.left(MySize.size24),
                                child: Text(
                                  'Playerunknown’s\nBattlegrounds',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size18,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: Spacing.left(MySize.size24),
                            child: Row(
                              children: [
                                Container(
                                  width: MySize.size70,
                                  height: MySize.size20,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFDF0815),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        icStream,
                                        color: ThemeColors.bgColor,
                                      ),
                                      Text(
                                        'Live',
                                        style: TextStyle(
                                          color: ThemeColors.bgColor,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: MySize.size10),
                                Container(
                                  width: MySize.size70,
                                  height: MySize.size20,
                                  decoration: ShapeDecoration(
                                    color: const Color(0x7CBFBFBF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.visibility_outlined,
                                        size: MySize.size18,
                                        color: ThemeColors.mainColor,
                                      ),
                                      Text(
                                        '83k',
                                        style: TextStyle(
                                          color: ThemeColors.mainColor,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Image.asset(imgPubgPng),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MySize.size250),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: ThemeColors.mainColor,
                  ),
                  child: Padding(
                    padding: Spacing.horizontal(MySize.size24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MySize.size22),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'PUBG ',
                                style: TextStyle(
                                  color: ThemeColors.bgColor,
                                  fontSize: MySize.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Playerunknow’s Battelgrouds\n',
                                style: TextStyle(
                                  color: ThemeColors.bgColor,
                                  fontSize: MySize.size14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: 'Gameplay',
                                style: TextStyle(
                                  color: ThemeColors.bgColor,
                                  fontSize: MySize.size14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MySize.size10),
                        Row(
                          children: [
                            Container(
                              width: MySize.size6,
                              height: MySize.size6,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF644593),
                                shape: OvalBorder(),
                              ),
                            ),
                            SizedBox(width: MySize.size10),
                            const Text(
                              '10 Players',
                              style: TextStyle(
                                color: Color(0xFFB0703B),
                                fontSize: 10,
                                fontFamily: 'Josefin Sans',
                                fontWeight: FontWeight.w400,
                                height: 0.14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.size20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSocialButton(
                                text: "Like",
                                onPressed: () {},
                                image: icHeart,
                                textColor: ThemeColors.bgColor,
                                backgroundColor: Colors.white
                                    .withOpacity(0.10999999940395355),
                                radius: 30,
                              ),
                            ),
                            SizedBox(width: MySize.size20),
                            Expanded(
                              child: CustomSocialButton(
                                text: "Share",
                                onPressed: () {},
                                image: icShare,
                                textColor: ThemeColors.bgColor,
                                backgroundColor: Colors.white
                                    .withOpacity(0.10999999940395355),
                                radius: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.size20),
                        Text(
                          'About',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: MySize.size34,
                          height: MySize.size2,
                          decoration: const BoxDecoration(
                            color: ThemeColors.green,
                          ),
                        ),
                        SizedBox(height: MySize.size20),
                        ReadMoreText(
                          'Welcome to the heart of the pub experience brought directly to your screen! Our live stream transports you into the lively ambiance of a traditional pub, where the clinking of glasses, laughter, and vibrant conversations converge. Join us virtually and soak in the authentic pub atmosphere from the comfort of your home.\n\nImmerse yourself in the rich tapestry of our live stream, where the charming decor and warm lighting create the perfect backdrop for an evening of camaraderie. From the crackling sounds of the fireplace to the rustic wooden interiors, every detail is designed to capture the essence of a classic pub.',
                          trimLines: 5,
                          colorClickableText: const Color(0xFFB0703B),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read More',
                          trimExpandedText: 'Less',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                          lessStyle: TextStyle(
                            color: const Color(0xFFB0703B),
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                          moreStyle: TextStyle(
                            color: const Color(0xFFB0703B),
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: MySize.size30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Related',
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
                        SizedBox(height: MySize.size10),
                        SizedBox(
                          height: MySize.size207,
                          width: MySize.safeWidth,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: MySize.size15),
                            itemBuilder: (context, index) => SizedBox(
                              height: MySize.size207,
                              width: MySize.size300,
                              child: CustomLiveCard(
                                onPressed: () {},
                              ),
                            ),
                            itemCount: 3,
                          ),
                        ),
                        SizedBox(height: MySize.size40),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: Spacing.fromLTRB(
              MySize.size27, MySize.size14, MySize.size27, MySize.size20),
          child: CustomSocialButton(
            text: "Watch Now",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LiveStreamingView(),
                ),
              );
            },
            image: icWatchNow,
            textColor: ThemeColors.bgColor,
            backgroundColor: Colors.white.withOpacity(0.10999999940395355),
            radius: 30,
          ),
        )
      ],
    );
  }
}
