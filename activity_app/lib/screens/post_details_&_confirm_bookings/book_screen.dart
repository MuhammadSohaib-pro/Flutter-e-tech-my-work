import 'package:activityapp/global/component/booking_container.dart';
import 'package:activityapp/screens/post_details_&_confirm_bookings/confirm_bookings.dart';
import 'package:flutter/material.dart';

import '../../global/colors.dart';
import '../../global/component/buttoncontainer.dart';
import '../../global/layout/mySize.dart';
import '../../global/layout/sizeconfig.dart';
import '../../global/layout/textstyle.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          'Select Duration',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date',
                style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600),
              ),
              // Container(
              //   height: MySize.size68,
              //   width: MySize.size68,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade300,
              //     borderRadius: BorderRadius.circular(15)
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center ,
              //     children: [
              //       Text('MON', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
              //       SizedBox(
              //         height: MySize.size7,
              //       ),
              //       Text('18 0ct', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
              //     ],
              //   ),
              // ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 15.0),
             child: Container(
               height: MySize.size70,
               child: ListView.builder(
                   itemCount: 7,
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index){
                     return  Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
                       child: BookingContainer(
                         height: MySize.size68,
                         width: MySize.size68,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               'MON',
                               style: TextStyle(
                                   fontWeight: FontWeight.w400, fontSize: 12,
                               color: index == 2? Colors.white : Colors.black
                               ),
                             ),
                             SizedBox(
                               height: MySize.size7,
                             ),
                             Text('18 0ct',
                                 style: TextStyle(
                                     fontWeight: FontWeight.w500, fontSize: 14,
                                     color: index == 2? Colors.white : Colors.black))
                           ],
                         ),
                         color: index ==2 ? AppColors.primaryColor: Colors.grey.shade300,
                       ),
                     );
                   }),
             ),
           ),

              //select time
              Text(
                'Select Time',
                style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: MySize.size70,
                  child: ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: BookingContainer(
                            height: MySize.size68,
                            width: MySize.size68,
                            color: index ==1 ? AppColors.primaryColor :Colors.grey.shade300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 12,
                                      color: index == 1? Colors.white : Colors.black)

                                ),
                                SizedBox(
                                  height: MySize.size7,
                                ),
                                Text('PM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,
                                        color: index == 1? Colors.white : Colors.black))

                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),


              //Duration
              Text(
                'Duration',
                style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: MySize.size70,
                  child: ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: BookingContainer(
                            height: MySize.size68,
                            width: MySize.size68,
                            color: index == 0? AppColors.primaryColor:Colors.grey.shade300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'MIN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 12,
                                      color: index == 0? Colors.white : Colors.black)),

                                SizedBox(
                                  height: MySize.size7,
                                ),
                                Text('30',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14,
                                        color: index ==0? Colors.white : Colors.black))

                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),

              //people
              Text(
                'People',
                style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: MySize.size70,
                  child: ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: BookingContainer(
                            height: MySize.size68,
                            width: MySize.size68,
                            child: Center(
                              child: Text((index+1).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 14,
                                      color: index ==4? Colors.white : Colors.black))
                            ),
                            color:index ==4 ? AppColors.primaryColor: Colors.grey.shade300,
                          ),
                        );
                      }),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              //Instruction

              Text(
                'Instruction!',
                style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Secure your spot effortlessly by selecting your preferred booking time.'
                    ' Click on the clock icon and choose the time that suits you best '
                    '– your adventure begins on your schedule',
                    style: TextStyle(
                    fontSize: MySize.size16, fontWeight: FontWeight.w600, color: Color(0xff9f9f9f)),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmBookings()));
                      }, buttonText: 'Book Now',
                      width: width(context)*0.65,
                      height: height(context) * 0.07,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
