import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class StoreItemCard extends StatelessWidget {
  const StoreItemCard({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width: MySize.size160,
        height: MySize.size210,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.029999999329447746),
          border: const Border(
            bottom: BorderSide(
              width: 4,
              color: ThemeColors.green,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MySize.size122,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgValorant),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: MySize.size10),
            Padding(
              padding: Spacing.horizontal(MySize.size4),
              child: Text(
                'STAR WARS™ | TEAM LIQUID DARK SIDE KNIT SWEATER',
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size5),
            Padding(
              padding: Spacing.horizontal(MySize.size4),
              child: Text(
                'Tops',
                style: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MySize.size5),
            Padding(
              padding: Spacing.horizontal(MySize.size4),
              child: Text(
                '\$70',
                style: TextStyle(
                  color: ThemeColors.green,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
