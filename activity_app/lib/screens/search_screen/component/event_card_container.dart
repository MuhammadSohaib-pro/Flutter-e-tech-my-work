import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String location;
  final String entryFee;
  final String participants;
  final String duration;
  final String imagePath;
  final int? num;

  const EventCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.entryFee,
    required this.participants,
    required this.duration,
    required this.imagePath,
    this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 32,
      decoration: ShapeDecoration(
        color: Colors.white,
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
      child: Column(
        children: [
          Container(
            height: SizeConfig.heightMultiplier * 22,
            decoration: ShapeDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
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
                  num != null ? Container() :Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: SizeConfig.widthMultiplier * 20,
                      height: SizeConfig.heightMultiplier * 4,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFF2538E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
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
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
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
                        subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.30,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: SizeConfig.textMultiplier * 1.8,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.textMultiplier * 1.4,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 3.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    entryFee,
                    style: MyTextStyles.latoTextstyle(
                      SizeConfig.textMultiplier * 2,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Entry fee',
                    style: MyTextStyles.latoTextstyle(
                      SizeConfig.textMultiplier * 1,
                      FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    participants,
                    style: MyTextStyles.latoTextstyle(
                      SizeConfig.textMultiplier * 2,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Participant',
                    style: MyTextStyles.latoTextstyle(
                      SizeConfig.textMultiplier * 1,
                      FontWeight.w300,
                    ),
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
                            duration,
                            style: MyTextStyles.latoTextstyle(
                              SizeConfig.textMultiplier * 2,
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Duration',
                        style: MyTextStyles.latoTextstyle(
                          SizeConfig.textMultiplier * 1,
                          FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ' min\n',
                    style: MyTextStyles.latoTextstyle(
                      SizeConfig.textMultiplier * 1,
                      FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
