import 'package:event_app/helper/imports.dart';

class CstomRestaurantListItem extends StatelessWidget {
  const CstomRestaurantListItem({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: MySize.size100,
                  height: MySize.size100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(imgRoyalChairTable),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: MySize.size7),
                Container(
                  width: MySize.size70,
                  height: MySize.size84,
                  alignment: Alignment.center,
                  child: Text(
                    'Full Lamb Mandi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '1500.00 SAR',
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget favoriteContainer() {
  return SizedBox(
    width: MySize.size90,
    height: MySize.size90,
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 0, width: double.infinity),
            SizedBox(height: MySize.size22),
            Expanded(
              child: Container(
                width: MySize.size60,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE3C5C5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              width: double.infinity,
              height: MySize.size72,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(imgFavoriteFood),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
