import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/exports.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/kitchen_details/kitchen_details_view.dart';
import 'package:event_owner_app/screens/notifications/notification_view.dart';
import 'package:event_owner_app/screens/services_details/services_details_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MySize.size130,
          width: MySize.safeWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(MySize.size30),
              bottomLeft: Radius.circular(MySize.size30),
            ),
            color: ThemeColors.mainColor,
          ),
          child: Padding(
            padding: Spacing.symmetric(horizontal: MySize.size32),
            child: Column(
              children: [
                SizedBox(height: MySize.size25),
                Builder(
                  builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: SvgPicture.asset(icMenu,
                              color: ThemeColors.bgColor),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationView(),
                                  ));
                            },
                            child: SvgPicture.asset(icBell,
                                color: ThemeColors.bgColor)),
                      ],
                    );
                  },
                ),
                SizedBox(height: MySize.size20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .activeOrders
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: '\n100',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(width: MySize.size35),
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .completed
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: '\n100',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(width: MySize.size35),
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .totalBranches
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: '\n10',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MySize.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MySize.size20),
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("restaurants").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data;
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                if (FirebaseAuth.instance.currentUser!.uid ==
                    snapshot.data!.docs[i].data()["ownerId"]) {
                  data = snapshot.data!.docs[i].data();
                }
              }
              return data["category"] == "Kitchen"
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KitchenDetailsView(
                              restaurantCategory: data["category"],
                              type: "kitchens",
                            ),
                          ),
                        );
                      },
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.transparent),
                      child: Container(
                        width: double.infinity,
                        height: MySize.size76,
                        margin: Spacing.horizontal(MySize.size32),
                        padding: Spacing.horizontal(MySize.size25),
                        decoration: ShapeDecoration(
                          color: ThemeColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 20,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: MySize.size50,
                                  width: MySize.size50,
                                  child: SvgPicture.asset(icBellCell),
                                ),
                                SizedBox(width: MySize.size15),
                                Text(
                                  AppLocalizations.of(context)!
                                      .kitchen
                                      .toString(),
                                  style: TextStyle(
                                    color: ThemeColors.bgColor,
                                    fontSize: MySize.size16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: MySize.size35,
                              height: MySize.size35,
                              decoration: const ShapeDecoration(
                                color: ThemeColors.bgColor,
                                shape: CircleBorder(),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.arrow_forward,
                                color: ThemeColors.mainColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : data["category"] == "Services"
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceDetailsView(
                                    restaurantCategory: data["category"],
                                    type: "services"),
                              ),
                            );
                          },
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          child: Container(
                            width: double.infinity,
                            height: MySize.size76,
                            margin: Spacing.horizontal(MySize.size32),
                            padding: Spacing.horizontal(MySize.size25),
                            decoration: ShapeDecoration(
                              color: ThemeColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: MySize.size50,
                                      width: MySize.size50,
                                      child: SvgPicture.asset(icTruck),
                                    ),
                                    SizedBox(width: MySize.size15),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .services
                                          .toString(),
                                      style: TextStyle(
                                        color: ThemeColors.bgColor,
                                        fontSize: MySize.size16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MySize.size35,
                                  height: MySize.size35,
                                  decoration: const ShapeDecoration(
                                    color: ThemeColors.bgColor,
                                    shape: CircleBorder(),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: ThemeColors.mainColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : data["category"] == "Both"
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            KitchenDetailsView(
                                                restaurantCategory:
                                                    data["category"],
                                                    type: "kitchens",),
                                      ),
                                    );
                                  },
                                  overlayColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  child: Container(
                                    width: double.infinity,
                                    height: MySize.size76,
                                    margin: Spacing.horizontal(MySize.size32),
                                    padding: Spacing.horizontal(MySize.size25),
                                    decoration: ShapeDecoration(
                                      color: ThemeColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x14000000),
                                          blurRadius: 20,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: MySize.size50,
                                              width: MySize.size50,
                                              child:
                                                  SvgPicture.asset(icBellCell),
                                            ),
                                            SizedBox(width: MySize.size15),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .kitchen
                                                  .toString(),
                                              style: TextStyle(
                                                color: ThemeColors.bgColor,
                                                fontSize: MySize.size16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MySize.size35,
                                          height: MySize.size35,
                                          decoration: const ShapeDecoration(
                                            color: ThemeColors.bgColor,
                                            shape: CircleBorder(),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: ThemeColors.mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: MySize.size10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceDetailsView(
                                                restaurantCategory:
                                                    data["category"],
                                                    type: "services",),
                                      ),
                                    );
                                  },
                                  overlayColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  child: Container(
                                    width: double.infinity,
                                    height: MySize.size76,
                                    margin: Spacing.horizontal(MySize.size32),
                                    padding: Spacing.horizontal(MySize.size25),
                                    decoration: ShapeDecoration(
                                      color: ThemeColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x14000000),
                                          blurRadius: 20,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: MySize.size50,
                                              width: MySize.size50,
                                              child: SvgPicture.asset(icTruck),
                                            ),
                                            SizedBox(width: MySize.size15),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .services
                                                  .toString(),
                                              style: TextStyle(
                                                color: ThemeColors.bgColor,
                                                fontSize: MySize.size16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MySize.size35,
                                          height: MySize.size35,
                                          decoration: const ShapeDecoration(
                                            color: ThemeColors.bgColor,
                                            shape: CircleBorder(),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            color: ThemeColors.mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        SizedBox(height: MySize.size20),
        //   small Container

        // Container(
        //   width: MySize.size160,
        //   height: MySize.size200,
        //   margin: Spacing.horizontal(MySize.size32),
        //   decoration: ShapeDecoration(
        //     color: ThemeColors.mainColor,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(MySize.size30),
        //     ),
        //     shadows: const [
        //       BoxShadow(
        //         color: Color(0x14000000),
        //         blurRadius: 20,
        //         offset: Offset(0, 4),
        //         spreadRadius: 0,
        //       ),
        //     ],
        //     image: const DecorationImage(
        //         image: AssetImage(imgSmallKitchen), fit: BoxFit.fill),
        //   ),
        //   child: Stack(
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           SizedBox(height: MySize.size40, width: MySize.safeWidth),
        //           SizedBox(
        //             height: MySize.size50,
        //             width: MySize.size50,
        //             child: SvgPicture.asset(icBellCell),
        //           ),
        //           SizedBox(height: MySize.size5),
        //           Text(
        //             'Kitchen',
        //             style: TextStyle(
        //               color: ThemeColors.bgColor,
        //               fontSize: MySize.size16,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //           SizedBox(height: MySize.size5),
        //           Expanded(
        //             child: SizedBox(
        //               width: MySize.size130,
        //               height: MySize.size40,
        //               child: Text(
        //                 'The pain worm itself is important, and the education system will follow.',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: ThemeColors.bgColor,
        //                   fontSize: MySize.size10,
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       InkWell(
        //         onTap: () {},
        //         child: Align(
        //           alignment: Alignment.bottomRight,
        //           child: Container(
        //             width: MySize.size70,
        //             height: MySize.size25,
        //             decoration: ShapeDecoration(
        //               color: ThemeColors.bgColor,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(MySize.size30),
        //                   bottomRight: Radius.circular(MySize.size30),
        //                 ),
        //               ),
        //             ),
        //             alignment: Alignment.center,
        //             child: const Icon(
        //               Icons.arrow_forward_rounded,
        //               color: ThemeColors.mainColor,
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Text(
                    AppLocalizations.of(context)!.newOrder.toString(),
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: MySize.size15),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => const NewOrderTile(
                          image: imgProfile,
                          name: 'Mr. Wick',
                          date: 'Today wed 19, 2023',
                          type: 'New',
                          orderNo: "3816399163",
                          amount: "1500.00 SAR",
                        ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: MySize.size15),
                    itemCount: 5),
                SizedBox(height: MySize.size30),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NewOrderTile extends StatelessWidget {
  const NewOrderTile({
    super.key,
    required this.image,
    required this.name,
    required this.date,
    required this.type,
    required this.orderNo,
    required this.amount,
  });
  final String image;
  final String name;
  final String date;
  final String type;
  final String orderNo;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: MySize.safeWidth,
        height: MySize.size80,
        decoration: ShapeDecoration(
          color: ThemeColors.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 20,
              offset: Offset(-4, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MySize.size150,
                  height: MySize.size22,
                  decoration: ShapeDecoration(
                    color: ThemeColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(MySize.size5),
                    ),
                  ),
                  child: Padding(
                    padding: Spacing.horizontal(MySize.size6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.orderID.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '#$orderNo',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: Spacing.horizontal(MySize.size12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MySize.size45,
                    height: MySize.size45,
                    decoration: const ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(imgProfile),
                        fit: BoxFit.fill,
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                  SizedBox(width: MySize.size8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          color: type == "Cancelled"
                              ? ThemeColors.red
                              : type == "Completed"
                                  ? ThemeColors.green
                                  : ThemeColors.mainColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${AppLocalizations.of(context)!.total.toString()} ',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: amount,
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavouriteFoodContainer extends StatelessWidget {
  const FavouriteFoodContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MySize.size90,
      width: MySize.size70,
      child: Stack(
        children: [
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MySize.size60,
                  width: MySize.size60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3C5C5),
                    borderRadius: BorderRadius.circular(MySize.size20),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(imgFavoriteFood),
          )
        ],
      ),
    );
  }
}
