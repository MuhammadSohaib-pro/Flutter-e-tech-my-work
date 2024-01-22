import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_list.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/app_constant.dart';
import '../../manage_task_view/manage_task_view.dart';
import '../all_employees.dart';

class HomeCart extends StatelessWidget {
  const HomeCart({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5 / 1,
            crossAxisSpacing: MySize.size10,
            mainAxisSpacing: MySize.size10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  // Navigator.pushNamed(context, manageTask, arguments: true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageTaskView(
                                isLeadingIcon: true,
                              )));

                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeList(
                                isLeadingIcon: true,
                              )));
                  break;
                case 2:
                  // Navigator.pushNamed(context, genrateSalary);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const AllEmployees()));
                  break;
                case 3:
                  Navigator.pushNamed(context, setting);

                  break;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(MySize.size4),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(2, 2),
                        color: blackColor.withOpacity(0.10))
                  ]),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    manageHomeIconList[index],
                    height: MySize.size25,
                    width: MySize.size30,
                  ),
                  SizedBox(
                    height: MySize.size14,
                  ),
                  Text(
                    manageHomeList[index],
                    style: poppinMedium.copyWith(
                        color: primaryColor, fontSize: MySize.size16),
                  )
                ],
              )),
            ),
          );
        });
  }
}
