import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/product_details/product_details_view.dart';
import 'package:falconsesportsapp/views/search_prducts/search_products_view.dart';
import 'package:falconsesportsapp/views/store/components/store_card_widget.dart';
import 'package:falconsesportsapp/views/store/components/store_item_card.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchProductsView(),
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
                )
              ],
            ),
          ),
          SizedBox(height: MySize.size43),
          SizedBox(
            height: MySize.size150,
            child: Padding(
              padding: Spacing.left(MySize.size27),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const StoreCardWidget(),
                separatorBuilder: (context, index) =>
                    SizedBox(width: MySize.size10),
                itemCount: 5,
              ),
            ),
          ),
          Padding(
            padding: Spacing.horizontal(MySize.size27),
            child: Text(
              'Categories',
              style: TextStyle(
                color: ThemeColors.bgColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MySize.size10),
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
                    width: MySize.size68,
                    backgroundColor: ThemeColors.mainColor,
                    text: "Popular",
                    textColor: ThemeColors.grey1,
                    textSize: MySize.size10,
                    weight: FontWeight.w500,
                    radius: 30,
                    onPressed: () {},
                  ),
                  SizedBox(width: MySize.size10),
                  FlexibleButton(
                    height: MySize.size20,
                    width: MySize.size53,
                    backgroundColor: ThemeColors.mainColor,
                    text: "New",
                    textColor: ThemeColors.grey1,
                    textSize: MySize.size10,
                    weight: FontWeight.w500,
                    radius: 30,
                    onPressed: () {},
                  ),
                  SizedBox(width: MySize.size10),
                  FlexibleButton(
                    height: MySize.size20,
                    width: MySize.size69,
                    backgroundColor: ThemeColors.mainColor,
                    text: "Apparel",
                    textColor: ThemeColors.grey1,
                    textSize: MySize.size10,
                    weight: FontWeight.w500,
                    radius: 30,
                    onPressed: () {},
                  ),
                  SizedBox(width: MySize.size10),
                  FlexibleButton(
                    height: MySize.size20,
                    width: MySize.size82,
                    backgroundColor: ThemeColors.mainColor,
                    text: "Collections",
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
          SizedBox(height: MySize.size30),
          GridView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: MySize.size12,
                mainAxisSpacing: MySize.size14,
                mainAxisExtent: MySize.size215),
            padding: Spacing.horizontal(MySize.size25),
            itemBuilder: (context, index) => StoreItemCard(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailsView(),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MySize.size30),
        ],
      ),
    );
  }
}
