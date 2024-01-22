import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/home/components/custom_quests_widget.dart';
import 'package:falconsesportsapp/views/quests/components/recent_point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestsView extends StatefulWidget {
  const QuestsView({super.key});

  @override
  State<QuestsView> createState() => _QuestsViewState();
}

class _QuestsViewState extends State<QuestsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: MySize.size43),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Available Points',
                  style: TextStyle(
                    color: const Color(0xFF05612D),
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '18 420.81',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size36,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: MySize.size16),
        Padding(
          padding: Spacing.horizontal(MySize.size27),
          child: Text(
            'Recent Points',
            style: TextStyle(
              color: ThemeColors.bgColor,
              fontSize: MySize.size12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        SizedBox(
          height: MySize.size100,
          child: Padding(
            padding: Spacing.left(MySize.size27),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const RecentPointWidget(),
              separatorBuilder: (context, index) =>
                  SizedBox(width: MySize.size10),
              itemCount: 5,
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 890,
            decoration: ShapeDecoration(
              color: ThemeColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 20,
                  offset: Offset(0, -4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: Spacing.fromLTRB(
                  MySize.size26, MySize.size18, MySize.size26, MySize.size18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quests',
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MySize.size30),
                    ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: MySize.size15),
                      itemBuilder: (context, index) =>
                          const CustomQuestsWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
