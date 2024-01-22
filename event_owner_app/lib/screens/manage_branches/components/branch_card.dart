import 'package:event_owner_app/helper/exports.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.image,
    required this.backgroundColor,
    required this.address,
    required this.branchtype,
    required this.btncolor,
    required this.name,
    this.textColor,
    this.iconColor,
    this.nameColor,
    this.addressColor,
  });
  final String image;
  final String name;
  final Color backgroundColor;
  final String address;
  final String branchtype;
  final Color btncolor;
  final Color? textColor;
  final Color? iconColor;
  final Color? nameColor;
  final Color? addressColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Container(
        width: double.infinity,
        height: MySize.size180,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(4, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 20,
              offset: Offset(-4, -4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            // Container(
            //   width: MySize.safeWidth,
            //   height: MySize.size130,
            //   decoration: ShapeDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(image),
            //       fit: BoxFit.fill,
            //     ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(MySize.size10),
            // ),
            //   ),
            // ),
            CachedNetworkImage(
              height: MySize.size130,
              width: MySize.safeWidth,
              imageUrl: image,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
            Expanded(
              child: Padding(
                padding: Spacing.horizontal(MySize.size12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: nameColor ?? ThemeColors.black1,
                              fontSize: MySize.size14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: iconColor ?? ThemeColors.mainColor,
                                size: MySize.size14,
                              ),
                              SizedBox(width: MySize.size6),
                              Text(
                                address,
                                style: TextStyle(
                                  color: addressColor ?? ThemeColors.black1,
                                  fontSize: MySize.size10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MySize.size50,
                            height: MySize.size20,
                            decoration: ShapeDecoration(
                              color: btncolor,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(MySize.size20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              branchtype,
                              style: TextStyle(
                                color: textColor ?? ThemeColors.bgColor,
                                fontSize: MySize.size8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
