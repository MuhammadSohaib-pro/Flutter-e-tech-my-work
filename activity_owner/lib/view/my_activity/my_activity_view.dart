import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/my_activity/components/my_activity_card.dart';
import 'package:activity_owner/view/my_activity/provider/my_activity_provider.dart';
import 'package:activity_owner/view/my_activity_detail/my_activity_detail_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyActivityView extends StatefulWidget {
  const MyActivityView({super.key});

  @override
  State<MyActivityView> createState() => _MyActivityViewState();
}

class _MyActivityViewState extends State<MyActivityView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        SizedBox(height: MySize.size15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Consumer<MyActivityProvider>(
            builder: (context, provider, child) => Row(
              children: [
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: AppLocalizations.of(context)!.all.toString(),
                  isSelected: provider.tabIndex == 0 ? true : false,
                  onPressed: () {
                    provider.settabValue(0);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: AppLocalizations.of(context)!.underReview.toString(),
                  isSelected: provider.tabIndex == 1 ? true : false,
                  onPressed: () {
                    provider.settabValue(1);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: AppLocalizations.of(context)!.active.toString(),
                  isSelected: provider.tabIndex == 2 ? true : false,
                  onPressed: () {
                    provider.settabValue(2);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: AppLocalizations.of(context)!.deactive.toString(),
                  isSelected: provider.tabIndex == 3 ? true : false,
                  onPressed: () {
                    provider.settabValue(3);
                  },
                ),
                SizedBox(width: MySize.size5),
                CustomTabButton(
                  text: AppLocalizations.of(context)!.rejected.toString(),
                  isSelected: provider.tabIndex == 4 ? true : false,
                  onPressed: () {
                    provider.settabValue(4);
                  },
                ),
                SizedBox(width: MySize.size5),
              ],
            ),
          ),
        ),
        Consumer<MyActivityProvider>(
          builder: (context, provider, child) => provider.tabIndex == 0
              ? allActivites()
              : provider.tabIndex == 1
                  ? underReviewActivites()
                  : provider.tabIndex == 2
                      ? activeActivities()
                      : provider.tabIndex == 3
                          ? deactivatedActivities()
                          : provider.tabIndex == 4
                              ? rejectedActivies()
                              : Container(),
        ),
      ],
    );
  }

  Widget noActivties() {
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(imgNoActivities),
          Text(
            AppLocalizations.of(context)!.activitiesNotAvailable.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.mainColor,
              fontSize: MySize.size16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            AppLocalizations.of(context)!
                .activitiesNotAvailableDescrp
                .toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ThemeColors.grey1,
              fontSize: MySize.size12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget allActivites() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyActivityDetailsView(),
                    ),
                  );
                },
                child: MyActivitiesCard(
                  image: "",
                  activityName: "Activity Name",
                  location: "Saudi Arabia, Riyadh",
                  rating: "5.0",
                  totalRating: "13",
                  amount: "799.00",
                  status: index == 0
                      ? AppLocalizations.of(context)!.active.toString()
                      : index == 1
                          ? AppLocalizations.of(context)!.deactive.toString()
                          : index == 2
                              ? AppLocalizations.of(context)!
                                  .underReview
                                  .toString()
                              : AppLocalizations.of(context)!
                                  .rejected
                                  .toString(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget underReviewActivites() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyActivityDetailsView(),
                    ),
                  );
                },
                child: MyActivitiesCard(
                  image: "",
                  activityName: "Activity Name",
                  location: "Saudi Arabia, Riyadh",
                  rating: "5.0",
                  totalRating: "13",
                  amount: "799.00",
                  status: AppLocalizations.of(context)!.underReview.toString(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget activeActivities() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyActivityDetailsView(),
                    ),
                  );
                },
                child: MyActivitiesCard(
                  image: "",
                  activityName: "Activity Name",
                  location: "Saudi Arabia, Riyadh",
                  rating: "5.0",
                  totalRating: "13",
                  amount: "799.00",
                  status: AppLocalizations.of(context)!.active.toString(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget deactivatedActivities() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyActivityDetailsView(),
                    ),
                  );
                },
                child: MyActivitiesCard(
                  image: "",
                  activityName: "Activity Name",
                  location: "Saudi Arabia, Riyadh",
                  rating: "5.0",
                  totalRating: "13",
                  amount: "799.00",
                  status: AppLocalizations.of(context)!.deactivated.toString(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget rejectedActivies() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: MySize.size30),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyActivityDetailsView(),
                    ),
                  );
                },
                child: MyActivitiesCard(
                  image: "",
                  activityName: "Activity Name",
                  location: "Saudi Arabia, Riyadh",
                  rating: "5.0",
                  totalRating: "13",
                  amount: "799.00",
                  status: AppLocalizations.of(context)!.rejected.toString(),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: MySize.size10,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
