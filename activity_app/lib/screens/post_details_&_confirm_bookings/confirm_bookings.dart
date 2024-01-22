import 'package:activityapp/global/component/booking_container.dart';
import 'package:activityapp/global/layout/asset_images.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:activityapp/screens/booking_screens/component/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global/colors.dart';
import '../../global/component/buttoncontainer.dart';
import '../../global/layout/padding_screen.dart';
import '../../global/layout/sizeconfig.dart';
import '../../global/layout/sizes_class.dart';
import '../../global/layout/textstyle.dart';
import '../search_screen/component/event_card_container.dart';

class ConfirmBookings extends StatefulWidget {
  const ConfirmBookings({Key? key}) : super(key: key);

  @override
  State<ConfirmBookings> createState() => _ConfirmBookingsState();
}

class _ConfirmBookingsState extends State<ConfirmBookings> {
  String _paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    MySize2().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          'Confirm Bookings',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[
                Padding(
                  padding: MyEdgeInsets.booking2,
                  child: Container(
                    height: MySize2.size230,
                    decoration: ShapeDecoration(
                      color: AppColors.ticketcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on,size: 40,color: AppColors.primaryColor,),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4,),
                                    Text('Name', style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 2,
                                        FontWeight.w500, AppColors.textColorblack),
                                    ),
                                    Text('Saudi Arabia, Riyadh', style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.8,
                                        FontWeight.w400, AppColors.greyText),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                           Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Text('Booking ID', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                                  Text('#34232354', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                                ],
                              ),
                              SizedBox(height: MySize2.size10,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                                  Text('19, April, 2023', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                                ],
                              ),
                              SizedBox(height: MySize2.size10,),

                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Time', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                                  Text('11:00 AM - 12:00 PM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 110,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      //  Image.asset('assets/images/spacing.png'),
                      Expanded(
                        child: Container(
                          height: 5,
                          decoration: const BoxDecoration(
                            //image: DecorationImage(image: AssetImage('assets/images/spacing.png')),
                          ),
                          child: Image.asset('assets/images/spacing.png'),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BookingContainer(
                    height: MySize2.size220,
                    width: width(context),
                    color: AppColors.ticketcolor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AssetImages.wallet),
                              SizedBox(width: MySize2.size6,),
                              Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w500,fontSize: MySize2.size16),)
                            ],
                          ),


                          RadioListTile(
                            title: Row(
                              children: [
                                SvgPicture.asset(AssetImages.creditCard),
                                SizedBox(width: MySize2.size6,),
                                Text('Pay via Card'),
                              ],
                            ),
                            value: 'card',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Row(
                              children: [
                                SvgPicture.asset(AssetImages.money),
                                SizedBox(width: MySize2.size6,),
                                Text('Pay via Cash'),
                              ],
                            ),
                            value: 'Cash',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                  ),
                  SizedBox(height: MySize2.size20,),
                  BookingContainer(
                    height: MySize2.size200,
                    width: width(context),
                    color: AppColors.ticketcolor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(AssetImages.wallet),
                              SizedBox(width: MySize2.size6,),
                              Text('Payment Summary', style: TextStyle(fontWeight: FontWeight.w500,fontSize: MySize2.size16),),

                            ],
                          ),
                          SizedBox(height: MySize2.size30,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Per Participent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                              Text('AED.500', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                            ],
                          ),
                          SizedBox(height: MySize2.size10,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Participant', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                              Text('1', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                            ],
                          ),
                          SizedBox(height: MySize2.size10,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total to Pay', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: AppColors.greyText),),
                              Text('AED.500', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, ),)
                            ],
                          ),




                        ],
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('Total',  style: TextStyle(
                              fontSize: MySize.size10, fontWeight: FontWeight.w400, color: AppColors.greyText),),
                          SizedBox(height: MySize.size10,),
                          Row(
                            children: [
                              Text('500',  style: TextStyle(
                                  fontSize: MySize.size20, fontWeight: FontWeight.w500),),
                              SizedBox(width: 5,),
                              Text('AED',  style: TextStyle(
                                  fontSize: MySize.size20, fontWeight: FontWeight.w400, color: AppColors.greyText),)
                            ],
                          )
                        ],
                      ),
                      MyButtonContainer2(containerColor: AppColors.primaryColor, textColor: Colors.white,
                        onTap: (){
                          showCustomDialog(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmBookings()));
                        }, buttonText: 'Book Now',
                        width: width(context)*0.65,
                        height: height(context) * 0.07,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            // backgroundColor: Colors.red,
          content: BookingContainer(
            height: height(context)*0.55,
            width: MySize2.size300,
            // color: Colors.white,
            child: Column(
              children: [
                SvgPicture.asset(AssetImages.success),
                SizedBox(height: MySize2.size5,),
                Text('Congratulations!'
                  , style: TextStyle(fontSize: MySize2.size16,fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                ),
                SizedBox(height: MySize2.size10,),

                Text('Booking Successful!'
                  , style: TextStyle(fontSize: MySize2.size12,fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: MySize2.size5,),

                Text('Congratulations! Your booking is set and secured. Get ready to embark on an unforgettable experience.',textAlign: TextAlign.center
                  , style: TextStyle(fontSize: MySize2.size10,fontWeight: FontWeight.w400,),
                ),
                SizedBox(height: MySize2.size10,),

                Text('Booking ID #5443534463'
                  , style: TextStyle(fontSize: MySize2.size12,fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: MySize2.size10,),

                EventCard(
                  title: 'Boat',
                  subtitle: 'Crazy Wednesday!',
                  location: 'Sudia Riyadh',
                  entryFee: '10\$',
                  participants: '158',
                  duration: '30-100',
                  imagePath: 'assets/images/justforyou.png',
                  num: 1,
                ),

              ],
            ),
          )

        );
      },
    );
  }
}
