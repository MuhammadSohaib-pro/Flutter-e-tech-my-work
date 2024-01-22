import 'package:flutter/material.dart';

Widget backgroundWidget({Widget? child}) {
  return Container(
    width: double.infinity,
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage('assets/images/bg.png'),
        alignment: Alignment.bottomRight
      ),
    ),
    child: child,
  );
}
