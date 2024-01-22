import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/routes/routes_const.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_details.dart';
import '../generate_salary_view/components/manage_employe_detail_card.dart';

class EmployeTeam extends StatefulWidget {
  final String? receiveTeamId;
  final String? receiveTeamName;
  const EmployeTeam({
    super.key,
    this.receiveTeamId,
    this.receiveTeamName,
  });

  @override
  State<EmployeTeam> createState() => _EmployeTeamState();
}

class _EmployeTeamState extends State<EmployeTeam> {
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
        title: widget.receiveTeamName!,
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
          // Align(
          //     alignment: Alignment.centerRight,
          //     child: SizedBox(
          //       height: MySize.size30,
          //       width: MySize.size90,
          //       child: ButtonWidget(
          //         borderRadius: 0,
          //         textColor: whiteColor,
          //         fontSize: MySize.size10,
          //         title: 'Add',
          //         ontap: () {
          //           Navigator.pushNamed(context, addnewEmploye);
          //         },
          //       ),
          //     )),
          SizedBox(
            height: MySize.size20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .where('teamId', isEqualTo: widget.receiveTeamId)
                    .where('status', isEqualTo: 'Active')
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
                      'No User Foound please add New User',
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
                                          receiveId: widget.receiveTeamId,
                                          receiveName: widget.receiveTeamName,
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
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, addnewEmploye),
            child: Container(
              width: double.infinity,
              height: 47,
              decoration: ShapeDecoration(
                color: const Color(0xFF055E13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                  child: Text(
                "Add Team",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        )
      ],
    );
  }
}
