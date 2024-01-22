import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/screens/post_details_&_confirm_bookings/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global/layout/sizes_class.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: const AssetImage(AssetImages.justforyou2),
                  height: height(context) * 0.4,
                  width: width(context),
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: MySize.size70,
                  child: Container(
                    width: width(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.black)
                              ]),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    // clipBehavior: Clip.none,
                                    builder: (BuildContext context) {
                                      // return MyBottomSheet();
                                      return Container(
                                        height: height(context)*0.6,
                                        width: width(context),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25)
                                          ),
                                          color: Colors.white,

                                        ),
                                          padding: EdgeInsets.all(16.0),

                                          child: SingleChildScrollView(child: MyBottomSheet())

                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10, color: Colors.black)
                                    ]),
                                    child: SvgPicture.asset(
                                      AssetImages.flag,
                                      height: 30,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10, color: Colors.black)
                                  ]),
                                  child: SvgPicture.asset(AssetImages.share,
                                      height: 30)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  // height: height(context)*2,
                  width: width(context),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 40),
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
                                  'Bike Event soon!',
                                  style: TextStyle(
                                      fontSize: MySize.size16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    Text('Saudi Arabia, Riyadh')
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: MySize.size40,
                              width: MySize.size140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xff0D1632),
                              ),
                              child: Center(
                                  child: Text(
                                'Active',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: MySize.size16),
                              )),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('5.0 /'),
                            Text(
                              '+100',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Prople',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          'Gorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyText),
                        ),
                        const Text(
                          'Desciption',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const Text(
                            'Dive into a world of aquatic wonders with our boat activity experience! Whether you'
                            're craving a serene cruise along tranquil waters or an adrenaline-fueled adventure '
                            'on the high seas,we offers an unforgettable voyage for every explorer. Navigate '
                            'through scenic landscapes, feel the gentle caress of the breeze, '
                            'and create lasting memories aboard our well-equipped vessels.'
                            ' Our skilled captains ensure a safe and enjoyable journey,'
                            ' making each moment on the water a celebration of nature'
                            's beauty and the thrill of maritime exploration.'
                            ' Embark on a nautical adventure with us, where the horizon is your only limit',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyText)),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff0D1632),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  children: [
                                    Text(
                                      '\$10',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Entry fee',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 1.0, // Thickness of the divider
                                  color: Colors.white,
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      '150',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Participants',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 1.0, // Thickness of the divider
                                  color: Colors.white,
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      '30-120 min',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      'Duration',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Facilities',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade300)
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: SvgPicture.asset(AssetImages.burger)),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade300)
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: SvgPicture.asset(AssetImages.shower)),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade300)
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: SvgPicture.asset(AssetImages.bed)),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade300)
                                ],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: SvgPicture.asset(AssetImages.drinks)),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Location',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: width(context),
                          height: MySize.size200,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10, color: Colors.grey.shade400)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(AssetImages.map),
                                  fit: BoxFit.fill)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              width: width(context),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  Text('View Direction'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: MySize.size230,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    height: MySize.size200,
                                    width: width(context) * 0.80,
                                    decoration: BoxDecoration(
                                        color: const Color(
                                          0xffF6F6F6,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Danyal Ahmed',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primaryColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primaryColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.primaryColor,
                                                ),
                                                Icon(
                                                  Icons.star_border,
                                                  color: AppColors.primaryColor,
                                                ),
                                                Icon(
                                                  Icons.star_border,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Dorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                            ' Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'
                                            ' Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
                                            ' per inceptos himenaeos.',
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: MySize.size50,
                                width: MySize.size50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              MyButtonContainer2(
                                containerColor: AppColors.primaryColor,
                                textColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookScreen()));
                                },
                                buttonText: 'Book Now',
                                width: width(context) * 0.7,
                                height: height(context) * 0.07,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Report',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Text(
              'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Reason',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                value: checkBox1,
                onChanged: (value) {
                  setState(() {
                    checkBox1 = value!;
                  });
                },
              ),
              Text('Option 1'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,

                value: checkBox2,
                onChanged: (value) {
                  setState(() {
                    checkBox2 = value!;
                  });
                },
              ),
              Text('Option 2'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                value: checkBox3,
                onChanged: (value) {
                  setState(() {
                    checkBox3 = value!;
                  });
                },
              ),
              Text('Option 3'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                value: checkBox4,
                onChanged: (value) {
                  setState(() {
                    checkBox4 = value!;
                  });
                },
              ),
              Text('Option 4'),
            ],
          ),
          SizedBox(height: MySize2.size16),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 5.0),

          TextFormField(
            controller: descriptionController,
            maxLines: 3,
            style: TextStyle(fontSize:  MySize2.size10),
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: MySize2.size10),
              hintText: 'Description',
              filled: true,

              fillColor: AppColors.greyText.withOpacity(0.3),
              // border: OutlineInputBorder(),
              // contentPadding: EdgeInsets.all(16.0), // Inner padding
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Border radius
                borderSide: BorderSide.none, // No borders
              ),
            ),
          ),
          SizedBox(height: MySize2.size16),
          MyButtonContainer2(
            height: MySize2.size50,
            onTap: () {
              // Handle submit logic here
              // For example, you can print the selected options and description
              print('Checkbox 1: $checkBox1');
              print('Checkbox 2: $checkBox2');
              print('Checkbox 3: $checkBox3');
              print('Checkbox 4: $checkBox4');
              print('Description: ${descriptionController.text}');
              // You can add additional logic here, such as sending the report data to a server
              Navigator.pop(context); // Close the bottom sheet
            },
            containerColor: AppColors.primaryColor,
            textColor: Colors.white,
            buttonText: 'Submit',
          ),
        ],
      ),
    );
  }
}
