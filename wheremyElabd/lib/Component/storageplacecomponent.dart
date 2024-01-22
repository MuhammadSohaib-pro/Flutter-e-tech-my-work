import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class StoragePlaceComponent extends StatelessWidget {
  final String itemCount;
  final String storageName;
  final VoidCallback? onTap;


  const StoragePlaceComponent({
    required this.itemCount,
    required this.storageName,
    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Opacity(
          opacity: 0.75,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: screenSize.width * 0.350,
              height: screenSize.height * 0.150,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top:38 ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        itemCount,
                        textAlign: TextAlign.center,
                        style: MyTextStyles.storagetextstyle(36.0),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Item Count',
                        textAlign: TextAlign.center,
                        style:  MyTextStyles.storagetextstylesubtitle(10.0),
                      ),
                    ],
                  ),
              ),

            ),
          ),

        ),

        SizedBox(
          height: screenSize.height * 0.025,

        ),
        Text(
          storageName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 0.07,
            letterSpacing: -0.42,
          ),
        ),
      ],

    );

  }
}
