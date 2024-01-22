import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/home/components/custom_product_widget.dart';
import 'package:falconsesportsapp/views/rewards/components/custom_rewards_card.dart';
import 'package:falconsesportsapp/widgets/custom_dropdownbutton2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({super.key});

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            padding: Spacing.horizontal(MySize.size27),
            child: Text(
              'Team Liquid Rewards',
              style: TextStyle(
                color: ThemeColors.grey1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MySize.size8),
          Padding(
            padding: Spacing.horizontal(MySize.size27),
            child: Text(
              'Rewards',
              style: TextStyle(
                color: ThemeColors.bgColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: MySize.size18),
          Padding(
            padding: Spacing.left(MySize.size27),
            child: SizedBox(
              height: MySize.size180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const CustomRewardCard(),
                separatorBuilder: (context, index) =>
                    SizedBox(width: MySize.size20),
                itemCount: 3,
              ),
            ),
          ),
          SizedBox(height: MySize.size25),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rewards Products',
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
                            ],
                          ),
                          CustomDropdownButton2(
                            dropdownItems: const ["High - Low", "Low - High"],
                            hint: "Price",
                            value: selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value.toString();
                              });
                            },
                            buttonWidth: MySize.size116,
                            buttonHeight: MySize.size28,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: ThemeColors.grey1,
                              size: MySize.size18,
                            ),
                            buttonDecoration: BoxDecoration(
                              border: Border.all(style: BorderStyle.none),
                              color: ThemeColors.mainColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            dropdownDecoration: BoxDecoration(
                              color: ThemeColors.mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dropdownWidth: MySize.size116,
                          ),
                        ],
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) =>
                            const CustomProductWidget(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: MySize.size20),
                        itemCount: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
