import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/generate_salary_view/genrate_salary.dart';
import '../generate_salary_view/components/employ_salary_card.dart';

class AllEmployees extends StatelessWidget {
  const AllEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'All Employee',
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size16),
        child: Column(
          children: [
            SizedBox(
              height: MySize.size10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .where('role', isEqualTo: 'user')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Text(
                      'No thing found ',
                    );
                  } else if (snapshot.hasError) {
                    return const Text('There is some Error');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = snapshot.data!.docs;
                    return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: MySize.size10,
                            ),
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final employeeData =
                              data[index].data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contxt) => GenrateSalary(
                                            employeeData: employeeData,
                                          )));
                            },
                            child: EmployeSalaryCard(
                              image: employeeData['image'],
                              name: employeeData['name'],
                              team: employeeData['team'],
                              salary: employeeData['salary'],
                              type: employeeData['type'],
                              salaryStatus: employeeData['salaryStatus'],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
