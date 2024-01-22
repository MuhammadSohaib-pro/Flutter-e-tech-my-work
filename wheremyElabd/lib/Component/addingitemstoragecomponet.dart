import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class ItemStorageCom extends StatelessWidget {
  final String title;
  final Function()? onBackPress;
  final Function()? onQuestionMarkPress;

  const ItemStorageCom({
    Key? key,
    required this.title,
    this.onBackPress,
    this.onQuestionMarkPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackPress ?? () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[350],
                ),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: MyTextStyles.maintextstyle(18.0),
            ),
            GestureDetector(
              onTap: onQuestionMarkPress,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[350],
                ),
                child: const Icon(Icons.question_mark),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a gallery',
              textAlign: TextAlign.center,
              style: MyTextStyles.longtextstyle(16.0),
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),

        Text(
          'Please enter details to add storage item',
          style:MyTextStyles.maintextstyle(18.0),
        ),
      ],
    );
  }
}
