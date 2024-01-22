import 'package:flutter/material.dart';
import 'package:nawaz_salon/Screens/manage_earning/components/emp_earning_tile.dart';
import 'package:nawaz_salon/Screens/manage_earning/components/manage_earning_card.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class ManageEarningView extends StatefulWidget {
  const ManageEarningView({super.key});

  @override
  State<ManageEarningView> createState() => _ManageEarningViewState();
}

class _ManageEarningViewState extends State<ManageEarningView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(33, 30, 33, 35),
                  child: CustomManageEarningCard(
                    title: "This Month Earning",
                    values: 'Rs.10,09.00',
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(33, 0, 33, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Employees Earning',
                  style: TextStyle(
                    color: ThemeColors.grey3,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: ThemeColors.bgColor,
                    ),
                    Text(
                      'September ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: ThemeColors.bgColor,
                    )
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const CustomEmpTile(
              name: 'Mr. Jadson',
              price: 'Rs.10,879.00',
              commission: 'Rs.200.00 Commission',
              topFlag: true,
            ),
          ),
        ],
      ),
    );
  }
}
