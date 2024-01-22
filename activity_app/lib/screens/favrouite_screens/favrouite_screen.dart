import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

class FavrouiteScreen extends StatefulWidget {
  const FavrouiteScreen({super.key});

  @override
  State<FavrouiteScreen> createState() => _FavrouiteScreenState();
}

class _FavrouiteScreenState extends State<FavrouiteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
         automaticallyImplyLeading: false
        ,        title:  Text(
            'Favourites',
            style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
          ),


      ),
      body: Padding(
        padding: MyEdgeInsets.home1,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Slidable(
                // Specify a key if the Slidable is dismissible.
                key:  ValueKey(0),

                // The start action pane is the one at the left or the top side.


                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 1,
                      onPressed: doNothing,
                      backgroundColor:Color(0xFFFF5757),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    //  label: '',
                    ),

                  ],
                ),

                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child:Column(
                  children: [
                Container(
                  height: SizeConfig.heightMultiplier * 28,
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
                      height: SizeConfig.heightMultiplier * 18,
                      decoration: const ShapeDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: AssetImage('assets/images/justforyou.png'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                    width: SizeConfig.widthMultiplier * 20,
                                    height: SizeConfig.heightMultiplier * 4,
                                    alignment: Alignment.center,
                                    // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF2538E8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Text(
                                      'Active Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 1.4,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.30,
                                      ),
                                    )),
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Boat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.textMultiplier * 1.2,
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
                                      fontSize: SizeConfig.textMultiplier * 1.6,
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
                                        size: SizeConfig.textMultiplier * 1.8,
                                      ),
                                      Text(
                                        'Sudia riyadh',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          SizeConfig.textMultiplier * 1.4,
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
                              '10\$',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 2, FontWeight.w600),
                            ),
                            Text(
                              'Entry fee',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 1, FontWeight.w300),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '158',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 2, FontWeight.w600),
                            ),
                            Text(
                              'Participant',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 1, FontWeight.w300),
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
                                      SizeConfig.textMultiplier * 1, FontWeight.w300),
                                ),

                              ], ),
                            Text(
                              ' min\n',
                              style: MyTextStyles.latoTextstyle(
                                  SizeConfig.textMultiplier * 1, FontWeight.w300),
                            ),

                          ],
                        ),
                      ],
                    ),
                    //  Image.asset('assets/images/justforyou.png'),
                  ]),
                ),

                  ],),
              ),
              SizedBox(height: 15,),
              Slidable(
                // Specify a key if the Slidable is dismissible.
                key:  ValueKey(1),

                // The start action pane is the one at the left or the top side.


                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 1,
                      onPressed: doNothing,
                      backgroundColor:Color(0xFFFF5757),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      //  label: '',
                    ),

                  ],
                ),

                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child:Column(
                  children: [
                    Container(
                      height: SizeConfig.heightMultiplier * 28,
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
                          height: SizeConfig.heightMultiplier * 18,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage('assets/images/justforyou.png'),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                        width: SizeConfig.widthMultiplier * 20,
                                        height: SizeConfig.heightMultiplier * 4,
                                        alignment: Alignment.center,
                                        // padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF2538E8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)),
                                        ),
                                        child: Text(
                                          'Active Now',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: SizeConfig.textMultiplier * 1.4,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        )),
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Boat',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.textMultiplier * 1.2,
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
                                          fontSize: SizeConfig.textMultiplier * 1.6,
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
                                            size: SizeConfig.textMultiplier * 1.8,
                                          ),
                                          Text(
                                            'Sudia riyadh',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              SizeConfig.textMultiplier * 1.4,
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
                                  '10\$',
                                  style: MyTextStyles.latoTextstyle(
                                      SizeConfig.textMultiplier * 2, FontWeight.w600),
                                ),
                                Text(
                                  'Entry fee',
                                  style: MyTextStyles.latoTextstyle(
                                      SizeConfig.textMultiplier * 1, FontWeight.w300),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '158',
                                  style: MyTextStyles.latoTextstyle(
                                      SizeConfig.textMultiplier * 2, FontWeight.w600),
                                ),
                                Text(
                                  'Participant',
                                  style: MyTextStyles.latoTextstyle(
                                      SizeConfig.textMultiplier * 1, FontWeight.w300),
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
                                          SizeConfig.textMultiplier * 1, FontWeight.w300),
                                    ),

                                  ], ),
                                Text(
                                  ' min\n',
                                  style: MyTextStyles.latoTextstyle(
                                      SizeConfig.textMultiplier * 1, FontWeight.w300),
                                ),

                              ],
                            ),
                          ],
                        ),
                        //  Image.asset('assets/images/justforyou.png'),
                      ]),
                    ),

                  ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
  doNothing(BuildContext context){}
}
