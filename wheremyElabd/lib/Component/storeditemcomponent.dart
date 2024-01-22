import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class StoredItemComponent extends StatelessWidget {
  final String avatarPic;
  final String title;
  final String subtitle;
  final String time;
  final Function() onEdit;
  final Function() onDelete;

  const StoredItemComponent({
    required this.avatarPic,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width:MediaQuery.of(context).size.width * 0.89,
      // height:  MediaQuery.of(context).size.height * 0.173,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFECEDEF)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: avatarPic != null && File(avatarPic).existsSync()
                        ? FileImage(File(avatarPic))
                        : AssetImage('assets/noimage.jpg') as ImageProvider,
                  ),
                  SizedBox(width: 10),

                  Padding(
                    padding: EdgeInsets.only(top:11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: MyTextStyles.storagetextstyle(18.0),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 10,
                              color: Colors.blue,
                            ),
                            Text(
                              subtitle,
                              style: MyTextStyles.storagetextstylesubtitle(11.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

                  Column(
                    children:[ Row(

                      children: [
                        GestureDetector(
                          onTap: onEdit,
                          child: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: onDelete,
                          child: Icon(
                            Icons.delete,
                            size: 15,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                      Text('',style: TextStyle(
                        fontSize: 28,
                      ),),

      ],
                  ),


            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                textAlign: TextAlign.right,
                style:  MyTextStyles.storagetextstylesubtitle(11.0),
              ),
            ],
          ),

          // SizedBox(height: 10,),
        ],
      ),
    );
  }
}
