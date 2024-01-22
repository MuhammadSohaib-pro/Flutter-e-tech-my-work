import 'package:flutter/material.dart';
import 'package:nawaz_salon/Screens/employee_detail/employee_detail_view.dart';
import 'package:nawaz_salon/Screens/employees/components/employees_list_view_card.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';
import 'package:nawaz_salon/widgets/custom_textfields.dart';

class EmployeesView extends StatefulWidget {
  const EmployeesView({super.key});

  @override
  State<EmployeesView> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends State<EmployeesView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 30, 33, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Employees',
                  style: TextStyle(
                    color: ThemeColors.grey3,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: CustomButton8(
                    text: "Add New",
                    onPressed: () {
                      showCustomBottomSheet(context);
                    },
                    radius: 10,
                    backgroundColor: ThemeColors.yellow,
                    textColor: ThemeColors.bgColor,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: 15,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CustomEmployeesListViewCard(
              name: 'Mr. Jadson',
              image: '',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmployeeDetailView(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }

  showCustomBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Add Employee',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        height: 74,
                        width: 74,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: const ShapeDecoration(
                          color: ThemeColors.grey2,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 28,
                            color: ThemeColors.bgColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(33, 20, 33, 10),
                        child: CustomTextField13(
                          // controller: email,
                          hintText: "Name",
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
                        padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
                        child: CustomTextField13(
                          // controller: email,
                          hintText: "Email",
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
                        padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
                        child: CustomTextField13(
                          // controller: email,
                          hintText: "Contact",
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
                        padding: const EdgeInsets.fromLTRB(33, 10, 33, 20),
                        child: CustomTextField13(
                          // controller: email,
                          hintText: "Address",
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
            ),
          ),
        );
      },
    );
  }
}
