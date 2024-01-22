import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/booking_screens/model/booking_model.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback? onTap;

  const BookingCard({required this.booking, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Padding(
        padding: MyEdgeInsets.booking2,
        child: Container(
          height: 190,
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
                    Container(
                      width: 70,
                      height: 70,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(booking.logoImagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(booking.eventName, style: MyTextStyles.poppinsTextstylecolor(
                                  SizeConfig.textMultiplier * 2,
                                  FontWeight.w500, AppColors.textColorblack),
                              ),
                              GestureDetector(
                                onTap:  onTap,
                                child: Icon(Icons.arrow_forward_ios, size: 16),
                              ),
                            ],
                          ),
                          Text(booking.date, style: MyTextStyles.poppinsTextstylecolor(
                              SizeConfig.textMultiplier * 1.8,
                              FontWeight.w400, AppColors.greyText),
                          ),
                          Text(booking.location, style: MyTextStyles.poppinsTextstylecolor(
                              SizeConfig.textMultiplier * 1.8,
                              FontWeight.w400, AppColors.greyText),
                          ),
                          SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Booking ID', style: MyTextStyles.poppinsTextstylecolor(
                                  SizeConfig.textMultiplier * 1.8,
                                  FontWeight.w400, AppColors.greyText),
                              ),
                              Text(booking.bookingId, style: MyTextStyles.poppinsTextstylecolor(
                                  SizeConfig.textMultiplier * 1.8,
                                  FontWeight.w400, AppColors.textColorblack),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      child: Text(booking.status, style: MyTextStyles.poppinsTextstylecolor(
                          8,
                          FontWeight.w400, Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: ShapeDecoration(
                            color: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(300),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Image.asset(booking.smalllogo, color: Colors.white, scale: 4),
                          ),
                        ),
                        SizedBox(width: 3,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.logoText, style: MyTextStyles.latoTextstylecolor(
                                12,
                                FontWeight.w600, AppColors.textColorblack),
                            ),
                            Text(booking.subText, style: MyTextStyles.latoTextstylecolor(
                                6,
                                FontWeight.w600, AppColors.greyText),
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
        ),
      ),
        Positioned(
          bottom: 70,
          left: 5,
          right: 5,
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
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
                  decoration: BoxDecoration(
                    //image: DecorationImage(image: AssetImage('assets/images/spacing.png')),
                  ),
                  child: Image.asset('assets/images/spacing.png'),
                ),
              ),
              Container(
                width: 22,
                height: 22,
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
