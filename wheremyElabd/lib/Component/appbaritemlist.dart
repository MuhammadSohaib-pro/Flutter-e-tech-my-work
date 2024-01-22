import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class ListCom extends StatelessWidget {
  final String title;
  final Function()? onBackPress;
  final Function()? onQuestionMarkPress;

  const ListCom({
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

      ],
    );
  }
}
