
import 'package:boat_app/custom_widgets/reuseable_container.dart';
import 'package:boat_app/global.dart';
import 'package:boat_app/provider/Date_Provider_class.dart';
import 'package:boat_app/provider/loading_provider/loading_provider.dart';
import 'package:boat_app/provider/time_slider_provider.dart';
import 'package:boat_app/utils/MySize.dart';
import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/booking/thankyou_screen.dart';
import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/app_button.dart';
import '../../custom_widgets/back_arrow.dart';
import '../../custom_widgets/divider.dart';
import '../../languages/LocaleString.dart';
import '../../provider/loading_provider/time_slot_provider.dart';
import '../../utils/colors.dart';
import '../../utils/sizes_class.dart';
import '../../utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class BookingScreenNew extends StatefulWidget {
  final String boatId, ownerId;
  // final int index;

  const BookingScreenNew(
      {Key? key,
        // required this.index,
        required this.boatId,
        required this.ownerId})
      : super(key: key);

  @override
  State<BookingScreenNew> createState() => _BookingScreenNewState();
}

class _BookingScreenNewState extends State<BookingScreenNew> {




  // String? startT;
  // String? endT;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MySize2().init(context);
    final timeSlotProvider =
    Provider.of<TimeSlotProvider>(context, listen: false);
    final loadingprovider =
    Provider.of<LoadingProvider>(context, listen: false);
    final DateProvider =
    Provider.of<RangeDatePickerValueModel>(context, listen: false);
    // final orderProvider =
    // Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(elevation: 0,
      centerTitle: true,
      title: const Text('Select Duration'),),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('BoatData').doc(widget.boatId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return const Icon(Icons.error);
            } else if (snapshot.hasData) {
              // int index = selectPackageProvider.selectedIndex!;
              // print(index);
              // print(widget.boatId);
              String name = snapshot.data!['boatName'];
              if (kDebugMode) {
                print(name);
              }
              String price =
              snapshot.data!['boatPrice'];
              String image = snapshot.data!['image1'];
              String maxPerson = snapshot.data!['maxPerson'];
      
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(MySize2.size20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Date',
                            //AppLocale.termsAndConditions.getString(context),
                            style: text16600,
                          ),
                          CalendarDatePicker2(

                              config: CalendarDatePicker2Config(
                                selectedDayHighlightColor: primaryColor,
                                firstDate: DateTime.now(),
                                dayBorderRadius: BorderRadius.circular(15)
                              ),
                              value: DateProvider.value,
                              onValueChanged: (dates) {
                                DateProvider.setValue(dates);
                                timeSlotProvider.clearSlot();
                              }


                          ),


                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('BoatData')
                                  .doc(snapshot.data!['boatId']).collection('daysTime').snapshots(),
                              builder: (context, snapshot2) {
                                return Consumer<RangeDatePickerValueModel>(
                                  builder: (context, value, child){
                                    if(snapshot2.hasError){
                                      return const Icon(Icons.error);
                                    }
                                    else if(snapshot2.hasData){
                                      return StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('BoatData').doc(widget.boatId)
                                            .snapshots(),
                                        builder: (context, snapshot3) {
                                          if (snapshot3.hasError) {
                                            return const Text('error');
                                          }
                                          if (snapshot3.hasData) {
                                            DateTime? date = DateProvider.value[0];
                                            int sDay =date!.weekday;
                                            String day =   getDayOfWeek(sDay);
                                            int startTime = snapshot3.data!['startTime'];
                                            int endTime = snapshot3.data!['endTime'];
                                            int interval = snapshot3.data!['interval'];
                                            double result = (endTime - startTime)/ interval;
                                            TimeOfDay? time;
                                            List<TimeOfDay> ime = [];
                                            for(int i =1; i<= result; i++){
                                              if (kDebugMode) {
                                                print(startTime);
                                              }
                                              int hours = startTime ~/ 60; // Get the quotient of totalMinutes divided by 60
                                              int minutes = startTime % 60; // Get the remainder of totalMinutes divided by 60

                                              time = TimeOfDay(hour: hours, minute: minutes);
                                              startTime = startTime+ interval;
                                              ime.add(time);
                                            }
                                            print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
                                            List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

                                            return  Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocale.boatingDuration.getString(context),
                                                      style: text16600,
                                                    ),

                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 6,
                                                              height: 6,
                                                              decoration: const ShapeDecoration(
                                                                shape: OvalBorder(
                                                                  side: BorderSide(width: 1.20, color: appGreyColor),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MySize2.size6,
                                                            ),
                                                            Text(AppLocale.booked.getString(context), style: text10400,)
                                                          ],
                                                        ),
                                                         SizedBox(
                                                          width: MySize2.size15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 6,
                                                              height: 6,
                                                              decoration: const ShapeDecoration(
                                                                shape: OvalBorder(
                                                                  side: BorderSide(width: 1.20, color: appGoldColor),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MySize2.size6,
                                                            ),
                                                            Text(AppLocale.confirmed.getString(context), style: text10400,)
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),




                                          snapshot2.data!.docs[0]['Monday'] == day && snapshot2.data!.docs[0]['Monday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print('tis is ime : $timeS');
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                            style: greySlotTextStyle),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),
                                                                        style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                            style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),
                                                                        style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),
                                                                        style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return SizedBox(
                                                                      width: 114,
                                                                      height: 30.0,
                                                                      child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey, // You can customize the base color
                                                                        highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            border: Border.all(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );                                                             },
                                                ):
                                                snapshot2.data!.docs[0]['Tuesday'] == day && snapshot2.data!.docs[0]['Tuesday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print('tis is ime : $timeS');
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),
                                                                        style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),
                                                                        style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),
                                                                        style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style:selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),
                                                                        style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return SizedBox(
                                                                      width: 114,
                                                                      height: 30.0,
                                                                      child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey, // You can customize the base color
                                                                        highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            border: Border.all(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );                                                             },
                                                ):
                                                snapshot2.data!.docs[0]['Wednesday'] == day && snapshot2.data!.docs[0]['Wednesday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print(timeS);
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' '))
                                                                  .snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty? // 1st condition
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'? //2nd condition
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?   //3rd condition
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child:Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(6),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    )
                                                                    :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style:selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context),style: selectedSlotTextStyle,)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context),style: unselectedSlotTextStyle,)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return Shimmer.fromColors(
                                                                    baseColor: Colors.grey, // You can customize the base color
                                                                    highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                    child: Container(
                                                                      width: MySize2.size100,
                                                                      height: 25,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(3),
                                                                        border: Border.all(color: Colors.grey),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );                                                          },
                                                ):
                                                snapshot2.data!.docs[0]['Thursday'] == day && snapshot2.data!.docs[0]['Thursday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print(timeS);
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child:  Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return SizedBox(
                                                                      width: 100,
                                                                      height: 15.0,
                                                                      child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey, // You can customize the base color
                                                                        highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            border: Border.all(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );
                                                  },
                                                ):
                                                snapshot2.data!.docs[0]['Friday'] == day && snapshot2.data!.docs[0]['Friday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print(timeS);
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child:Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                     return SizedBox(
                                                                      width: MySize2.size100,
                                                                      height: MySize2.size25,
                                                                      child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey, // You can customize the base color
                                                                        highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            border: Border.all(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );
                                                  },
                                                ):
                                                snapshot2.data!.docs[0]['Saturday'] == day && snapshot2.data!.docs[0]['Saturday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print('tis is ime : $timeS');
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child:Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return SizedBox(
                                                                    width: 114,
                                                                    height: 30.0,
                                                                    child: Shimmer.fromColors(
                                                                      baseColor: Colors.grey, // You can customize the base color
                                                                      highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),
                                                                        ),
                                                                    ),
                                                                  ));
                                                                }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );                                                             },
                                                ):
                                                snapshot2.data!.docs[0]['Sunday'] == day && snapshot2.data!.docs[0]['Sunday'] != ''?
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: result.floor(),
                                                  padding: const EdgeInsets.all(0),
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3, // Number of columns in the grid
                                                    crossAxisSpacing: 0.0,
                                                    childAspectRatio: 1/0.4,
                                                    mainAxisSpacing:0.0,

                                                  ),
                                                  itemBuilder: (context, index) {
                                                    String timeS = ime[index].format(context);
                                                    if (kDebugMode) {
                                                      print('tis is ime : $timeS');
                                                    }
                                                    return Consumer<TimeSlotProvider>(
                                                        builder: (context,value, child){
                                                          return StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance
                                                                  .collection('orders').where('boatId', isEqualTo: snapshot.data!['boatId'])
                                                                  .where('timeSlot', isEqualTo: timeS).where('startDate',
                                                                  isEqualTo: DateProvider.value[0].toString().replaceRange(10, 23, ' ')).snapshots(),
                                                              builder: (context, snapshotO) {

                                                                if(snapshotO.hasError){
                                                                  return const Icon(Icons.error);
                                                                }
                                                                else if(snapshotO.hasData){
                                                                  DateTime date = DateProvider.value[0]!;
                                                                  if (kDebugMode) {
                                                                    print(date.toString().replaceRange(10, 23, ''));
                                                                  }

                                                                  return  Padding(
                                                                    padding:  EdgeInsets.symmetric(horizontal: MySize2.size4, vertical: MySize2.size8),
                                                                    child:
                                                                    snapshotO.data!.docs.isNotEmpty?
                                                                    snapshotO.data!.docs[0]['status'] == 'Booked'?
                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGreyColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child:Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: greySlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Booked',
                                                                            style: TextStyle(
                                                                              color: appGreyColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),// booked
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    snapshotO.data!.docs[0]['status'] == 'Confirmed'?

                                                                    snapshotO.data!.docs[0]['startDate'] == date.toString().replaceRange(10, 23, ' ')?
                                                                    Container(
                                                                      decoration: ShapeDecoration(
                                                                        shape: RoundedRectangleBorder(
                                                                          side: const BorderSide(width: 1, color: appGoldColor),
                                                                          borderRadius: BorderRadius.circular(3),
                                                                        ),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(ime[index].format(context),
                                                                              style: goldSlotTextStyle
                                                                          ),
                                                                          const Text(
                                                                            'Confirmed',
                                                                            style: TextStyle(
                                                                              color: appGoldColor,
                                                                              fontSize: 6,
                                                                              fontWeight: FontWeight.w500,

                                                                            ),
                                                                          )

                                                                        ],
                                                                      ),
                                                                    ):

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :
                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                        :

                                                                    timeSlotProvider.index == index?
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: primaryColor),
                                                                          color: primaryColor

                                                                      ),
                                                                      child: Center(child: Text(ime[index].format(context), style: selectedSlotTextStyle)),
                                                                    ):
                                                                    InkWell(
                                                                      onTap: (){
                                                                        timeSlotProvider.updateSLot(index, ime[index].format(context));
                                                                      },
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(3),
                                                                          border: Border.all(color: Colors.grey),

                                                                        ),
                                                                        child: Center(child: Text(ime[index].format(context), style: unselectedSlotTextStyle)),
                                                                      ),
                                                                    )
                                                                    ,
                                                                  );
                                                                }else if(snapshotO.connectionState == ConnectionState.waiting){
                                                                  return SizedBox(
                                                                      width: 114,
                                                                      height: 30.0,
                                                                      child: Shimmer.fromColors(
                                                                        baseColor: Colors.grey[300]!, // You can customize the base color
                                                                        highlightColor: Colors.grey[100]!, // You can customize the highlight color
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(3),
                                                                            border: Border.all(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ));                                                                  }
                                                                return Container();
                                                              }
                                                          );

                                                        }
                                                    );                                                             },
                                                ):
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Center(child: Text('No slot available')),
                                                ),



                                              ],
                                            );



                                          }
                                          if(snapshot3.connectionState == ConnectionState.waiting){
                                            return const Center(child: CircularProgressIndicator());
                                          }

                                          return Container();
                                        },
                                      );
                                    }
                                    else if(snapshot2.connectionState == ConnectionState.waiting){
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    else if(!snapshot2.hasData || snapshot2.data!.docs.isEmpty){
                                      const Icon(Icons.error);
                                    }
                                    return Container();




                                  },
                                );
                              }
                          ),
                          SizedBox(height: MySize2.size15,),
                          Text(
                            'Instructions!',
                            //AppLocale.termsAndConditions.getString(context),
                            style: text16600,
                          ),
                          const SizedBox(height: 5,),

                          Text(
                            'Secure your spot effortlessly by selecting your preferred booking time.'
                                ' Click on the clock icon and choose the time that suits you best '
                                '– your adventure begins on your schedule',

                            style: text10400grey,
                          ),
                          SizedBox(
                            height: MySize2.size120,
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: width(context),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // offset: Offset(0, 4),
                              color: grey6,
                              spreadRadius: 0,
                                blurRadius: 3
                            ),
                          ],
                          color: white1,

                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text('Total', style: text10400grey,),
                                  Row(
                                    children: [
                                      Text(price, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                      const SizedBox(width: 5,),
                                      Text('SAR', style: text12400op,),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                              child: Consumer<LoadingProvider>(
                                builder: (context, value, child) {
                                  return AppButton(
                                    loading: loadingprovider.loading,
                                    height: 50,
                                    width: width(context) * 0.65,
                                    onPressed: () async {
                                      bool isConnected = await Utils.checkInternetConnection();
                                      if (isConnected == true) {

                                        // compareTime(timeSlotProvider.value1!);
                                        if (kDebugMode) {
                                          print(DateProvider.value[0]);
                                        }
                                        if (kDebugMode) {
                                          print(DateTime.now());
                                        }
                                        if (kDebugMode) {
                                          print('object');
                                        }
                                        var currentTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
                                        // print( DateFormat('dd/MM/yyyy').format(DateTime.now()));

                                        var date = DateFormat('dd/MM/yyyy').format(DateProvider.value[0]!);
                                        if (kDebugMode) {
                                          print(currentTime);
                                        }
                                        if (kDebugMode) {
                                          print(date);
                                        }
                                        if (kDebugMode) {
                                          print(date == currentTime);
                                        }
                                        // print(DateProvider.value[0]!.isAtSameMomentAs(DateTime.now()) );

                                        bool? timeCheck = isTimeBeforeCurrentTime(timeSlotProvider.value1!);
                                        if (kDebugMode) {
                                          print(timeCheck);
                                        }
                                        if(
                                        DateProvider.value[0]!.isAfter(DateTime.now()) == true ||
                                            ( currentTime == date

                                                && timeCheck == false)
                                        )
                                        {
                                          if (kDebugMode) {
                                            print('gone');
                                          }

                                          if(timeSlotProvider.value1 != null ){
                                            bool? pending = await checkNotPendingStatus(
                                              snapshot.data!['boatId'],
                                              DateProvider.value[0].toString().replaceRange(10, 23, ' '),
                                              timeSlotProvider.value1!,
                                            );

                                            if(pending == true){
                                              Utils.toastMessage('Already in Pending');
                                            }else{
                                              if (kDebugMode) {
                                                print('$pending----------');
                                              }
                                              userOrder().then((value) {
                                                loadingprovider.loginLoading(false);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ThankYouScreen()));
                                              });
                                            }

                                          }
                                          else{
                                            Utils.toastMessage('Please select a time slot');
                                          }
                                        }else{

                                          Utils.toastMessage('Please select a future date and time');
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('No internet connection'),
                                            content: const Text(
                                                'Please check your internet connection and try again.'),
                                            actions: [
                                              ElevatedButton(
                                                child: const Text('OK'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    text: AppLocale.sendRequest.getString(context),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              );
            }
            return Container();
          }
      ),
    );
  }

  Future<void> userOrder() async {
    // final selectPackageProvider =
    //     Provider.of<SelectPackageProvider>(context, listen: false);
    final loadingprovider =
    Provider.of<LoadingProvider>(context, listen: false);
    final timeProvider = Provider.of<TimeProvider>(context, listen: false);

    final timeSlotProvider = Provider.of<TimeSlotProvider>(context, listen: false);

    final dateProvider = Provider.of<RangeDatePickerValueModel>(context, listen: false);
    String? reciverToken = '';
    await FirebaseFirestore.instance.collection("Owner").doc(widget.ownerId).get().then((value){
      if (kDebugMode) {
        print(value.data().toString());
      }
      if(value.data()!.isNotEmpty){
        Map<String,dynamic> data =  value.data() as Map<String,dynamic>;
        reciverToken =  data['token'];
      }
      else{
        reciverToken = null;
      }
    });

    loadingprovider.loginLoading(true);

    String? price = await getBoatPrice(widget.boatId);
    int hours= (timeProvider.iTime / 60).round();

    double? boatPrice = double.parse(price!);
    String? name = await getUserName();

    Map<String, dynamic> userOrdersMap = {
      'userIdB': FirebaseAuth.instance.currentUser!.uid,
      'orderId': id,
      'ownerId': widget.ownerId,
      'startDate': dateProvider.value[0].toString().replaceAll('00:00:00.000', ''),
      'endDate': dateProvider.value[0].toString().replaceAll('00:00:00.000', ''),
      // date adding needed
      'totalDays':'1',
      'timeSlot': timeSlotProvider.value1,
      // 'endTime': _formatTime(timeProvider.endTime!),
      'totalHours': hours.toString(),
      'Amount': boatPrice,
      'paymentType':'',
      'status': 'Pending',
      'userName': name,
      'orderTime': DateTime.now(),
    };
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .set(userOrdersMap).whenComplete((){
          if(reciverToken != null && reciverToken!.isNotEmpty){
            notificationServices.sendPushMessage(reciverToken!, "You have New Booking!", "Booking");
          }else{
            if (kDebugMode) {
              print('No owner token');
            }
            // Utils.toastMessage('No owner token');
          }


    });
    await fetchData();

  }


  Future<void> fetchData() async {
    // final selectPackageProvider =
    //     Provider.of<SelectPackageProvider>(context, listen: false);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('BoatData').where('boatId', isEqualTo: widget.boatId)
        .get();

    //int index = widget.index;

    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot selectedDoc = snapshot.docs[0];
      Map<String, dynamic>? data = selectedDoc.data() as Map<String, dynamic>?;

      if (data != null) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(id)
            .update(data);
      }
    }
  }

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  // bool compareTime(String timeString) {
  //   // Get the current time
  //   DateTime now = DateTime.now();
  //
  //   // Parse the time string and set it to today's date
  //   DateTime time = DateTime(now.year, now.month, now.day, 9, 0); // Change the hour and minute as needed
  //
  //   if (time.isBefore(now)) {
  //     print('$timeString is before the current time.');
  //     return false;
  //
  //   } else if (time.isAfter(now)) {
  //     print('$timeString is after the current time.');
  //     return true;
  //
  //   } else {
  //
  //     print('$timeString is the same as the current time.');
  //     return false;
  //
  //   }
  //
  // }

  bool isTimeBeforeCurrentTime(String timeString) {
    // Get the current time as a DateTime object
    DateTime now = DateTime.now();

    // Create a DateFormat instance for parsing the time string
    DateFormat timeFormat = DateFormat('h:mm a');

    try {
      // Parse the input time string and extract the time portion
      DateTime parsedTime = timeFormat.parse(timeString);
      int hours = parsedTime.hour;
      int minutes = parsedTime.minute;

      // Create a new DateTime object with the current date and the parsed time
      DateTime parsedDateTime = DateTime(now.year, now.month, now.day, hours, minutes);

      // Compare the parsed time with the current time
      return parsedDateTime.isBefore(now);
    } catch (e) {
      // Handle invalid time string format
      if (kDebugMode) {
        print('Invalid time format: $e');
      }
      return false;
    }
  }

// bool isTimeBeforeCurrentTime(String timeString) {
//     print(timeString);
//
//   // Get the current time as a DateTime object
//   DateTime now = DateTime.now();
//
//   // Create a DateFormat instance for parsing the time string
//   DateFormat timeFormat = DateFormat('h:mm a');
//
//   try {
//     // Parse the input time string
//     DateTime parsedTime = timeFormat.parse(timeString);
//     print(parsedTime);
//     print(now);
//
//     // Compare the parsed time with the current time
//     return parsedTime.isBefore(now);
//   } catch (e) {
//     // Handle invalid time string format
//     print('Invalid time format: $e');
//     return false;
//   }
// }



}
