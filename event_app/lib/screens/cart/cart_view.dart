import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cart.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size84,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: Spacing.horizontal(MySize.size20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icScooter),
                        SizedBox(width: MySize.size10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .deliveryTime
                                  .toString(),
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Now (20 min)',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              const CstomCartCard(),
              const CstomCartCard(),
              SizedBox(height: MySize.size35),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: MySize.size330,
                  height: MySize.size160,
                  decoration: ShapeDecoration(
                    color: ThemeColors.bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MySize.size15),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Row(
                          children: [
                            SvgPicture.asset(icFile),
                            Text(
                              AppLocalizations.of(context)!
                                  .orderSummary
                                  .toString(),
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Column(
                          children: [
                            SizedBox(height: MySize.size20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'x1 Full Mondi ',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '1500 rupees',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MySize.size10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'x2 Half Rice Mandi',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '1500 rupees',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MySize.size10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '1X Chicken Steak',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '1500 rupees',
                                  textAlign: TextAlign.right,
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
                                  'Subtotal',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '4500',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ThemeColors.grey1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  hintText:
                      AppLocalizations.of(context)!.addinstructions.toString(),
                  maxLines: 8,
                  radius: 20,
                ),
              ),
              SizedBox(height: MySize.size35),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalicluding.toString(),
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '4500.00 SAR',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.continuee.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentView(),
                      ),
                    );
                  },
                  backgroundColor: ThemeColors.mainColor,
                  radius: 30,
                  textColor: ThemeColors.bgColor,
                ),
              ),
              SizedBox(height: MySize.size20),
            ],
          ),
        ),
      ),
    );
  }
}
