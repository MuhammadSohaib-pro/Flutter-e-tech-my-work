import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_details.dart';
import '../generate_salary_view/components/manage_employe_detail_card.dart';

class ResignedEmployee extends StatefulWidget {
  const ResignedEmployee({
    super.key,
  });

  @override
  State<ResignedEmployee> createState() => _ResignedEmployeeState();
}

class _ResignedEmployeeState extends State<ResignedEmployee> {
  @override
  void initState() {
    super.initState();
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);

    return Scaffold(
      appBar: AppBarWidget(
        // title: 'Designer Team',
        title: 'Resigned Employees',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(children: [
          SizedBox(
            height: MySize.size20,
          ),
          TextFormField(
            onChanged: (value) {},
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
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .where('status', isEqualTo: 'Deleted')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.hasError) {
                    return const Text('No data found ');
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Text(
                      'No Resigned User Foound',
                    );
                  } else {
                    final employeeDocs =
                        snapshot.data!.docs; // List of documents
                    debugPrint(employeeDocs.toString());
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
                                    builder: (context) => EmployeDetails(
                                          employeeData: employeeData,
                                        )));
                          },
                          child: ManageEmployeDetailCard(
                            name: employeeData['name'],
                            image: employeeData['image'],
                            type: employeeData['type'],
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
