import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/generate_salary_view/genrate_salary.dart';
import 'components/employ_salary_card.dart';

class ManageEmployees extends StatelessWidget {
  final String? receiveTeamId;
  final String? receiveTeamName;
  
  ManageEmployees({super.key, this.receiveTeamId, this.receiveTeamName});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: AppBarWidget(
        // title: 'Designer Team',
        title: receiveTeamName!,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(children: [
          SizedBox(
            height: MySize.size20,
          ),
          TextFormField(
            style: poppineRegular.copyWith(fontSize: MySize.size12),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(MySize.size10)),
                contentPadding: EdgeInsets.all(MySize.size8),
                filled: true,
                isDense: true,
                fillColor: filledColor,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(MySize.size10),
                  child: Image.asset(
                    AppIcons.search,
                    height: MySize.size12,
                    width: MySize.size12,
                  ),
                )),
          ),
          SizedBox(
            height: MySize.size12,
          ),
          SizedBox(
            height: MySize.size20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('employees')
                .where('teamId', isEqualTo: receiveTeamId)
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Text(
                  'No thing found ',
                );
              } else if (!snapshot.hasData || snapshot.hasError) {
                return const Text('No data found ');
              } else {
                final employeeDocs = snapshot.data!.docs; // List of documents
                // print(employeeDocs);
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: MySize.size15,
                  ),
                  shrinkWrap: true,
                  itemCount: employeeDocs.length,
                  itemBuilder: (context, index) {
                    final employeeData =
                        employeeDocs[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenrateSalary(
                                      employeeData: employeeData,
                                    )));
                      },
                      child: EmployeSalaryCard(
                        name: employeeData['name'],
                        image: employeeData['image'],
                        team: employeeData['team'],
                        // currentStatus: employeeData[''],
                        type: employeeData['type'],
                        salary: employeeData['salary'],
                        salaryStatus: employeeData['salaryStatus'],
                      ),
                      // child: ManageEmployeDetailCard(
                      //   name: employeeData['name'],
                      //   image: employeeData['image'],
                      //   type: employeeData['team'],
                      //   // currentStatus: employeeData[''],
                      //   role: employeeData['role'],
                      //   totalSalary: employeeData['salary'],
                      // ),
                    );
                  },
                );
              }
            }),
          )
        ]),
      ),
    );
  }
}
