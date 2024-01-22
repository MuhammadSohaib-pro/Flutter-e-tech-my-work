// ignore_for_file: deprecated_member_use

import 'package:falconsesportsapp/helper/common_functions.dart';
import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/widgets/custom_textfields.dart';
import 'package:falconsesportsapp/widgets/scrollable_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveStreamingView extends StatefulWidget {
  const LiveStreamingView({super.key});

  @override
  State<LiveStreamingView> createState() => _LiveStreamingViewState();
}

class _LiveStreamingViewState extends State<LiveStreamingView> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            Padding(
              padding: Spacing.horizontal(MySize.size25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MySize.size40,
                        height: MySize.size40,
                        decoration: const ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgPthree),
                            fit: BoxFit.cover,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SnappiCSGO',
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: MySize.size4),
                          Text(
                            '5 players',
                            style: TextStyle(
                              color: ThemeColors.green,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 35,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.11999999731779099),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.visibility_outlined,
                              color: ThemeColors.grey1,
                            ),
                            Text(
                              '83k',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 153, 148, 148),
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: 56,
                              height: 20,
                              decoration: ShapeDecoration(
                                color: ThemeColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    icStream,
                                    color: ThemeColors.bgColor,
                                  ),
                                  Text(
                                    'Live',
                                    style: TextStyle(
                                      color: ThemeColors.bgColor,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: MySize.size276,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgVideoStreaming),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size25),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField13(
                      controller: commentController,
                      hintText: "Comment",
                      radius: 30,
                      sufixIcon: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: ShapeDecoration(
                              color: ThemeColors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3800481F),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(icSend),
                          ),
                        ),
                      ),
                      fillColor: ThemeColors.fillColor,
                      keyboardType: TextInputType.text,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          CommonFunctions.validateTextField(value),
                    ),
                  ),
                  SizedBox(width: MySize.size9),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF323334),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.share,
                      color: ThemeColors.grey1,
                    ),
                  ),
                  SizedBox(width: MySize.size9),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF323334),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.favorite,
                      color: ThemeColors.red,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MySize.size20),
          ],
        ),
      ),
    );
  }
}
