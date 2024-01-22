import 'package:event_app/helper/imports.dart';

class KitchenKeysView extends StatefulWidget {
  const KitchenKeysView({super.key});

  @override
  State<KitchenKeysView> createState() => _KitchenKeysViewState();
}

class _KitchenKeysViewState extends State<KitchenKeysView>
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
        title: Text(
          AppLocalizations.of(context)!.keys.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MySize.size10),
            // Padding(
            //   padding: Spacing.horizontal(MySize.size32),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         children: [
            //           Text(
            //             AppLocalizations.of(context)!
            //                 .mainItems
            //                 .toString(),
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
            //             AppLocalizations.of(context)!
            //                 .sideItems
            //                 .toString(),
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
                      SizedBox(height: MySize.size20),
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

            // CstmKitchenListItemCard(
            //   onPressed: () {
            //     customModalSheet2(context);
            //   },
            // ),
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
                  'Others',
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
                          'Quarter platter.',
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
                          'Quarter platter.',
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
                          'Quarter platter.',
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
                  text: "Add to cart",
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
