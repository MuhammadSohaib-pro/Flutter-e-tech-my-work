import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.payment.toString(),
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
              SizedBox(height: MySize.size10),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size210,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: MySize.size15),
                      Padding(
                        padding: Spacing.horizontal(MySize.size12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: ThemeColors.mainColor,
                            ),
                            SizedBox(width: MySize.size8),
                            Text(
                              AppLocalizations.of(context)!
                                  .deliveryAddress
                                  .toString(),
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MySize.size8),
                      Padding(
                        padding: Spacing.horizontal(MySize.size12),
                        child: Container(
                          height: MySize.size120,
                          width: double.infinity,
                          color: ThemeColors.yellow.withOpacity(.3),
                        ),
                      ),
                      SizedBox(height: MySize.size8),
                      Padding(
                        padding: Spacing.horizontal(MySize.size12),
                        child: Text(
                          'I-10 Markaz',
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size12),
                        child: Text(
                          'Islamabad',
                          style: TextStyle(
                            color: ThemeColors.grey1,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: ThemeColors.bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MySize.size16),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Text(
                          AppLocalizations.of(context)!
                              .paymentMethod
                              .toString(),
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MySize.size20),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: true,
                              onChanged: (value) {},
                            ),
                            SvgPicture.asset(
                              icMoney,
                              height: MySize.size18,
                              width: MySize.size18,
                            ),
                            SizedBox(width: MySize.size5),
                            Text(
                              'Cash',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: true,
                              onChanged: (value) {},
                            ),
                            SvgPicture.asset(
                              icCreditCard,
                              height: MySize.size18,
                              width: MySize.size18,
                            ),
                            SizedBox(width: MySize.size5),
                            Text(
                              'Mada',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Row(
                          children: [
                            Radio(
                              value: true,
                              groupValue: true,
                              onChanged: (value) {},
                            ),
                            SvgPicture.asset(
                              icVisa,
                              height: MySize.size18,
                              width: MySize.size18,
                            ),
                            SizedBox(width: MySize.size5),
                            Text(
                              'Visa',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: Spacing.horizontal(MySize.size20),
                        child: Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: true,
                              onChanged: (value) {},
                            ),
                            SvgPicture.asset(
                              icTabby,
                              height: MySize.size18,
                              width: MySize.size18,
                            ),
                            SizedBox(width: MySize.size5),
                            Text(
                              'Tabby (3 month installments available)',
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Container(
                  // width: double.infinity,
                  // height: MySize.size190,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x11000000),
                        offset: Offset(0, 4),
                        blurRadius: 20,
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
                                  .summaryOfTheApplication
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: ThemeColors.black1,
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
                                  'Delivery Charges',
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Free',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ThemeColors.mainColor,
                                    fontSize: MySize.size10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MySize.size5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size35),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.confirmToPay.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThankYouView(),
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
