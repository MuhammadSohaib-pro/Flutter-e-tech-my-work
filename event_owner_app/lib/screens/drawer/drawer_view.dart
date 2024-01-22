import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/aboutus/aboutus_view.dart';
import 'package:event_owner_app/screens/home/home_view.dart';
import 'package:event_owner_app/screens/manage_branches/manage_branches_view.dart';
import 'package:event_owner_app/screens/manage_manager/managers_view.dart';
import 'package:event_owner_app/screens/orders/orders_view.dart';
import 'package:event_owner_app/screens/privacy_policy/privacy_policy_view.dart';
import 'package:event_owner_app/screens/profile/profile_view.dart';
import 'package:event_owner_app/screens/settings/settings_view.dart';
import 'package:event_owner_app/screens/wallet/wallet_view.dart';
import 'package:event_owner_app/widgets/scrollable_column.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

List<Widget> drawerScreens = [
  const HomeView(),
  const OrdersView(),
  const WalletView(),
  const ProfileView(),
  const ManageBranchesView(),
  const ManagersView(),
  const SettingsView(),
  const PrivacyPolicyAndTermsView(),
  const AboutUsView(),
];
int index = 0;

class _DrawerViewState extends State<DrawerView> {
  Future<String> setInitialsData() async {
    var id = FirebaseAuth.instance.currentUser!.uid;
    var fs2 = await FirebaseFirestore.instance.collection("restaurants").get();
    var data = fs2.docs;
    String ref = "";
    for (var i = 0; i < data.length; i++) {
      if (id == data[i].get("ownerId")) {
        ref = data[i].reference.id;
      }
    }
    return ref;
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(child: drawerScreens[index]),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: ThemeColors.bgColor,
          child: Builder(builder: (context) {
            return ScrollableColumn(
              children: [
                SizedBox(height: MySize.size20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: Spacing.horizontal(MySize.size20),
                      child: Builder(builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).closeDrawer();
                          },
                          icon: Icon(
                            Icons.close,
                            color: ThemeColors.mainColor,
                            size: MySize.size28,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size20),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("restaurants")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      String name = "";
                      String image = "";
                      String address = "";
                      for (var i = 0; i < data.length; i++) {
                        if (FirebaseAuth.instance.currentUser!.uid ==
                            data[i].get("ownerId")) {
                          name = data[i].get("restaurantName");
                          image = data[i].get("image");
                          address = data[i].get("restaurantAddress");
                        }
                      }
                      return Column(
                        children: [
                          CachedNetworkImage(
                            height: MySize.size90,
                            width: MySize.size90,
                            imageUrl: image,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ThemeColors.grey6),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: ThemeColors.mainColor,
                                  size: 40,
                                ),
                              );
                            },
                            placeholder: (context, url) {
                              return const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2.0),
                              );
                            },
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: ThemeColors.mainColor,
                                size: MySize.size14,
                              ),
                              SizedBox(width: MySize.size2),
                              Text(
                                address,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeColors.black1,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(height: MySize.size50),
                DrawerTile(
                  icon: icHouse,
                  title: AppLocalizations.of(context)!.home.toString(),
                  isSelected: index == 0 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 0;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icOrderFiles,
                  title: AppLocalizations.of(context)!.orders.toString(),
                  isSelected: index == 1 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 1;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icOutlinedWallet,
                  title: AppLocalizations.of(context)!.wallet.toString(),
                  isSelected: index == 2 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 2;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icPerson,
                  title: AppLocalizations.of(context)!.profile.toString(),
                  isSelected: index == 3 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 3;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icStoreFront,
                  title: AppLocalizations.of(context)!.manageBranch.toString(),
                  isSelected: index == 4 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 4;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icManageManger,
                  title: AppLocalizations.of(context)!.manageManager.toString(),
                  isSelected: index == 5 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 5;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icSettingOutlined,
                  title: AppLocalizations.of(context)!.settings.toString(),
                  isSelected: index == 6 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 6;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icKeyHole,
                  title: AppLocalizations.of(context)!.privacyTerms.toString(),
                  isSelected: index == 7 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 7;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size20),
                DrawerTile(
                  icon: icInfo,
                  title: AppLocalizations.of(context)!.aboutUs.toString(),
                  isSelected: index == 8 ? true : false,
                  onPressed: () {
                    setState(() {
                      index = 8;
                      Scaffold.of(context).closeDrawer();
                    });
                  },
                ),
                SizedBox(height: MySize.size80),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: MySize.size40,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: MySize.size20),
            SvgPicture.asset(icon, color: ThemeColors.mainColor),
            SizedBox(width: MySize.size8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? ThemeColors.mainColor : ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
