import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MySize.size70),
                  Container(
                    width: MySize.size330,
                    height: MySize.size110,
                    margin: Spacing.horizontal(MySize.size32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MySize.size110,
                          height: MySize.size110,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                      height: 0, width: double.infinity),
                                  SizedBox(height: MySize.size22),
                                  Expanded(
                                    child: Container(
                                      width: MySize.size75,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE3C5C5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                    height: MySize.size90,
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
                        SizedBox(
                          width: MySize.size210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Mutton's full",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: ThemeColors.grey2,
                                  fontSize: MySize.size14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: MySize.size5),
                              Text(
                                AppLocalizations.of(context)!
                                    .orderSuccessfullyPlaced
                                    .toString(),
                                maxLines: 4,
                                style: TextStyle(
                                  color: ThemeColors.mainColor,
                                  fontSize: MySize.size14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: MySize.size15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .chatnow
                                            .toString(),
                                        style: TextStyle(
                                          color: ThemeColors.grey2,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: MySize.size4),
                                      SvgPicture.asset(
                                        icWhatsapp,
                                        height: MySize.size19,
                                        width: MySize.size19,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '3 ${AppLocalizations.of(context)!.mintAgo.toString()}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: ThemeColors.grey2,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MySize.size60,
              color: ThemeColors.bgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: SizedBox(
                      height: MySize.size30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios,
                                color: ThemeColors.black1),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .notifications
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              AppLocalizations.of(context)!
                                  .markasread
                                  .toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: ThemeColors.mainColor,
                                fontSize: MySize.size12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
