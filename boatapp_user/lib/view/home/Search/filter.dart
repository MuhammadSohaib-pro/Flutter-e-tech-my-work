import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/provider/filter_provider.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/home/Search/search_result2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/big_divider.dart';
import '../../../custom_widgets/calender.dart';
import '../../../custom_widgets/divider.dart';
import '../../../languages/LocaleString.dart';
import '../../../provider/date_provider.dart';
import '../../../utils/sizes_class.dart';
import '../../bottomBar/bottom_bar.dart';
import '../homescreen/provider/homescreen_tile_provider.dart';
import '../../../utils/sizes.dart';

class FilterScreen extends StatefulWidget {
  final String? searchText;
  final String? maxPerson;
  const FilterScreen({Key? key, required this.searchText, required this.maxPerson}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _currentSelectedValue;
  var hours;

  double? start = 0;
  double? startPassengers = 0;

  var i;
  var j;

  double? end = 5000;
  double? endPassengers ;
  void setPassengers(){
    endPassengers = double.parse(widget.maxPerson!);
    setState(() {

    });

  }


  double? startTime = 0.0;
  double? endTime = 1439.0; // 1439 represents 11:59 PM in minutes
  int iTime = 0;
  int hoursTime = 0;
  // final _currencies = [
  //   "Food",
  //   "Transport",
  //   "Personal",
  //   "Shopping",
  //   "Medical",
  //   "Rent",
  //   "Movie",
  //   "Salary"
  // ];
  double _currentTime = 0.0;
  String _formattedTime = '00:00';
  void fetchData() async {
    int? max = await getMaxPersonBoat();
    endPassengers = max?.toDouble();
    print(endPassengers);

   setState(() {

   });
  }
  @override
  void initState() {
    setPassengers();
    // fetchData();
    // TODO: implement initState
    super.initState();
  }

  // String _formatTime(double value) {
  //   int hours = (value ~/ 60) % 12;
  //   int minutes = (value % 60).toInt();
  //   String formattedHours = hours == 0 ? '12' : hours.toString().padLeft(2, '0');
  //   String formattedMinutes = minutes.toString().padLeft(2, '0');
  //   String period = (value ~/ 60) < 12 ? 'AM' : 'PM';
  //   return '$formattedHours:$formattedMinutes $period';
  // }
  // String startDate = '15/06/2022';
  // String endDate = '19/06/2022';
  // DateTime selectedDate = DateTime.now();
  // Future<DateTime?> selectDate(BuildContext context) async {
  //   final date = await showDatePicker(
  //       context: context,
  //       firstDate: DateTime(1900),
  //       initialDate: selectedDate,
  //       lastDate: DateTime(2100));
  //   if (date != null) {
  //     startDate = date.toString().split(' ')[0];
  //     return date;
  //   } else {
  //     return selectedDate;
  //   }
  // }
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  Widget build(BuildContext context) {
    // final dateProvider = Provider.of<DateProvider>(context, listen: false);
    print('rebuild');
    final tileProvider = Provider.of<HomeScreenTileProvider>(context, listen: false);
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);


    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Stack(
              children: [
                Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Back_Arrow(
                            ontap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            AppLocale.filter.getString(context),
                            style: text16600,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => FilterScreen(searchText: widget.searchText, maxPerson: widget.maxPerson,),
                                  transitionDuration: Duration(seconds: 0), // Set the duration to zero
                                ),
                              );
                              tileProvider.updateSelectedIndex(-1, 'All');
                              },
                            child: Text(
                               AppLocale.reset.getString(context),

                              style: text14500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocale.categories.getString(context),
                        style: text14500,
                      ),


                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                      //   child: Center(
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(16),
                      //           border: Border.all(width: 0.5,
                      //               color: Color(0xffD0DBEA)),
                      //       ),
                      //       height: 55,
                      //       width: width(context),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: DropdownButton<String>(
                      //           isExpanded: true,
                      //           // alignment: AlignmentDirectional.bottomEnd,
                      //           underline: Container(),
                      //
                      //           borderRadius: BorderRadius.circular(16),
                      //           value: _currentSelectedValue,
                      //           items: _currencies.map((String item) {
                      //             return DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(item),
                      //             );
                      //           }).toList(),
                      //           onChanged: (newValue) {
                      //             setState(() {
                      //               _currentSelectedValue = newValue;
                      //             });
                      //           },
                      //           hint: Text(AppLocale.allCategory.getString(context)),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Center(
                          child: Consumer<HomeScreenTileProvider>(
                            builder: (context, value, child){
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: SizeConfig.heightMultiplier * 4,
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('typesOfBoats').where('status', isEqualTo: 'available').snapshots(),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData){
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      tileProvider.updateSelectedIndex(-1, 'All');
                                                    });
                                                  },
                                                  child: tileProvider.selectedIndex
                                                      == -1 ?
                                                  Container(
                                                    height: 4 * SizeConfig.heightMultiplier,
                                                    width:20 * SizeConfig.widthMultiplier,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        color: secondaryColor),
                                                    child: Center(
                                                        child: Text(
                                                          AppLocale.all.getString(context),
                                                          style: text14500white,
                                                        )),
                                                  ):
                                                  Container(
                                                    height: 4 * SizeConfig.heightMultiplier,
                                                    width:20 * SizeConfig.widthMultiplier,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        border: Border.all(color: Colors.black45,width: 0.5)
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                          AppLocale.all.getString(context),
                                                          style: text14500grey,
                                                        )),
                                                  )),
                                              const SizedBox(width: 2.5,),
                                              ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount:snapshot.data!.docs.length,
                                                  itemBuilder: (context, index) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:  EdgeInsets.symmetric(horizontal: MySize2.size5),
                                                          child: InkWell(
                                                              onTap: (){
                                                                tileProvider.updateSelectedIndex(index, snapshot.data!.docs[index]['name']);
                                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=> Offers_screen()));
                                                              },
                                                              child:tileProvider.selectedIndex == index?
                                                              Container(
                                                                height: 4 * SizeConfig.heightMultiplier,
                                                                width: index ==2 ? 30 * SizeConfig.widthMultiplier: 25 * SizeConfig.widthMultiplier,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    color: secondaryColor),
                                                                child: Center(
                                                                    child: Text(


                                                                      localization.currentLocale!.languageCode.toString() == 'en'?
                                                                      snapshot.data!.docs[index]['name']
                                                                          :
                                                                      snapshot.data!.docs[index]['nameAr'],
                                                                      style: text14500white,
                                                                    )),
                                                              ):
                                                              Container(
                                                                height: 4 * SizeConfig.heightMultiplier,
                                                                width: index ==2 ? 30 * SizeConfig.widthMultiplier: 25 * SizeConfig.widthMultiplier,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30),
                                                                    border: Border.all(color: Colors.black45, width: 0.5)

                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                      localization.currentLocale!.languageCode.toString()== 'en'?

                                                                      snapshot.data!.docs[index]['name']:
                                                                      snapshot.data!.docs[index]['nameAr'],
                                                                      style: text14500grey,
                                                                    )),
                                                              )
                                                          ),
                                                        ),



                                                      ],
                                                    );
                                                  }
                                              ),
                                            ],
                                          );



                                        }
                                        else if( snapshot.hasError){
                                          return Center(child: Icon(Icons.error));
                                        }
                                        else if( snapshot.connectionState == ConnectionState.waiting){
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        return Container();
                                      }
                                  ),
                                ),
                              );
                            },

                          ),
                        ),
                      ),

                      Text(
                        AppLocale.pricing.getString(context),
                        style: text14500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 15 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${start!.toStringAsFixed(0)} SAR",
                              style:text12400op,
                            ),
                            Text("${end!.toStringAsFixed(0)} SAR",
                              style:text12400op,
                            ),
                          ],
                        ),
                      ),
                      RangeSlider(
                        min: 0,
                        values: RangeValues(start!, end!),
                        max: 5000,

                        inactiveColor: const Color(0xffF4F5F7),
                        activeColor: primaryColor,
                        // labels: RangeLabels(
                        //   _currentRangeValues.start.round().toString(),
                        //   _currentRangeValues.end.round().toString(),
                        // ),
                        onChanged: (value) {
                          setState(() {
                            start = value.start.toDouble();
                            end = value.end.toDouble();
                            i = hours = end!.toInt() - start!.toInt();
                            print(i);
                          });
                        },
                      ),
                      Text(
                        'Passengers',//AppLocale.dateAndTime.getString(context),
                        style: text14500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 15 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(startPassengers!.toStringAsFixed(0),
                              style:text12400op,
                            ),
                            Text(endPassengers!.toStringAsFixed(0),
                              style:text12400op,
                            ),
                          ],
                        ),
                      ),

                      RangeSlider(
                        min: 0,
                        max: 500,//endPassengers! < 30 ? 55: endPassengers! ,
                        values: RangeValues(startPassengers!, endPassengers!),

                        inactiveColor: const Color(0xffF4F5F7),
                        activeColor: primaryColor,
                        // labels: RangeLabels(
                        //   _currentRangeValues.start.round().toString(),
                        //   _currentRangeValues.end.round().toString(),
                        // ),
                        onChanged: (value) {
                          setState(() {
                            startPassengers = value.start.toDouble();
                            endPassengers = value.end.toDouble();
                            j = hours = endPassengers!.toInt() - startPassengers!.toInt();
                            print(i);
                          });
                        },
                      ),



                    ],
                  ),
                )
        ],
      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: width(context)*0.9,
                      child: AppButton(onPressed: (){


                        filterProvider.updateFilter(
                            start!.toInt(),
                            end!.toInt(),
                            startPassengers!.toInt(),
                            endPassengers!.toInt(),
                          tileProvider.selectedIndex!,
                          tileProvider.getName!,
                        );
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            SearchResult(searchh: widget.searchText,)), (Route<dynamic> route) => false);
                        }, text: AppLocale.search.getString(context),)),
                )

              ],
            ),
          )),
    );
  }


  Future<int?> getMaxPersonBoat() async {
    try {
      // Get the collection reference
      CollectionReference boatCollection = FirebaseFirestore.instance.collection('BoatData');

      // Get the documents in the collection
      QuerySnapshot querySnapshot = await boatCollection.get();

      // Check if there are any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Initialize variables to keep track of maxPerson and the corresponding document
        int maxPerson = 0;
        DocumentSnapshot? maxPersonDocument;

        // Loop through each document in the collection
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Get the 'maxPerson' field from the document and convert it to an integer
          int currentMaxPerson = int.tryParse(document['maxPerson'] ?? '') ?? 0;

          // Check if the current 'maxPerson' is greater than the current maxPerson
          if (currentMaxPerson > maxPerson) {
            // Update maxPerson and the corresponding document
            maxPerson = currentMaxPerson;
            maxPersonDocument = document;
            print(maxPerson);
            print(maxPersonDocument);
          }
        }

        // Return the document with the largest 'maxPerson' value
        return maxPerson;
      } else {
        // Return null if the collection is empty
        return null;
      }
    } catch (error) {
      // Handle errors (e.g., network issues, Firestore exceptions)
      print('Error: $error');
      return null;
    }
  }


}
