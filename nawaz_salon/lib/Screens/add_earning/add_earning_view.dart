import 'package:flutter/material.dart';
import 'package:nawaz_salon/Screens/add_earning/components/cstom_emp_card.dart';
import 'package:nawaz_salon/Screens/add_earning/components/cstom_emp_tile.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';
import 'package:nawaz_salon/widgets/custom_textfields.dart';

class AddEarningView extends StatefulWidget {
  const AddEarningView({super.key});

  @override
  State<AddEarningView> createState() => _AddEarningViewState();
}

class _AddEarningViewState extends State<AddEarningView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomEmployeeCard(),
          const Padding(
            padding: EdgeInsets.fromLTRB(33, 30, 33, 30),
            child: Divider(
              color: ThemeColors.grey3,
            ),
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomEmpListViewTile(
              image: '',
              price: 'Rs.10,879.00',
              name: 'Mr. Jadson',
              suffixIcon: index == 3 ? icAddCircle : icClock,
              onPressed: () {
                showCustomDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  showCustomDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          height: 400,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(33, 0, 33, 0),
          decoration: BoxDecoration(
              color: ThemeColors.bgColor,
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: Text(
                  'Add Payment',
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: ShapeDecoration(
                  color: Colors.amberAccent.shade100,
                  shape: const CircleBorder(),
                ),
              ),
              const Text(
                'Mr. Jadson',
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Rs.10,879.00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.yellow,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(33, 20, 33, 5),
                child: CustomTextField13(
                  // controller: email,
                  hintText: "Enter Amount",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  fillColor: Colors.transparent,
                  validator: (value) {
                    if (value == null) {
                      return "Field is required";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(33, 5, 33, 30),
                child: CustomTextField13(
                  // controller: email,
                  hintText: "Enter Description",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  fillColor: Colors.transparent,
                  validator: (value) {
                    if (value == null) {
                      return "Field is required";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: CustomButton8(
                      text: "Cancel",
                      radius: 10,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: ThemeColors.darkGrey,
                      textColor: ThemeColors.bgColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: CustomButton8(
                      text: "Add",
                      radius: 10,
                      onPressed: () {},
                      backgroundColor: ThemeColors.yellow,
                      textColor: ThemeColors.bgColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
