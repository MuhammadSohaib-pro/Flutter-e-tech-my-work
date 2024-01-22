import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/post_details_&_confirm_bookings/post_details.dart';
import 'package:activityapp/screens/search_screen/component/event_card_container.dart';
import 'package:activityapp/screens/search_screen/component/suggestion_component.dart';
import 'package:flutter/material.dart';


class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  bool isTextFieldFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isTextFieldFocused = _focusNode.hasFocus;
      });
    });
  }


  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 0,
          ),
          child: Text(
            'Search',
            style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: MyEdgeInsets.home1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WillPopScope(
                    onWillPop: () async {
                      setState(() {
                        isTextFieldFocused = false;
                      });
                      return true; // Return true to allow back navigation, false to block it
                    },
                    child: Container(
                      width: SizeConfig.widthMultiplier * 75,
                      height: 42,
                      decoration: ShapeDecoration(
                        color: AppColors.ticketcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppColors.greyText, size: 20),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: TextField(
                                focusNode: _focusNode,
                                onTap: () {
                                  setState(() {
                                    isTextFieldFocused = true;
                                  });
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    isTextFieldFocused = false;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: MyTextStyles.poppinsTextstylecolor(
                                    14,
                                    FontWeight.w400,
                                    AppColors.greyText,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(bottom: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  isTextFieldFocused == false ?
                  Container(
                    width: 42,
                    height: 42,
                    decoration: ShapeDecoration(
                      color: AppColors.ticketcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Image.asset('assets/images/filtericon.png',scale: 2.5,),
                  ): Text('Cancel', style: MyTextStyles.poppinsTextstylecolor(12, FontWeight.w500, AppColors.primaryColor),)

                ],
              ),
               
               Expanded(
                 child: Container(

                   child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const SizedBox(height: 30,),
                            Text('Suggestion',style: MyTextStyles.latoTextstylecolor(SizeConfig.textMultiplier*2, FontWeight.w500, AppColors.textColorblack),),

                            const SizedBox(height: 10,),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                SuggestionComponent(text: 'Boat'),
                                SuggestionComponent(text: 'Horse Riding'),
                                SuggestionComponent(text: 'Trip'),

                              ],
                            ),
                            const SizedBox(height: 10,),
                            const SuggestionComponent(text: 'Hiking'),
                            const SizedBox(height:30,),
                            Text('Related',style: MyTextStyles.latoTextstylecolor(SizeConfig.textMultiplier*2, FontWeight.w500, AppColors.textColorblack),),
                            const SizedBox(height: 10,),
                             //

                             Expanded(
                               child: ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                 //physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>PostDetails()));
                                      },
                                      child: EventCard(
                                        title: 'Boat',
                                        subtitle: 'Crazy Wednesday!',
                                        location: 'Sudia Riyadh',
                                        entryFee: '10\$',
                                        participants: '158',
                                        duration: '30-100',
                                        imagePath: 'assets/images/justforyou.png',
                                      ),
                                    );
                                  },
                                ),
                             ),
                          ],),
                 ),
               ),
              //  ),
              

            ],
          ),
        ),
      ),
    );
  }
}