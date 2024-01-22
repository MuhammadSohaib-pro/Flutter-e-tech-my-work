import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomEmpDetailContainerBig extends StatelessWidget {
  const CustomEmpDetailContainerBig({
    super.key,
    // required this.title,
    // required this.values,
  });
  // final String title;
  // final String values;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      decoration: const ShapeDecoration(
        color: ThemeColors.grey4,
        image: DecorationImage(
            image: AssetImage(imgEmpContainerBgBig),
            fit: BoxFit.fill,
            alignment: Alignment.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x2B000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 6,top: 10),
                  decoration: ShapeDecoration(
                    color: Colors.amberAccent.shade100,
                    shape: const CircleBorder(),
                  ),
                ),
                const Text(
                  'Mr. Derek',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'da000725@gmail.com',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '+923000000000',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Islamabad I-10 ',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Month Earning',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rs.40000',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                  child: GestureDetector(
                    onTap: () {
                      // showCustomBottomSh,
                      // eet(context);
                      print("menu");
                    },
                    child: SvgPicture.asset(icMenu),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
