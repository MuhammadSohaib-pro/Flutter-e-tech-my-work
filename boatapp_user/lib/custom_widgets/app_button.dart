import 'package:boat_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppButton extends StatelessWidget {
    AppButton({super.key,
      this.loading = false,
      this.height=55,
    this.width=                     double.infinity,

    this.background= primaryColor,
     required this.onPressed,
     required this.text,
      this.textColor=const Color.fromRGBO(255, 255, 255, 1),
      this.textSize=14,

});

    bool loading;
  double height,width,textSize;
  Color background,textColor;
  String text;
  void Function() onPressed ;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child:ElevatedButton(onPressed: onPressed,style: ElevatedButton.styleFrom(
        backgroundColor:background ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),

        )

      ),
      child:Center(child: loading? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,)
          :
      Text(text,
        style: TextStyle(color: textColor,fontSize:textSize ,fontWeight: FontWeight.w500),),
      )      ) ,
    );
  }
}
