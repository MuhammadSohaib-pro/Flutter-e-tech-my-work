import 'package:flutter/material.dart';

class Divider_con extends StatelessWidget {
  const Divider_con({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 15),
      width: double.infinity,
      height: 0.5,
      color: const Color(0xffC9C8C8
      ),
    );
  }
}
