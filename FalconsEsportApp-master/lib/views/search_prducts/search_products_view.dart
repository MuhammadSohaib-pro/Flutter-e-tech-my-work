import 'package:falconsesportsapp/helper/common_functions.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/product_details/product_details_view.dart';
import 'package:falconsesportsapp/views/store/components/store_item_card.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:falconsesportsapp/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class SearchProductsView extends StatefulWidget {
  const SearchProductsView({super.key});

  @override
  State<SearchProductsView> createState() => _SearchProductsViewState();
}

class _SearchProductsViewState extends State<SearchProductsView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField13(
                        controller: searchController,
                        prefixIcon: Padding(
                          padding: Spacing.all(MySize.size12),
                          child: Icon(
                            Icons.search_rounded,
                            color: ThemeColors.grey3,
                            size: MySize.size20,
                          ),
                        ),
                        hintText: "Search Live Stream",
                        radius: 30,
                        fillColor: ThemeColors.fillColor,
                        keyboardType: TextInputType.text,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            CommonFunctions.validateTextField(value),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: ThemeColors.green,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
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
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: Text(
                  'Search Result',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: Text(
                  '1000+',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size30),
              GridView.builder(
                itemCount: 6,
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
        ),
      ),
    );
  }
}
