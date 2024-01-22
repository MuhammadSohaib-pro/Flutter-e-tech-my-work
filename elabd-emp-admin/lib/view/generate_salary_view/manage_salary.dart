import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/generate_salary_view/manage_employees.dart';
import 'components/manage_employe_list.dart';

class ManageSalary extends StatelessWidget {
  ManageSalary({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Manage Salary',
        isLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MySize.size20,
              ),
              TextFormField(
                style: poppineRegular.copyWith(fontSize: MySize.size12),
                decoration: InputDecoration(
                    hintText: 'Search',
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
                height: MySize.size30,
              ),
              // ListView.separated(
              //     separatorBuilder: (context, index) => SizedBox(
              //           height: MySize.size15,
              //         ),
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: 3,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //           onTap: () {
              //             Navigator.pushNamed(context, manageEmployeTeam);
              //           },
              //           child: EmployesListCard(
              //             title: 'Flutter',
              //           ));
              //     }),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('teams')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return const Text('There is some error');
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Text(
                        'No thing found ',
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: MySize.size15,
                              ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String teamName =
                                snapshot.data!.docs[index]['teamName'];
                            String image = snapshot.data!.docs[index]['image'];
                            String sendTeamId =
                                snapshot.data!.docs[index]['teamId'];
                            List<String> uids = List<String>.from(
                                snapshot.data!.docs[index]['uids'] ??
                                    []); // Assuming 'uids' is an array field
                            return GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ManageEmployees(
                                              receiveTeamId: sendTeamId,
                                              receiveTeamName: teamName,
                                            )));
                              },
                              child: ManageEmployeeList(
                                title: snapshot.data!.docs[index]['teamName'],
                                uidsCount: uids.length,
                                image: image,
                              ),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
