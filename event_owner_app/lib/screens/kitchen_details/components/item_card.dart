import 'package:event_owner_app/helper/exports.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
  });

  final String itemName;
  final String itemImage;
  final double itemPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size100,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 20,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: Spacing.horizontal(MySize.size15),
          child: Row(
            children: [
              CachedNetworkImage(
                height: MySize.size80,
                width: MySize.size80,
                imageUrl: itemImage,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0x358B0000),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: ThemeColors.mainColor,
                      size: 40,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  );
                },
              ),
              SizedBox(width: MySize.size8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemName,
                      style: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'SAR $itemPrice',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
