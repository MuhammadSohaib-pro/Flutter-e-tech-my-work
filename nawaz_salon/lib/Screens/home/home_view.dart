import 'package:flutter/material.dart';
import 'package:nawaz_salon/Screens/home/components/big_container.dart';
import 'package:nawaz_salon/Screens/home/components/home_list_view_card.dart';
import 'package:nawaz_salon/Screens/home/components/small_container.dart';

import 'package:nawaz_salon/helper/theme_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 30, 0, 20),
            child: Text(
              'Statistics',
              style: TextStyle(
                color: ThemeColors.grey3,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(33, 0, 9, 0),
                    child: CustomHomeContainerSmall(
                      title: 'Total Earning',
                      values: '3,668.98',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(9, 0, 33, 0),
                    child: CustomHomeContainerSmall(
                      title: "Total Revenue",
                      values: '306.98',
                    ),
                  ),
                )
              ],
            ),
          ),
          const Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(33, 0, 33, 25),
                child: CustomHomeContainerBig(
                  title: "This Month Earning",
                  values: 'Rs.10,09.00',
                ),
              ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(33, 0, 33, 30),
            child: Divider(
              color: ThemeColors.grey3,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(33, 0, 0, 30),
            child: Text(
              'Earning List',
              style: TextStyle(
                color: ThemeColors.grey3,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomHomeListViewCard(
              topFlag: index==0?true:false,
              name: "Mr.Jadson",
              price: 'Rs. 10879.00',
              commission: 'Rs. 20000 Commision',
            ),
          )
        ],
      ),
    );
  }
}
