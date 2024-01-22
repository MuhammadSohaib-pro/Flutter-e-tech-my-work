import 'package:event_app/helper/mySize.dart';
import 'package:event_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CstmKitchenAndServicesCard extends StatelessWidget {
  const CstmKitchenAndServicesCard({
    super.key,
    required this.onPressed,
    required this.image,
    required this.name,
  });
  final VoidCallback onPressed;
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: MySize.size190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size20),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: Spacing.horizontal(MySize.size20),
                          child: Text(
                            name,
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: Spacing.horizontal(MySize.size20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: ThemeColors.mainColor,
                                  ),
                                  SizedBox(width: MySize.size3),
                                  Text(
                                    'Dubai International City (23 km)',
                                    style: TextStyle(
                                      color: ThemeColors.bgColor,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: ThemeColors.yellow,
                                  ),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      color: ThemeColors.bgColor,
                                      fontSize: MySize.size10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: MySize.size5),
                      ],
                    ),
                  ),
                  Container(
                    height: MySize.size60,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ThemeColors.mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: Spacing.horizontal(MySize.size20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ' • Excellence in delivering fresh and healthy foods with high quality and experienced health standards.',
                              maxLines: 3,
                              style: TextStyle(
                                color: ThemeColors.bgColor,
                                fontSize: MySize.size10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: MySize.size6),
                          Container(
                            height: MySize.size30,
                            width: MySize.size30,
                            alignment: Alignment.center,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Color(0xFF800000),
                            ),
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: ThemeColors.bgColor,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
