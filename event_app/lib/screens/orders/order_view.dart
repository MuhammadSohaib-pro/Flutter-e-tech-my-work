import 'package:event_app/helper/common_functions.dart';
import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  TextEditingController ratingController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MySize.size20),
        Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.orders.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MySize.size40),
        // Column(
        //   children: [
        //     Padding(
        //       padding: Spacing.horizontal(MySize.size32),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Column(
        //             children: [
        //               Text(
        //                 AppLocalizations.of(context)!.active.toString(),
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: ThemeColors.black1,
        //                   fontSize: MySize.size14,
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //               SizedBox(height: MySize.size5),
        //               Container(
        //                 width: 38,
        //                 height: 2,
        //                 decoration: ShapeDecoration(
        //                   color: ThemeColors.mainColor,
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(20),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Column(
        //             children: [
        //               Text(
        //                 AppLocalizations.of(context)!.completed.toString(),
        //                 textAlign: TextAlign.center,
        //                 style: TextStyle(
        //                   color: ThemeColors.grey1,
        //                   fontSize: MySize.size14,
        //                   fontWeight: FontWeight.w400,
        //                 ),
        //               ),
        //               SizedBox(height: MySize.size5),
        //               // Container(
        //               //   width: 38,
        //               //   height: 2,
        //               //   decoration: ShapeDecoration(
        //               //     color: ThemeColors.mainColor,
        //               //     shape: RoundedRectangleBorder(
        //               //       borderRadius: BorderRadius.circular(20),
        //               //     ),
        //               //   ),
        //               // ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: MySize.size25),
        // activeOrdersEmpty(context),
        // Expanded(
        //   child: SizedBox(
        //     child: ListView.separated(
        //       separatorBuilder: (context, index) =>
        //           SizedBox(height: MySize.size10),
        //       itemCount: 5,
        //       itemBuilder: (context, index) {
        //         return index % 2 == 0
        //             ? activeOrderCard(context)
        //             : completedOrderCard(context);
        //       },
        //     ),
        //   ),
        // ),
        DefaultTabController(
          length: 3,
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
                AppLocalizations.of(context)!.active.toString(),
              ),
              Text(
                AppLocalizations.of(context)!.completed.toString(),
              ),
              Text(
                AppLocalizations.of(context)!.cancelled.toString(),
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
                  activeOrderCard(context),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    completedOrderCard(context),
                  ],
                ),
              ),
              Column(
                children: [
                  activeOrdersEmpty(context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget activeOrderCard(BuildContext context) {
    return Container(
      width: MySize.size330,
      height: MySize.size420,
      margin: Spacing.horizontal(MySize.size32),
      decoration: BoxDecoration(
        color: ThemeColors.bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MySize.size180,
                height: MySize.size22,
                decoration: const ShapeDecoration(
                  color: ThemeColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${AppLocalizations.of(context)!.orderNo.toString()} 6358153815',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MySize.size90,
                    height: MySize.size90,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 0, width: double.infinity),
                            SizedBox(height: MySize.size22),
                            Expanded(
                              child: Container(
                                width: MySize.size60,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE3C5C5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 20,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MySize.size72,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: AssetImage(imgFavoriteFood),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MySize.size7),
                  Container(
                    width: MySize.size70,
                    height: MySize.size84,
                    alignment: Alignment.center,
                    child: Text(
                      'Full Lamb Mandi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '1500.00 SAR',
                style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: MySize.size12,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: MySize.size20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset(icCartStatus, color: ThemeColors.mainColor),
                  SizedBox(height: MySize.size28),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.orderPlaced.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(icDone, color: ThemeColors.grey1),
                        Text(
                          '19 September 2023 21:20',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Text(
                      AppLocalizations.of(context)!.preparing.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(icDone, color: ThemeColors.grey1),
                        Text(
                          '19 September 2023 21:20',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Text(
                      AppLocalizations.of(context)!.ontheway.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: MySize.size14, color: ThemeColors.grey1),
                        Text(
                          AppLocalizations.of(context)!.pending.toString(),
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.delivered.toString(),
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: Spacing.horizontal(MySize.size20),
                          child: Text(
                            '${AppLocalizations.of(context)!.total.toString()} Rs.4 500',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: MySize.size14, color: ThemeColors.grey1),
                        Text(
                          AppLocalizations.of(context)!.pending.toString(),
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await customDeleteDialog(context);
            },
            child: Container(
              width: double.infinity,
              height: MySize.size44,
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                color: ThemeColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.cancel.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget activeOrdersEmpty(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: Spacing.horizontal(MySize.size32),
          child: Column(
            children: [
              const SizedBox(width: double.infinity),
              Image.asset(
                imgEmptyOrder,
                height: MySize.size300,
                width: MySize.size300,
              ),
              SizedBox(height: MySize.size10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.emptyOrder.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      style: TextStyle(
                        color: ThemeColors.grey1,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget completedOrderCard(BuildContext context) {
    return Container(
      width: MySize.size330,
      height: MySize.size420,
      margin: Spacing.horizontal(MySize.size32),
      decoration: BoxDecoration(
        color: ThemeColors.bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MySize.size180,
                height: MySize.size22,
                decoration: const ShapeDecoration(
                  color: ThemeColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${AppLocalizations.of(context)!.orderNo.toString()} 6358153815',
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MySize.size5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MySize.size90,
                    height: MySize.size90,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 0, width: double.infinity),
                            SizedBox(height: MySize.size22),
                            Expanded(
                              child: Container(
                                width: MySize.size60,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE3C5C5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 20,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MySize.size72,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomCenter,
                                  image: AssetImage(imgFavoriteFood),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MySize.size7),
                  Container(
                    width: MySize.size70,
                    height: MySize.size84,
                    alignment: Alignment.center,
                    child: Text(
                      'Full Lamb Mandi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '1500.00 SAR',
                style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: MySize.size12,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: MySize.size20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset(icCartStatus, color: ThemeColors.mainColor),
                  SizedBox(height: MySize.size28),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.orderPlaced.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(icDone, color: ThemeColors.grey1),
                        Text(
                          '19 September 2023 21:20',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Text(
                      AppLocalizations.of(context)!.orderPlaced.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(icDone, color: ThemeColors.grey1),
                        Text(
                          '19 September 2023 21:20',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Text(
                      AppLocalizations.of(context)!.ontheway.toString(),
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: MySize.size14, color: ThemeColors.grey1),
                        Text(
                          AppLocalizations.of(context)!.pending.toString(),
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MySize.size15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.delivered.toString(),
                          style: TextStyle(
                            color: ThemeColors.mainColor,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: Spacing.horizontal(MySize.size20),
                          child: Text(
                            '${AppLocalizations.of(context)!.total.toString()} Rs.4 500',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: MySize.size14, color: ThemeColors.grey1),
                        Text(
                          AppLocalizations.of(context)!.pending.toString(),
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              reviewbottomSheet(context);
            },
            child: Container(
              width: double.infinity,
              height: MySize.size44,
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                color: ThemeColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.writeReview.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> reviewbottomSheet(BuildContext context) {
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
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        Spacing.fromLTRB(0, MySize.size20, 0, MySize.size40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.rating.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: ThemeColors.black1,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: Spacing.fromLTRB(
                        MySize.size32, 0, MySize.size32, MySize.size15),
                    child: Text(
                      AppLocalizations.of(context)!.rateOurServices.toString(),
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        Spacing.fromLTRB(MySize.size32, 0, MySize.size32, 0),
                    child: RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: MySize.size20,
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: ThemeColors.mainColor,
                        ),
                        half: const Icon(Icons.star,
                            color: ThemeColors.mainColor),
                        empty: const Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                      ),
                      glow: false,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        // print(rating);
                      },
                    ),
                  ),
                  SizedBox(height: MySize.size15),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: CustomTextField13(
                      controller: ratingController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      hintText: AppLocalizations.of(context)!.saySomething.toString(),
                      title: AppLocalizations.of(context)!.addReview.toString(),
                      fillColor: ThemeColors.fillColor,
                      validator: (value) {
                        return CommonFunctions.validateTextField(value);
                      },
                    ),
                  ),
                  SizedBox(height: MySize.size25),
                  Padding(
                    padding: Spacing.fromLTRB(
                        MySize.size32, 0, MySize.size32, MySize.size20),
                    child: SizedBox(
                      height: MySize.size44,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.submit.toString(),
                        radius: 30,
                        onPressed: () {},
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> customDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size30),
          ),
          child: Container(
            height: MySize.size270,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x2B000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(
                      MySize.size20, MySize.size15, MySize.size20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: ThemeColors.black1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: MySize.size42,
                  color: ThemeColors.mainColor,
                ),
                SizedBox(height: MySize.size8),
                Text(
                  AppLocalizations.of(context)!.warning.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MySize.size10),
                Text(
                  AppLocalizations.of(context)!.warningDescrp.toString(),
                  style: TextStyle(
                    color: const Color(0xFF7D7D7D),
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MySize.size100,
                      height: MySize.size36,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.no.toString(),
                        radius: MySize.size30,
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: MySize.size100,
                      height: MySize.size36,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.yes.toString(),
                        radius: MySize.size30,
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }
}
