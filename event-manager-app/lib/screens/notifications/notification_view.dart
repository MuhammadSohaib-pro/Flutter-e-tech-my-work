import 'package:event_manager_app/helper/constant.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        Container(
                          width: MySize.size70,
                          height: MySize.size70,
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=600"),
                              fit: BoxFit.cover,
                            ),
                            shape: CircleBorder(),
                          ),
                        ),
                        SizedBox(
                          width: MySize.size10,
                        ),
                        SizedBox(
                          width: MySize.size210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.newOrder.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: ThemeColors.black1,
                                  fontSize: MySize.size12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: MySize.size5),
                              Text(
                                "Mr. John",
                                style: TextStyle(
                                  color: ThemeColors.black1,
                                  fontSize: MySize.size16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: MySize.size15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        icWhatsapp,
                                        height: MySize.size19,
                                        width: MySize.size19,
                                      ),
                                      SizedBox(width: MySize.size4),
                                      Text(
                                        AppLocalizations.of(context)!.callCustomer.toString(),
                                        style: TextStyle(
                                          color: ThemeColors.grey2,
                                          fontSize: MySize.size10,
                                          fontWeight: FontWeight.w400,
                                        ),
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios,
                                color: ThemeColors.black1),
                          ),
                          Text(
                            AppLocalizations.of(context)!.notifications.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              AppLocalizations.of(context)!.markasread.toString(),
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
