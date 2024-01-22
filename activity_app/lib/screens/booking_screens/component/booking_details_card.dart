import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/booking_screens/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingDatailsCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onTap;



  const BookingDatailsCard({required this.booking, this.onTap});



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: MyEdgeInsets.booking,
                child: Container(
                  height: 290,
                  decoration: ShapeDecoration(
                    color: AppColors.ticketcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: AppColors.primaryColor, size: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.eventName,
                                      style: MyTextStyles.poppinsTextstylecolor(
                                          SizeConfig.textMultiplier * 2.2,
                                          FontWeight.w500,
                                          AppColors.textColorblack),
                                    ),
                                    Text(
                                      booking.location,
                                      style: MyTextStyles.poppinsTextstylecolor(
                                          SizeConfig.textMultiplier * 1.5,
                                          FontWeight.w400,
                                          AppColors.greyText),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 68,
                              height: 17,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: getStatusColor(booking.status),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(300),
                                ),
                              ),
                              child: Text(
                                booking.status,
                                style: MyTextStyles.poppinsTextstylecolor(
                                    8, FontWeight.w400, Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booking ID',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                    booking.bookingId,
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Date ',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                    booking.date,
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Time',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                    booking.time,
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Duration',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                    booking.duration,
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Court',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: ShapeDecoration(
                                          color: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(300),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Image.asset(booking.smalllogo,
                                              color: Colors.white, scale: 4),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking.logoText,
                                            style:
                                                MyTextStyles.latoTextstylecolor(
                                                    12,
                                                    FontWeight.w600,
                                                    AppColors.textColorblack),
                                          ),
                                          Text(
                                            booking.subText,
                                            style:
                                                MyTextStyles.latoTextstylecolor(
                                                    6,
                                                    FontWeight.w600,
                                                    AppColors.greyText),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //   SizedBox(height: 50,),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 5,
                right: 5,
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 35,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
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
                    ClipOval(
                      child: Container(
                        width: 35,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: MyEdgeInsets.booking1,
            child: Column(
              children:[
                Container(
                width: double.infinity,
                height: 200,
                decoration: ShapeDecoration(
                  color: AppColors.ticketcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Wallet.png',
                            color: AppColors.primaryColor,
                            width: 25,
                            height: 25,
                          ),
                          Text(
                            ' Payment Summary',
                            style: MyTextStyles.poppinsTextstylecolor(
                                SizeConfig.textMultiplier * 2.2,
                                FontWeight.w500,
                                AppColors.textColorblack),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Per Participant',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                  'AED.${booking.payment.participentprice}',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Participant',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                      '${booking.payment.totalParticipent}',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total to Pay',
                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.greyText),
                                  ),
                                  Text(
                                    'AED.${(int.parse(booking.payment.participentprice) * int.parse(booking.payment.totalParticipent))}',

                                    style: MyTextStyles.poppinsTextstylecolor(
                                        SizeConfig.textMultiplier * 1.5,
                                        FontWeight.w400,
                                        AppColors.textColorblack),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

               const SizedBox(height: 4,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Booking Date ${booking.payment.bookingDate}',
                    style: MyTextStyles.poppinsTextstylecolor(
                        SizeConfig.textMultiplier * 1.4,
                        FontWeight.w400,
                        AppColors.greyText),
                  ),
                ),
                const SizedBox(height: 6,),
                Align(
                  alignment: Alignment.topLeft,
                  child:SizedBox(
                  width: SizeConfig.widthMultiplier*90,
                  child: Text(
                    'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. C',

                    style: MyTextStyles.poppinsTextstylecolor(
                        SizeConfig.textMultiplier * 1.4,
                        FontWeight.w400,
                        AppColors.greyText),
                  ),
                ),),
          ],  ),
          ),

if(booking.status=='Active')
          Padding(
            padding: MyEdgeInsets.booking,
            child: Column(
              children: [
                MyButtonContainer(
                  containerColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  onTap: () {
// Your onTap logic

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                    // );
                  },
                  buttonText: 'Cancel Booking',
                ),
                const SizedBox(height: 10,),
                MyButtonContainer(
                  containerColor: AppColors.ticketcolor,
                  textColor: Colors.black,
                  onTap: () {
// Your onTap logic

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                    // );
                  },
                  buttonText: 'View Location',
                ),
              ],
            ),
          ),
          if(booking.status=='Completed')
          Padding(
            padding: MyEdgeInsets.booking,
            child:  MyButtonContainer(
              containerColor: AppColors.primaryColor,
              textColor: Colors.white,
              onTap: () {
// Your onTap logic
                showCustomBottomSheet(context);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                // );
              },
              buttonText: 'Write a Review',
            ),
          ),
        ],
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: MyEdgeInsets.booking,
          child:  Column(
            children: [
              AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                title:  Text('Add Review', style: MyTextStyles.poppinsTextstylecolor(
                      SizeConfig.textMultiplier * 1.8,
                      FontWeight.w600,
                      AppColors.textColorblack),),
               centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ],
          ),
        );
      },
    );
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.black;
      case 'Cancelled':
        return const Color(0xFF9F9F9F);
      case 'Completed':
        return AppColors.primaryColor; // replace with the actual primary color
      default:
        return Colors.black; // or any default color
    }
  }
}
