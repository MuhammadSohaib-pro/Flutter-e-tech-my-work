import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class MyActivityDetailsView extends StatefulWidget {
  const MyActivityDetailsView({super.key});

  @override
  State<MyActivityDetailsView> createState() => _MyActivityDetailsViewState();
}

class _MyActivityDetailsViewState extends State<MyActivityDetailsView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.pedal.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => manageActivityBottomSheet(context),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: ThemeColors.black1,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MySize.size366,
                    color: Colors.amber,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MySize.size340,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: ThemeColors.bgColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        padding: Spacing.symmetric(
                            horizontal: MySize.size32, vertical: MySize.size13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Activity Name',
                                      style: TextStyle(
                                        color: ThemeColors.black1,
                                        fontSize: MySize.size16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: ThemeColors.grey1,
                                          size: MySize.size20,
                                        ),
                                        Text(
                                          "Saudi Arabia, Riyadh",
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
                                Container(
                                  width: MySize.size100,
                                  height: MySize.size29,
                                  decoration: ShapeDecoration(
                                    color: ThemeColors.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: ThemeColors.bgColor,
                                      fontSize: MySize.size14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: ThemeColors.mainColor,
                                  size: MySize.size20,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "5.0",
                                        style: TextStyle(
                                          color: ThemeColors.black1,
                                          fontSize: MySize.size12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/100+',
                                        style: TextStyle(
                                          color: ThemeColors.grey1,
                                          fontSize: MySize.size12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MySize.size22),
                            Text(
                              'Description',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MySize.size10),
                            Text(
                              'Rorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.\n',
                              style: TextStyle(
                                color: ThemeColors.grey1,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                            Container(
                              width: double.infinity,
                              height: MySize.size85,
                              decoration: ShapeDecoration(
                                color: ThemeColors.mainDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C000000),
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: Spacing.horizontal(MySize.size20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$10',
                                          style: TextStyle(
                                            color: ThemeColors.bgColor,
                                            fontSize: MySize.size16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Entry fee',
                                          style: TextStyle(
                                            color: ThemeColors.grey1,
                                            fontSize: MySize.size9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    const VerticalDivider(
                                        thickness: 1,
                                        color: Color(0xff28396F),
                                        endIndent: 20,
                                        indent: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '158',
                                          style: TextStyle(
                                            color: ThemeColors.bgColor,
                                            fontSize: MySize.size16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Participant',
                                          style: TextStyle(
                                            color: ThemeColors.grey1,
                                            fontSize: MySize.size9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    const VerticalDivider(
                                        thickness: 1,
                                        color: Color(0xff28396F),
                                        endIndent: 20,
                                        indent: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '30-120 ',
                                                style: TextStyle(
                                                  color: ThemeColors.bgColor,
                                                  fontSize: MySize.size16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'min',
                                                style: TextStyle(
                                                  color: ThemeColors.grey1,
                                                  fontSize: MySize.size9,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Duration',
                                          style: TextStyle(
                                            color: ThemeColors.grey1,
                                            fontSize: MySize.size9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                            Text(
                              'Facilities',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size50,
                                      decoration: const ShapeDecoration(
                                        color: ThemeColors.bgColor,
                                        shape: CircleBorder(),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(icHamburger),
                                    ),
                                    Text(
                                      'Food',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MySize.size14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size50,
                                      decoration: const ShapeDecoration(
                                        color: ThemeColors.bgColor,
                                        shape: CircleBorder(),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(icWine),
                                    ),
                                    Text(
                                      'Drinks',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MySize.size14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size50,
                                      decoration: const ShapeDecoration(
                                        color: ThemeColors.bgColor,
                                        shape: CircleBorder(),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(icShower),
                                    ),
                                    Text(
                                      'Shower',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MySize.size14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: MySize.size50,
                                      height: MySize.size50,
                                      decoration: const ShapeDecoration(
                                        color: ThemeColors.bgColor,
                                        shape: CircleBorder(),
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(2, 2),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(icBed),
                                    ),
                                    Text(
                                      'Rest',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MySize.size14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: MySize.size20),
                            Text(
                              'Location',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                            Container(
                              height: MySize.size172,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MySize.safeWidth,
                                      decoration: const BoxDecoration(
                                        color: ThemeColors.grey2,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MySize.safeWidth,
                                    height: MySize.size42,
                                    decoration: const ShapeDecoration(
                                      color: ThemeColors.bgColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    // alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.near_me_outlined,
                                          color: ThemeColors.mainColor,
                                          size: MySize.size30,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .selectLocation
                                              .toString(),
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
                            SizedBox(height: MySize.size20),
                            Text(
                              'Reviews ',
                              style: TextStyle(
                                color: ThemeColors.black1,
                                fontSize: MySize.size14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                            Container(
                              width: double.infinity,
                              height: MySize.size170,
                              decoration: ShapeDecoration(
                                color: ThemeColors.fillColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: MySize.size11),
                                  Container(
                                    width: MySize.size55,
                                    height: MySize.size55,
                                    decoration: const ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://images.pexels.com/photos/15237921/pexels-photo-15237921/free-photo-of-portrait-of-a-man-wearing-a-jacket.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  SizedBox(height: MySize.size5),
                                  Text(
                                    'Danyal Ahmed',
                                    style: TextStyle(
                                      color: ThemeColors.black1,
                                      fontSize: MySize.size14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  RatingBar(
                                    initialRating: 3,
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
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                  Padding(
                                    padding: Spacing.horizontal(MySize.size15),
                                    child: Text(
                                      'Dorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MySize.size10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: MySize.size20),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  manageActivityBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MySize.size30),
          topRight: Radius.circular(MySize.size30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MySize.size30),
                    topRight: Radius.circular(MySize.size30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        deleteActivityDialog(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Delete",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.red,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Deactivate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                        // AddPostOneView turned Into EditPostOneView up to 4

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         const AddPostOneView(type: "Edit"),
                        //   ),
                        // );
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  deleteActivityDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size30),
          ),
          child: Container(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: Spacing.fromLTRB(
                        MySize.size20, MySize.size15, MySize.size20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
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
                    "Alert!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  Text(
                    "Are you sure, You Want to delete this Post.",
                    style: TextStyle(
                      color: const Color(0xFF7D7D7D),
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: MySize.size30),
                  SizedBox(
                    width: MySize.size117,
                    height: MySize.size36,
                    child: CustomButton8(
                      text: "Delete",
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: MySize.size20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
