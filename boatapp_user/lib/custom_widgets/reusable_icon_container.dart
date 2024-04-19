import 'package:flutter/cupertino.dart';

class ReusableIconContainer extends StatelessWidget {
  final String image;
  final Color color;
  final double height, width;
   const ReusableIconContainer({Key? key, required this.image, required this.color, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
            borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          height:20,
          width: 20,
          image: AssetImage(image),),
      ),
    );
  }
}
