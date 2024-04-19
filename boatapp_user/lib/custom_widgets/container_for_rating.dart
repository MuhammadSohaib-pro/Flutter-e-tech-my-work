import 'package:flutter/cupertino.dart';

class ContainerForRating extends StatelessWidget {
  double height, width;
  Color color;
  Widget child;
   ContainerForRating({Key? key, required this.width, required this.height, required this.color, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
