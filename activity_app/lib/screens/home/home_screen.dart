import 'package:activityapp/global/component/custom_buttons.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/home/Notifications/Notifications_screen.dart';
import 'package:activityapp/screens/home/component/tabbar.dart';
import 'package:activityapp/model/eventdata_upcomingevents.dart';
import 'package:activityapp/screens/home/controller/home_controller.dart';
import 'package:activityapp/screens/home/discover_screen/discover_screen.dart';
import 'package:activityapp/screens/home/map/map_screen.dart';
import 'package:activityapp/screens/settings/menu_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global/layout/asset_images.dart';

class MyDiscoverItem {
  final String text;
  final String imageAsset;

  MyDiscoverItem({
    required this.text,
    required this.imageAsset,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedindex = 0;

//final HomeCtrl homeCtrl = Get.put(HomeCtrl());
//final Location location = Location();
//String selectedLocation = 'Dubai International City';

final List<MyDiscoverItem> discoverItems = [
  MyDiscoverItem(
    text: 'Horse',
    imageAsset: AssetImages.horse,
  ),
  MyDiscoverItem(
    text: 'Bike',
    imageAsset: AssetImages.bike,
  ),
  MyDiscoverItem(
    text: 'Hiking',
    imageAsset: AssetImages.hike,
  ),
  MyDiscoverItem(
    text: 'Camel',
    imageAsset: AssetImages.pedal,
  ),
  MyDiscoverItem(
    text: 'Horse',
    imageAsset: AssetImages.hike,
  ),
  MyDiscoverItem(
    text: 'Horse',
    imageAsset: 'assets/images/Horse.png',
  ),
  MyDiscoverItem(
    text: 'Horse',
    imageAsset: 'assets/images/Horse.png',
  ),
  MyDiscoverItem(
    text: 'Horse',
    imageAsset: 'assets/images/Horse.png',
  ),
  // Add more items as needed
];

final List<EventData> eventsData = [
  EventData(
    title: 'Tomorrow will be Boat Event',
    description:
        'lvndsleiibnrbiidlbnilnlxnznbibsibiorboibnbdighorhoiizvlnzlivzvzsgrhgohog',
    imagePath: AssetImages.moto,
    learnMoreLink: 'https://pub.dev/packages/url_launcher/install',
  ),
  EventData(
    title: 'Tomorrow will kite event ',
    description: 'sbdxsnnlrinbinsibidxibi',
    imagePath: AssetImages.moto,
    learnMoreLink: 'https://pub.dev/packages/url_launcher/install',
  ),
  EventData(
    title: 'Tyomoore be fly Event',
    description: 'dbdxbbsneisbeinsi',
    imagePath: AssetImages.moto,
    learnMoreLink: 'https://pub.dev/packages/url_launcher/install',
  ),
  // Add more events as needed
];

List<Widget> pages = [
  const BasicS(),
  const StandardS(),
  const PremiumS(),
];
int currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        // flexibleSpace: ,
        toolbarHeight: 75,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuScreen()));
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 0,
            ),
            child: Image.asset(
              'assets/images/menu.png',
              scale: 1.8,
              color: Colors.black,
            ),
          ),
        ),
        title: Consumer<HomeCtrl>(
          builder: (context, provider, child) => GestureDetector(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapScreen()));
            },
            child: Container(
                height: 5.5 * SizeConfig.heightMultiplier,
                // width: 50 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: AppColors.primaryColor,
                  border: Border.all(color: const Color(0xffA6A6A6)),
                ),
                padding: EdgeInsets.only(
                    right: 2.5 * SizeConfig.widthMultiplier,
                    left: 2.5 * SizeConfig.widthMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.s,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: SizeConfig.textMultiplier * 2.5,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        Text(
                          '${provider.searchController.text} Dubai Internatinal City',
                          style: MyTextStyles.latoTextstyle(
                              SizeConfig.textMultiplier * 1.8, FontWeight.w400),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                )),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.widthMultiplier * 3.5,
                right: SizeConfig.widthMultiplier * 4,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: SvgPicture.asset(AssetImages.bellsvg))),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: MyEdgeInsets.home1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest Update',
                style: MyTextStyles.latoTextstyle(
                    SizeConfig.textMultiplier * 1.8, FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 25 * SizeConfig.heightMultiplier,
                width: 90 * SizeConfig.widthMultiplier,
                child: CarouselSlider(
                  // options:CarouselOptions(
                  //   viewportFraction: 0.5,
                  // ),
                  items: eventsData.map((event) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 90 * SizeConfig.widthMultiplier,
                        decoration: ShapeDecoration(
                          //color: Colors.red,
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.02),
                            end: Alignment(1, 0.02),
                            colors: [Color(0xFF0C2EAB), Color(0xFF030C2A)],
                          ),
                          image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/updateevent.png'),
                              fit: BoxFit.cover),
                          // gradient: LinearGradient(
                          //   begin: Alignment(-1.00, -0.02),
                          //   end: Alignment(1, 0.02),
                          //   colors: [Color(0xFF0C2EAB), Color(0xFF030C2A)],
                          // ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child:
                            //   Container(
                            // width: 88 * SizeConfig.widthMultiplier,
                            // child: Image.asset('assets/images/eventupdate.png',    fit: BoxFit.fill, ),),
                            Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.widthMultiplier * 6,
                            top: SizeConfig.heightMultiplier * 3,
                            bottom: SizeConfig.heightMultiplier * 3,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 40,
                                child: Column(
                                  //  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            event.title,
                                            style:
                                                MyTextStyles.latoTextstylecolor(
                                              SizeConfig.textMultiplier * 2,
                                              FontWeight.w600,
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: width(context) * 0.3,
                                            child: Text(
                                              event.description,
                                              style: MyTextStyles
                                                  .latoTextstylecolor(
                                                SizeConfig.textMultiplier * 1.4,
                                                FontWeight.w500,
                                                Colors.white.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle Learn More link tap
                                          launchUrl(
                                              Uri.parse(event.learnMoreLink));
                                        },
                                        child: Container(
                                          width:
                                              SizeConfig.widthMultiplier * 24,
                                          height:
                                              SizeConfig.heightMultiplier * 3.5,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color:
                                                Colors.white.withOpacity(0.34),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.5,
                                                color: Colors.white
                                                    .withOpacity(0.44),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Learn more',
                                              style: MyTextStyles
                                                  .latoTextstylecolor(
                                                SizeConfig.textMultiplier * 1,
                                                FontWeight.w400,
                                                Colors.white.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 35,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    event.imagePath,
                                    // width: SizeConfig.widthMultiplier * 40,
                                    // height: SizeConfig.heightMultiplier * 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    viewportFraction: 1,
                    autoPlay: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Discover',
                style: MyTextStyles.latoTextstyle(
                    SizeConfig.textMultiplier * 1.8, FontWeight.w600),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                'Discover Categories that suits you.',
                style: MyTextStyles.latoTextstylecolor(
                    SizeConfig.textMultiplier * 1.4,
                    FontWeight.w400,
                    const Color(0xFF9F9F9F)),
              ),

              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier *
                    14, // Set the height based on your design
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, //discoverItems.length,
                  itemBuilder: (context, index) {
                    MyDiscoverItem item = discoverItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0), // Adjust spacing as needed
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscoverScreen()));
                          //  Navigator.pushNamed(context, item.routeName);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: Colors.black
                                    .withOpacity(0.03999999910593033),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: SvgPicture.asset(
                                item.imageAsset,
                                // scale: 1.8,
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.01,
                            ),
                            Text(
                              item.text,
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Text(
              //   'Subscription',
              //   style: MyTextStyles.latoTextstyle(
              //       SizeConfig.textMultiplier * 1.8, FontWeight.w600),
              // ),
              // const SizedBox(
              //   height: 2,
              // ),
              // Text(
              //   'Borem ipsum dolor sit amet, consectetur adipiscing elit.',
              //   style: MyTextStyles.latoTextstylecolor(
              //       SizeConfig.textMultiplier * 1.4,
              //       FontWeight.w400,
              //       const Color(0xFF9F9F9F)),
              // ),
              //
              //  SizedBox(
              //   height: height(context) * 0.03,
              // ),
              // Container(
              //   height: SizeConfig.heightMultiplier * 33,
              //   // width: SizeConfig.widthMultiplier*90,
              //   decoration: ShapeDecoration(
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     shadows: [
              //        BoxShadow(
              //         color: Colors.grey.shade400,
              //         blurRadius: 20,
              //         offset: Offset(0, 4),
              //         spreadRadius: 0,
              //       )
              //     ],
              //   ),
              //
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 5),
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 2 * SizeConfig.heightMultiplier,
              //         ),
              //         // categories(),
              //         Flexible(
              //           flex: 3,
              //           child: pages[selectedindex],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // const SizedBox(
              //   height: 15,
              // ),

              Text(
                'Categories',
                style: MyTextStyles.latoTextstyle(
                    SizeConfig.textMultiplier * 1.8, FontWeight.w600),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                'Categories',
                style: MyTextStyles.latoTextstylecolor(
                  SizeConfig.textMultiplier * 1.4,
                  FontWeight.w400,
                  const Color(0xFF9F9F9F),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: CustomButton8(
                          text: "Indoor",
                          backgroundColor: const Color(0xFF0D1632),
                          radius: 30,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: CustomButton8(
                          text: "Outdoor",
                          backgroundColor: Colors.transparent,
                          textColor: Colors.black,
                          radius: 30,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: CustomButton8(
                          text: "Family",
                          backgroundColor: Colors.transparent,
                          textColor: Colors.black,
                          radius: 30,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: CustomButton8(
                          text: "Friends",
                          backgroundColor: Colors.transparent,
                          textColor: Colors.black,
                          radius: 30,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MySize.size10),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: CustomButton8(
                          text: "Solo",
                          backgroundColor: Colors.transparent,
                          textColor: Colors.black,
                          radius: 30,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MySize.screenHeight * 0.30,
                // width: MySize.screenWidth *0.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5, //discoverItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 32,
                        width: SizeConfig.widthMultiplier * 80,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          //  image: DecorationImage(image:  AssetImage('assets/images/justforyou.png')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: [
                            const BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 20,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(children: [
                          Container(
                            height: SizeConfig.heightMultiplier * 22,
                            decoration: const ShapeDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/justforyou.png'),
                                  fit: BoxFit.fill),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x0C000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                          width:
                                              SizeConfig.widthMultiplier * 20,
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                          alignment: Alignment.center,
                                          // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF2538E8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          child: Text(
                                            'Active Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.4,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.30,
                                            ),
                                          )),
                                    ),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Boat',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.textMultiplier * 1.2,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          'Crazy Wednesday!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.textMultiplier * 1.6,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                              size: SizeConfig.textMultiplier *
                                                  1.8,
                                            ),
                                            Text(
                                              'Sudia riyadh',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.4,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),

                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '\$10',
                                    style: MyTextStyles.latoTextstyle(
                                        SizeConfig.textMultiplier * 2,
                                        FontWeight.w600),
                                  ),
                                  Text(
                                    'Entry fee',
                                    style: MyTextStyles.latoTextstyle(
                                        SizeConfig.textMultiplier * 1,
                                        FontWeight.w300),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '158',
                                    style: MyTextStyles.latoTextstyle(
                                        SizeConfig.textMultiplier * 2,
                                        FontWeight.w600),
                                  ),
                                  Text(
                                    'Participant',
                                    style: MyTextStyles.latoTextstyle(
                                        SizeConfig.textMultiplier * 1,
                                        FontWeight.w300),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '30-100',
                                            style: MyTextStyles.latoTextstyle(
                                                SizeConfig.textMultiplier * 2,
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Duration',
                                        style: MyTextStyles.latoTextstyle(
                                            SizeConfig.textMultiplier * 1,
                                            FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ' min\n',
                                    style: MyTextStyles.latoTextstyle(
                                        SizeConfig.textMultiplier * 1,
                                        FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //  Image.asset('assets/images/justforyou.png'),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget categories() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
  //     child: Container(
  //       height: 5.5 * SizeConfig.heightMultiplier,
  //       //width: 90 * SizeConfig.widthMultiplier,
  //       decoration: BoxDecoration(
  //           color: const Color(0xFFF6F6F6), //AppColors.whiteColor,
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color.fromARGB(255, 55, 34, 246).withOpacity(.15),
  //               spreadRadius: 1,
  //               blurRadius: 4,
  //               offset: const Offset(0, 3),
  //             )
  //           ]),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             width: 0 * SizeConfig.widthMultiplier,
  //           ),
  //           catogoriess("Basic".trim(), 0),
  //           const Spacer(),
  //           catogoriess("Standard".trim(), 1),
  //           const Spacer(),
  //           catogoriess("Premium".trim(), 2),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget catogoriess(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedindex = index;
        });
      },
      child: Container(
        height: 5.4 * SizeConfig.heightMultiplier,
        width: 25 * SizeConfig.widthMultiplier,

        // margin:
        //     EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
            color: selectedindex == index
                ? const Color(0xFF2538E8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 2 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w400,
              color: selectedindex == index
                  ? Colors.white // AppColors.whiteColor
                  : const Color(0xFF9F9F9F), //AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
