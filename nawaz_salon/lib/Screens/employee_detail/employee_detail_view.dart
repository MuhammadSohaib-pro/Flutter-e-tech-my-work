import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/Screens/employee_detail/components/cstm_emp_daily_detail_tile.dart';
import 'package:nawaz_salon/Screens/employee_detail/components/cstm_emp_monthly_detail_tile.dart';
import 'package:nawaz_salon/Screens/employee_detail/components/detail_big_container.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class EmployeeDetailView extends StatefulWidget {
  const EmployeeDetailView({super.key});

  @override
  State<EmployeeDetailView> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        toolbarHeight: 100,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: 141,
            height: 64,
            child: SvgPicture.asset(imgLogo),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(33, 30, 33, 30),
                    child: CustomEmpDetailContainerBig(),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(33, 0, 33, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Earning',
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
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          'September ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
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
            const CustomEmpMonthlyDetailTile(),
            const Padding(
              padding: EdgeInsets.fromLTRB(33, 0, 33, 0),
              child: Divider(
                color: ThemeColors.grey3,
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const CustomEmpDailyDetailTile(),
            ),
          ],
        ),
      ),
    );
  }
}

