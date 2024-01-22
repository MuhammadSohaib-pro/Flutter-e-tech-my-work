import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class ManagerTile extends StatelessWidget {
  const ManagerTile({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.status,
    required this.onTap,
  });
  final String image;
  final String name;
  final String location;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: Spacing.horizontal(MySize.size32),
        child: Container(
          width: double.infinity,
          height: MySize.size75,
          decoration: ShapeDecoration(
            color: Colors.white,
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
          child: Row(
            children: [
              Row(
                children: [
                  SizedBox(width: MySize.size12),
                  // Container(
                  //   width: MySize.size50,
                  //   height: MySize.size50,
                  //   decoration: ShapeDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(image),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     shape: const CircleBorder(),
                  //   ),
                  // ),
                  CachedNetworkImage(
                    height: MySize.size50,
                    width: MySize.size50,
                    imageUrl: image,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
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
                  SizedBox(width: MySize.size10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: MySize.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: ThemeColors.mainColor,
                            size: MySize.size16,
                          ),
                          SizedBox(width: MySize.size2),
                          Text(
                            location,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          color: status == "Active"
                              ? ThemeColors.mainColor
                              : ThemeColors.grey1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
                splashRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
