import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.trackOrder.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            SizedBox(height: MySize.size30),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     '${AppLocalizations.of(context)!.orderNumber.toString()} #26831254824',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: ThemeColors.black1,
            //       fontSize: MySize.size16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size7),
                      Text(
                        '17 May, 2023',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order no#',
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size7),
                      Text(
                        '12131242145',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size7),
                      Text(
                        'AED.500',
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MySize.size25),
            const Divider(),
            SizedBox(height: MySize.size30),
            CustomTrackOrderCard(
              backgroundColor: ThemeColors.mainColor,
              icon: icCheckCircle,
              iconBgColor: ThemeColors.mainDark,
              iconColor: ThemeColors.bgColor,
              subtitleColor: ThemeColors.bgColor,
              titleColor: ThemeColors.bgColor,
              title: AppLocalizations.of(context)!.orderPlaced.toString(),
              subtitle: '19 September 2023 21:20',
            ),
            Padding(
              padding: Spacing.horizontal(MySize.size64),
              child: Row(
                children: [
                  SizedBox(
                    height: MySize.size20,
                    child: SvgPicture.asset(icLines),
                  ),
                ],
              ),
            ),
            CustomTrackOrderCard(
              backgroundColor: ThemeColors.bgColor,
              icon: icClock,
              iconBgColor: ThemeColors.fillColor,
              iconColor: ThemeColors.grey1,
              subtitleColor: ThemeColors.grey1,
              titleColor: ThemeColors.mainColor,
              title: AppLocalizations.of(context)!.preparing.toString(),
              subtitle: 'September 19 , 2023 9:40 AM',
            ),
            Padding(
              padding: Spacing.horizontal(MySize.size64),
              child: Row(
                children: [
                  SizedBox(
                    height: MySize.size20,
                    child: SvgPicture.asset(icLines),
                  ),
                ],
              ),
            ),
            CustomTrackOrderCard(
              backgroundColor: ThemeColors.bgColor,
              icon: icClock,
              iconBgColor: ThemeColors.fillColor,
              iconColor: ThemeColors.grey1,
              subtitleColor: ThemeColors.grey1,
              titleColor: ThemeColors.mainColor,
              title: AppLocalizations.of(context)!.ontheway.toString(),
              subtitle: AppLocalizations.of(context)!.pending.toString(),
            ),
            Padding(
              padding: Spacing.horizontal(MySize.size64),
              child: Row(
                children: [
                  SizedBox(
                    height: MySize.size20,
                    child: SvgPicture.asset(icLines),
                  ),
                ],
              ),
            ),
            CustomTrackOrderCard(
              backgroundColor: ThemeColors.bgColor,
              icon: icClock,
              iconBgColor: ThemeColors.fillColor,
              iconColor: ThemeColors.grey1,
              subtitleColor: ThemeColors.grey1,
              titleColor: ThemeColors.mainColor,
              title: AppLocalizations.of(context)!.delivered.toString(),
              subtitle: AppLocalizations.of(context)!.pending.toString(),
            ),
            SizedBox(height: MySize.size75),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        overlayColor: const MaterialStatePropertyAll(Color(0xffD1ffbd)),
        child: SizedBox(
          width: MySize.size100,
          height: MySize.size40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.chatnow.toString(),
                style: TextStyle(
                  color: const Color(0xFF4CC85A),
                  fontSize: MySize.size12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SvgPicture.asset(icWhatsapp)
            ],
          ),
        ),
      ),
    );
  }

  Widget favoriteContainer() {
    return SizedBox(
      width: MySize.size160,
      height: MySize.size260,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0, width: double.infinity),
              SizedBox(height: MySize.size110),
              Expanded(
                child: Container(
                  width: MySize.size140,
                  decoration: ShapeDecoration(
                    color: ThemeColors.black1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
                height: MySize.size180,
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
                  width: MySize.size140,
                  child: Column(
                    children: [
                      const SizedBox(width: double.infinity),
                      Text(
                        'Full Lamb Mandi',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: MySize.size10),
                      Text(
                        'Robe.1500',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
