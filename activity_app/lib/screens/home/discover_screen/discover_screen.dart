import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/home/component/customer_icon_container.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

bool isDropdownOpen = false;
String selectedDate = 'Today';

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Padding(
        //   padding: EdgeInsets.only(
        //     left: SizeConfig.widthMultiplier * 0,
        //   ),
        //   child: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //     size: 20,
        //   ),
        // ),
        title: Text(
          'Discover',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: MyEdgeInsets.home1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF2538E8),
                          shape: OvalBorder(),
                        ),
                        child: Image.asset(
                          'assets/images/camel.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Camel Ride',
                                style: MyTextStyles.latoTextstyle(
                                    SizeConfig.textMultiplier * 2.5,
                                    FontWeight.w700),
                              ),
                              Icon(
                                isDropdownOpen
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                              ),
                            ],
                          ),
                          // Text(
                          //   ' Borem ipsum',
                          //   style: MyTextStyles.latoTextstylecolor(
                          //       SizeConfig.textMultiplier * 1.5,
                          //       FontWeight.w400,
                          //       AppColors.greyText),
                          // ),
                        ],
                      )
                    ],
                  ),
                  // openWithLongPress: true,
                  items: [
                    ...MenuItems.firstItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),
                    const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
                    ...MenuItems.secondItems.map(
                          (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),
                  ],

                  onChanged: (value) {

                    MenuItems.onChanged(context, value! as MenuItem);

                  },

                  onMenuStateChange: (value){
                    setState(() {
                      isDropdownOpen = !isDropdownOpen;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    // This is necessary for the ink response to match our customButton radius.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 160,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // color: Colors.redAccent,
                    ),
                    offset: const Offset(40, -4),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                      8,
                      ...List<double>.filled(MenuItems.secondItems.length, 48),
                    ],
                    padding: const EdgeInsets.only(left: 16, right: 16),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Container(
              //       width: 60,
              //       height: 60,
              //       alignment: Alignment.center,
              //       decoration: const ShapeDecoration(
              //         color: Color(0xFF2538E8),
              //         shape: OvalBorder(),
              //       ),
              //       child: Image.asset(
              //         'assets/images/camel.png',
              //         width: 30,
              //         height: 30,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           children: [
              //             Text(
              //               'Camel Ride',
              //               style: MyTextStyles.latoTextstyle(
              //                   SizeConfig.textMultiplier * 2.5,
              //                   FontWeight.w700),
              //             ),
              //             GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   isDropdownOpen = !isDropdownOpen;
              //                 });
              //               },
              //               child: Icon(
              //                 isDropdownOpen
              //                     ? Icons.keyboard_arrow_up
              //                     : Icons.keyboard_arrow_down,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Text(
              //           ' Borem ipsum',
              //           style: MyTextStyles.latoTextstylecolor(
              //               SizeConfig.textMultiplier * 1.5,
              //               FontWeight.w400,
              //               AppColors.greyText),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // if (isDropdownOpen == true)
              //   const SizedBox(
              //     height: 8,
              //   ),
              // if (isDropdownOpen == true)
              //   Expanded(
              //     child: Container(
              //       width: 150,
              //       // color: Colors.white,
              //       decoration: ShapeDecoration(
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(
              //           side: BorderSide(
              //             width: 1,
              //             color: Colors.white.withOpacity(0.3799999952316284),
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //
              //       child: Padding(
              //         padding: EdgeInsets.only(top: 8),
              //         child: ListView.builder(
              //           itemCount: 5,
              //           itemBuilder: (BuildContext context, int index) {
              //             return Container(
              //               //  width: 160,
              //               alignment: Alignment.topLeft,
              //               //  height: 150,
              //               color: Colors.white,
              //               child: const Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: 4, horizontal: 12),
              //                 child: CustomIconContainer(
              //                   isSelected:
              //                       true, // Set true or false based on selection
              //                   imagePath: 'assets/images/camel.png',
              //                   labelText: 'Camel',
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 28,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildDateItem('Today'),
                    buildDateItem('Tomorrow'),
                    buildDateItem('This Week'),
                    buildDateItem('This Month'),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          //   width: 327,
                          height: 209,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/2100387/pexels-photo-2100387.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Horse Riding!',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 2,
                                  FontWeight.w600),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: AppColors.primaryColor,
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '5.0/ ',
                                        style: MyTextStyles.latoTextstyle(
                                            SizeConfig.textMultiplier * 1.8,
                                            FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: '+100',
                                        style: MyTextStyles.latoTextstylecolor(
                                          SizeConfig.textMultiplier * 1.8,
                                          FontWeight.w400,
                                          AppColors.greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 60,
                                  child: ReadMoreText(
                                    'Embark on a desert odyssey, where every sway.',
                                    trimLines: 2,
                                    colorClickableText: Colors.black,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Read more',
                                    trimExpandedText: 'Show less',
                                    style: MyTextStyles.latoTextstylecolor(
                                      SizeConfig.textMultiplier * 1.8,
                                      FontWeight.w600,
                                      AppColors.greyText,
                                    ),
                                    moreStyle: MyTextStyles.latoTextstylecolor(
                                      SizeConfig.textMultiplier * 1.8,
                                      FontWeight.w600,
                                      AppColors.textColorblack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Entry Fees',
                                  style: MyTextStyles.latoTextstylecolor(
                                    SizeConfig.textMultiplier * 1.5,
                                    FontWeight.w400,
                                    AppColors.greyText,
                                  ),
                                ),
                                Text(
                                  ' \$',
                                  style: MyTextStyles.latoTextstylecolor(
                                    SizeConfig.textMultiplier * 2,
                                    FontWeight.w700,
                                    AppColors.textColorblack,
                                  ),
                                ),
                                Text(
                                  ' 50',
                                  style: MyTextStyles.latoTextstylecolor(
                                    SizeConfig.textMultiplier * 2,
                                    FontWeight.w700,
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateItem(String date) {
    bool isSelected = selectedDate == date;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date;
        });
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          date,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.svgPath, // Use String to represent the SVG path
  });

  final String text;
  final String svgPath; // SVG path instead of IconData
}

class MenuItems {
  static const List<MenuItem> firstItems = [horse, hiking, camel,bike];
  static const List<MenuItem> secondItems = [];

  static const horse = MenuItem(text: 'Horse', svgPath: AssetImages.horse);
  static const hiking = MenuItem(text: 'Hiking', svgPath:  AssetImages.hike);
  static const camel = MenuItem(text: 'Camel', svgPath:  AssetImages.hike);
  static const bike = MenuItem(text: 'Bike', svgPath:  AssetImages.bike);
  static const pedal = MenuItem(text: 'pedal', svgPath:  AssetImages.pedal);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        SvgPicture.asset( // Use SvgPicture instead of Icon
          item.svgPath,
          // color: Colors.blue, // Set the desired color
          // width: 22,
          // height: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.horse:
      // Do something
        break;
      case MenuItems.bike:
      // Do something
        break;
      case MenuItems.camel:
      // Do something
        break;
      case MenuItems.pedal:
      // Do something
        break;
      case MenuItems.hiking:
      // Do something
        break;
    }
  }
}

// class MenuItem {
//   const MenuItem({
//     required this.text,
//     required this.icon,
//   });
//
//   final String text;
//   final IconData icon;
// }
//
// class MenuItems {
//   static const List<MenuItem> firstItems = [like, share, download];
//   static const List<MenuItem> secondItems = [cancel];
//
//   static const like = MenuItem(text: 'Like', icon: Icons.favorite);
//   static const share = MenuItem(text: 'Share', icon: Icons.share);
//   static const download = MenuItem(text: 'Download', icon: Icons.download);
//   static const cancel = MenuItem(text: 'Cancel', icon: Icons.cancel);
//
//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(
//           item.icon,
//           color: AppColors.primaryColor,
//           size: 22,
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Expanded(
//           child: Text(
//             item.text,
//             style: const TextStyle(
//               color: AppColors.primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   static void onChanged(BuildContext context, MenuItem item) {
//     switch (item) {
//       case MenuItems.like:
//       //Do something
//         break;
//       case MenuItems.share:
//       //Do something
//         break;
//       case MenuItems.download:
//       //Do something
//         break;
//       case MenuItems.cancel:
//       //Do something
//         break;
//     }
//   }
// }