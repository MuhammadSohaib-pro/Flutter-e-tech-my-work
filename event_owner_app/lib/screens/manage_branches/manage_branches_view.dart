// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:event_owner_app/helper/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManageBranchesView extends StatefulWidget {
  const ManageBranchesView({super.key});

  @override
  State<ManageBranchesView> createState() => _ManageBranchesViewState();
}

class _ManageBranchesViewState extends State<ManageBranchesView> {
  List<BranchModel> branchList = [];
  String? reference = "";


  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.size70),
              StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String? ref = "";
                          String? image = "";
                          var data = snapshot.data!.docs;
                          var id = FirebaseAuth.instance.currentUser!.uid;
                          for (var i = 0; i < data.length; i++) {
                            if (id == data[i].get("ownerId")) {
                              ref = data[i].reference.id;
                              reference = data[i].reference.id;
                              image=data[i].get("image");
                            }
                          }
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("restaurants")
                                .doc(ref)
                                .collection("branches")
                                .snapshots(),
                            builder: (context, sp) {
                              if (sp.hasData) {
                                var newData = sp.data!.docs.toList();
                                branchList.clear();
                                branchList.addAll(newData.map(
                                    (e) => BranchModel.fromJson(e.data())));
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BranchDetailsView(
                                            restaurantRef: reference!,
                                            branchRef: newData[index]
                                                .reference
                                                .id
                                                .toString(),
                                            managerDocId: branchList[index]
                                                .managerDocId
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: BranchCard(
                                      image: image ?? "",
                                      backgroundColor: ThemeColors.bgColor,
                                      address: branchList[index].address ?? "",
                                      branchtype: AppLocalizations.of(context)!
                                          .active
                                          .toString(),
                                      btncolor: ThemeColors.mainColor,
                                      textColor: ThemeColors.bgColor,
                                      name: branchList[index].name ?? "",
                                      nameColor: ThemeColors.black1,
                                      addressColor: ThemeColors.black1,
                                      iconColor: ThemeColors.mainColor,
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: MySize.size10,
                                  ),
                                  itemCount: branchList.length,
                                );
                              } else {
                                return SizedBox(
                                  height: MySize.safeHeight,
                                  width: MySize.safeWidth,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return SizedBox(
                            height: MySize.safeHeight,
                            width: MySize.safeWidth,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
        Container(
          height: MySize.size60,
          color: ThemeColors.bgColor,
          child: Padding(
            padding: Spacing.horizontal(MySize.size32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: SvgPicture.asset(icMenu, color: ThemeColors.black1),
                  );
                }),
                Text(
                  AppLocalizations.of(context)!.manageBranches.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditBranchView(
                            type: "add", branchRef: "", restaurantRef: reference!),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.mainColor,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
