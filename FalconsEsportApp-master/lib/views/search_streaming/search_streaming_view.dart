import 'package:falconsesportsapp/helper/common_functions.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/live/components/custom_live_card.dart';
import 'package:falconsesportsapp/views/live_details/live_details_view.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:falconsesportsapp/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';

class SearchStreamingView extends StatefulWidget {
  const SearchStreamingView({super.key});

  @override
  State<SearchStreamingView> createState() => _SearchStreamingViewState();
}

class _SearchStreamingViewState extends State<SearchStreamingView> {
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
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      ),
    );
  }
}
