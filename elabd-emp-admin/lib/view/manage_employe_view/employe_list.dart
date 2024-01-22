// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:elabd_ems_admin/helper/import_helper.dart';
// import 'package:elabd_ems_admin/view/manage_employe_view/employe_team.dart';
// import 'add_new_team.dart';
// import 'components/employes_list_card.dart';
// class EmployeList extends StatefulWidget {
//   final bool isLeadingIcon;
//   const EmployeList({super.key, this.isLeadingIcon = false});
//   @override
//   State<EmployeList> createState() => _EmployeListState();
// }
// class _EmployeListState extends State<EmployeList> {
//   final searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     MySize().init(context);
//     return Scaffold(
//         appBar: AppBarWidget(
//           title: 'Employe List',
//           isLeading: widget.isLeadingIcon,
//         ),
//         body: SafeArea(
//             child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: MySize.size14),
//                 child: Column(children: [
//                   SizedBox(
//                     height: MySize.size20,
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       print(value);
//                     },
//                     style: poppineRegular.copyWith(fontSize: MySize.size12),
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(MySize.size10)),
//                         contentPadding: EdgeInsets.all(MySize.size8),
//                         filled: true,
//                         isDense: true,
//                         fillColor: filledColor,
//                         prefixIcon: Padding(
//                           padding: EdgeInsets.all(MySize.size10),
//                           child: Image.asset(
//                             AppIcons.search,
//                             height: MySize.size12,
//                             width: MySize.size12,
//                           ),
//                         )),
//                   ),
//                   SizedBox(
//                     height: MySize.size12,
//                   ),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: SizedBox(
//                         height: MySize.size30,
//                         width: MySize.size90,
//                         child: ButtonWidget(
//                           borderRadius: 0,
//                           textColor: whiteColor,
//                           fontSize: MySize.size10,
//                           title: 'Add Team',
//                           ontap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AddNewTeam()));
//                           },
//                         ),
//                       )),
//                   SizedBox(
//                     height: MySize.size20,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('teams')
//                               .snapshots(),
//                           builder:
//                               (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (!snapshot.hasData) {
//                               return const Text('There is no Data Found');
//                             } else if (snapshot.hasError) {
//                               return Text(
//                                   'There is some Error ${snapshot.hasError}');
//                             } else if (snapshot.data!.docs.isEmpty) {
//                               return const Text(
//                                 'No thing found ',
//                               );
//                             } else if (snapshot.data!.docs.isEmpty) {
//                               return const Text(
//                                 'No User Foound please add New User',
//                               );
//                             } else if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             } else {
//                               return ListView.separated(
//                                   separatorBuilder: (context, index) =>
//                                       SizedBox(
//                                         height: MySize.size15,
//                                       ),
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: snapshot.data!.docs.length,
//                                   itemBuilder: (context, index) {
//                                     String teamName =
//                                         snapshot.data!.docs[index]['teamName'];
//                                     String sendTeamId =
//                                         snapshot.data!.docs[index]['teamId'];
//                                     List<String> uids = List<
//                                         String>.from(snapshot.data!.docs[index]
//                                             ['uids'] ??
//                                         []); // Assuming 'uids' is an array field
//                                     return GestureDetector(
//                                       onTap: () async {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     EmployeTeam(
//                                                       receiveTeamId: sendTeamId,
//                                                       receiveTeamName: teamName,
//                                                     )));
//                                       },
//                                       child: EmployesListCard(
//                                         title: snapshot.data!.docs[index]
//                                             ['teamName'],
//                                         uidsCount: uids.length,
//                                       ),
//                                     );
//                                   });
//                             }
//                           }),
//                     ),
//                   ),
//                 ]))));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/employe_team.dart';
import 'package:elabd_ems_admin/view/manage_employe_view/resigned_employee.dart';
import 'add_new_team.dart';
import 'components/employes_list_card.dart';

class EmployeList extends StatefulWidget {
  final bool isLeadingIcon;
  const EmployeList({super.key, this.isLeadingIcon = false});

  @override
  State<EmployeList> createState() => _EmployeListState();
}

class _EmployeListState extends State<EmployeList> {
  final searchController = TextEditingController();
  late Stream<QuerySnapshot> _teamsStream;

  @override
  void initState() {
    super.initState();
    _teamsStream = FirebaseFirestore.instance.collection('teams').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Employe List',
        isLeading: widget.isLeadingIcon,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MySize.size14),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResignedEmployee()));
                    },
                    child: Text(
                      'View Resigned Employee',
                      style: poppinBold.copyWith(
                          fontSize: MySize.size16, color: primaryColor),
                    ),
                  )),
              SizedBox(height: MySize.size20),
              TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                style: poppineRegular.copyWith(fontSize: MySize.size12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(MySize.size10),
                  ),
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
                  ),
                ),
              ),
              SizedBox(height: MySize.size12),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: SizedBox(
              //     height: 30,
              //     width: 90,
              //     child: ButtonWidget(
              //       borderRadius: 0,
              //       textColor: whiteColor,
              //       fontSize: MySize.size10,
              //       title: 'Add Team',
              //       ontap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => AddNewTeam()),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(height: MySize.size20),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _teamsStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('There is no Data Found');
                      } else if (snapshot.hasError) {
                        return Text('There is some Error ${snapshot.error}');
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Text('No thing found');
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final teams = snapshot.data!.docs;
                        final filteredTeams = teams.where((doc) {
                          final teamName =
                              doc['teamName'].toString().toLowerCase();
                          final searchText =
                              searchController.text.toLowerCase();
                          return teamName.contains(searchText);
                        }).toList();

                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: MySize.size15),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredTeams.length,
                          itemBuilder: (context, index) {
                            String teamName = filteredTeams[index]['teamName'];
                            String sendTeamId = filteredTeams[index]['teamId'];
                            String image = filteredTeams[index]['image'];

                            List<String> uids = List<String>.from(
                                filteredTeams[index]['uids'] ?? []);
                            return GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployeTeam(
                                      receiveTeamId: sendTeamId,
                                      receiveTeamName: teamName,
                                    ),
                                  ),
                                );
                              },
                              child: EmployesListCard(
                                title: teamName,
                                uidsCount: uids.length,
                                image: image,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewTeam()),
              );
            },
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
