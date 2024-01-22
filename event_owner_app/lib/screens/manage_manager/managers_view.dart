// ignore_for_file: deprecated_member_use

import 'package:event_owner_app/helper/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagersView extends StatefulWidget {
  const ManagersView({super.key});

  @override
  State<ManagersView> createState() => _ManagersViewState();
}

class _ManagersViewState extends State<ManagersView> {
  String image = "";
  @override
  Widget build(BuildContext context) {
    List<ManagerModel> managerList = [];
    MySize().init(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.size80),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("restaurants")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String ref = "";
                    var data = snapshot.data!.docs;
                    for (var i = 0; i < data.length; i++) {
                      if (FirebaseAuth.instance.currentUser!.uid ==
                          data[i].get("ownerId")) {
                        ref = data[i].reference.id;
                        image = data[i].get("image");
                      }
                    }
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("restaurants")
                          .doc(ref)
                          .collection("managers")
                          .where("deleteStatus",isEqualTo: "notDeleted")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.docs.toList();
                          managerList.clear();
                          managerList.addAll(
                              data.map((e) => ManagerModel.fromJson(e.data())));

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ManagerTile(
                              image: managerList[index].image.toString(),
                              name: managerList[index].managerName.toString(),
                              location: managerList[index].address.toString(),
                              status: managerList[index]
                                  .activeOrDeactive
                                  .toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ManagerDetailsView(
                                      restaurantImage: image,
                                      restaurantRef: ref,
                                      managerRef:
                                          data[index].reference.id.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: MySize.size10,
                            ),
                            itemCount: managerList.length,
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
                    return const Center(
                      child: CircularProgressIndicator(),
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
                  AppLocalizations.of(context)!.manageManagers.toString(),
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
                        builder: (context) => const AddEditManagerView(
                            type: "add", managerRef: "", restaurantRef: ""),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
