import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';
import 'package:wheremyelabd/boxes/boxes.dart';
import 'package:wheremyelabd/models/storage_model.dart';

class AppbarCustom extends StatefulWidget {
  final String title;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;

  AppbarCustom({
    required this.title,
    this.trailingIcon,
    this.onTrailingIconPressed,
  });

  @override
  _AppbarCustomState createState() => _AppbarCustomState();
}

class _AppbarCustomState extends State<AppbarCustom> {
  String? picture;

  @override
  void initState() {
    super.initState();
    fetchEditProfileData();
  }

  void fetchEditProfileData() {
    final box = Boxes.getEditprofile();
    const key = 'editProfile';
    editprofile? existingData = box.get(key);

    if (existingData != null) {
      setState(() {
        picture = existingData.imagePath; // Use the correct property name
      });
      print('after initializing from existing editprofile data');
      print('this picture path');
      print(picture);
      print(existingData.imagePath);
    } else {
      // Handle the case when existingData is null
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    print('image path app bar');
    print(picture);

    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: screenSize.width * 0.060,
                backgroundImage: picture != null && File(picture!).existsSync()
                    ? FileImage(File(picture.toString()))
                    : AssetImage('assets/noimage.jpg') as ImageProvider,
              ),
              SizedBox(
                width: screenSize.width * 0.03,
              ),
              Column(
                children: [
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 7,
                    ),
                  ),
                  Text(
                    widget.title, // Use widget.title to access the title property
                    textAlign: TextAlign.center,
                    style: MyTextStyles.appbartextstyle,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: widget.title.length > 11
                ? screenSize.width * 0.33
                : screenSize.width * 0.39,
          ),
          if (widget.trailingIcon != null)
            Expanded(
              child: GestureDetector(
                onTap: widget.onTrailingIconPressed,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[350],
                  ),
                  child: Icon(
                    widget.trailingIcon,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
