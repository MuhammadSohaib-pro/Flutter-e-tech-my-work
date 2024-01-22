import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KitchenRestaurantView extends StatefulWidget {
  const KitchenRestaurantView({super.key});

  @override
  State<KitchenRestaurantView> createState() => _KitchenRestaurantViewState();
}

class _KitchenRestaurantViewState extends State<KitchenRestaurantView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        centerTitle: false,
        title: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KitchenSearchView(),
              ),
            );
          },
          icon: const Icon(
            Icons.search,
            color: ThemeColors.black1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MySize.size250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgKitchenoverlay), fit: BoxFit.fill),
              ),
              child: Container(
                height: MySize.size250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.02, 1.00),
                    end: Alignment(0.02, -1),
                    colors: [Color(0xFF8B0000), Color(0x00D9D9D9)],
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MySize.size90,
                      height: MySize.size90,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgProfile),
                          fit: BoxFit.cover,
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                    Padding(
                      padding: Spacing.horizontal(MySize.size50),
                      child: Text(
                        'Mandi Restaurant',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: Spacing.horizontal(MySize.size50),
                      child: Text(
                        'Excellence in delivering fresh and healthy foods of high quality, wide experience and health standards.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: MySize.size30),
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MySize.size70,
                            height: MySize.size30,
                            decoration: ShapeDecoration(
                              color: ThemeColors.fillColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '5.0',
                                  style: TextStyle(
                                    color: ThemeColors.mainColor,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: MySize.size5),
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: ThemeColors.yellow,
                                  size: MySize.size16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MySize.size130,
                            height: MySize.size30,
                            decoration: ShapeDecoration(
                              color: ThemeColors.fillColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .availablenow
                                      .toString(),
                                  style: TextStyle(
                                    color: const Color(0xFF47AF08),
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: MySize.size5),
                                SvgPicture.asset(
                                  icCountdown,
                                  color: const Color(0xFF47AF08),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MySize.size110,
                            height: MySize.size30,
                            decoration: ShapeDecoration(
                              color: ThemeColors.fillColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '24.67 km ${AppLocalizations.of(context)!.away.toString()}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ThemeColors.mainColor,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: MySize.size5),
                                Icon(
                                  Icons.location_on_rounded,
                                  color: ThemeColors.mainColor,
                                  size: MySize.size16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MySize.size30),
            // Padding(
            //   padding: Spacing.horizontal(MySize.size32),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Text(
            //             AppLocalizations.of(context)!.mainItems.toString(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: ThemeColors.black1,
            //               fontSize: MySize.size14,
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //           SizedBox(height: MySize.size4),
            //           Container(
            //             width: MySize.size70,
            //             height: MySize.size2,
            //             decoration: ShapeDecoration(
            //               color: ThemeColors.mainColor,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(20),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             AppLocalizations.of(context)!.sideItems.toString(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: ThemeColors.black1,
            //               fontSize: MySize.size14,
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //           SizedBox(height: MySize.size4),
            //           // Container(
            //           //   width: MySize.size70,
            //           //   height: MySize.size2,
            //           //   decoration: ShapeDecoration(
            //           //     color: ThemeColors.mainColor,
            //           //     shape: RoundedRectangleBorder(
            //           //       borderRadius: BorderRadius.circular(20),
            //           //     ),
            //           //   ),
            //           // )
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             AppLocalizations.of(context)!.sweet.toString(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: ThemeColors.black1,
            //               fontSize: MySize.size14,
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //           SizedBox(height: MySize.size4),
            //           // Container(
            //           //   width: MySize.size70,
            //           //   height: MySize.size2,
            //           //   decoration: ShapeDecoration(
            //           //     color: ThemeColors.mainColor,
            //           //     shape: RoundedRectangleBorder(
            //           //       borderRadius: BorderRadius.circular(20),
            //           //     ),
            //           //   ),
            //           // )
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           Text(
            //             AppLocalizations.of(context)!.beverage.toString(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: ThemeColors.black1,
            //               fontSize: MySize.size14,
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //           SizedBox(height: MySize.size4),
            //           // Container(
            //           //   width: MySize.size70,
            //           //   height: MySize.size2,
            //           //   decoration: ShapeDecoration(
            //           //     color: ThemeColors.mainColor,
            //           //     shape: RoundedRectangleBorder(
            //           //       borderRadius: BorderRadius.circular(20),
            //           //     ),
            //           //   ),
            //           // )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: MySize.size30),
            // CstmKitchenListItemCard(onPressed: () {
            //   customModalSheet2(context);
            // }),
            DefaultTabController(
              length: 4,
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelStyle: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
                unselectedLabelColor: ThemeColors.grey1,
                labelColor: ThemeColors.black1,
                labelPadding: const EdgeInsets.all(0),
                tabs: [
                  Text(
                    AppLocalizations.of(context)!.mainItems.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.sideItems.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.sweet.toString(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.beverage.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      CstmKitchenListItemCard(
                        onPressed: () {
                          customModalSheet2(context);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CstmKitchenListItemCard(
                        onPressed: () {
                          customModalSheet2(context);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CstmKitchenListItemCard(
                        onPressed: () {
                          customModalSheet2(context);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CstmKitchenListItemCard(
                        onPressed: () {
                          customModalSheet2(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> customModalSheet2(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MySize.size270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage(
                          imgRoastedLamb2,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: Spacing.all(MySize.size20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: ThemeColors.bgColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MySize.size160,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Container(
                          height: MySize.size30,
                          width: MySize.size30,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: ThemeColors.fillColor.withOpacity(.5),
                          ),
                          child: const Icon(
                            Icons.favorite_border_outlined,
                            color: ThemeColors.bgColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'Roast lamb',
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  'But the pain itself is important, and the client will follow. Now freedom is at times free and desired, and trucks hate property. The chapter is suitable for silent partners who resort to the beaches through our marriages, through Hymenaean projects.',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '500.00 SAR',
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MySize.size14,
                          height: MySize.size14,
                          decoration: ShapeDecoration(
                            color: ThemeColors.fillColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            color: ThemeColors.black1,
                            size: MySize.size10,
                          ),
                        ),
                        SizedBox(width: MySize.size5),
                        Text(
                          '1',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: MySize.size5),
                        Container(
                          width: MySize.size14,
                          height: MySize.size14,
                          decoration: ShapeDecoration(
                            color: ThemeColors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            color: ThemeColors.bgColor,
                            size: MySize.size10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Text(
                  AppLocalizations.of(context)!.others.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeColors.mainColor,
                          value: true,
                          onChanged: (value) {},
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .quarterPlatter
                              .toString(),
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '200.00 SAR',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.grey1,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeColors.mainColor,
                          value: false,
                          onChanged: (value) {},
                        ),
                        Text(
                          AppLocalizations.of(context)!.halfClass.toString(),
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '200.00 SAR',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.grey1,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: ThemeColors.mainColor,
                          value: false,
                          onChanged: (value) {},
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .quarterPlatter
                              .toString(),
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '200.00 SAR',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.grey1,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.addToCart.toString(),
                  textColor: ThemeColors.bgColor,
                  backgroundColor: ThemeColors.mainColor,
                  radius: 30,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        );
      },
    );
  }
}
