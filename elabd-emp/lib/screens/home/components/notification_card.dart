// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.personImage,
    required this.personName,
    required this.notificationDesc,
    required this.isRead,
  }) : super(key: key);

  final String personImage;
  final String personName;
  final String notificationDesc;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: isRead ? white : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(2, 2),
                  color: black.withOpacity(0.10))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: personImage,
                        height: 48,
                        width: 48,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                      //  Image.network(
                      //   // AppIcons.projectp1,
                      //   personImage,
                      //   height: MySize.size48,
                      //   width: MySize.size48,
                      // ),
                      ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          personName,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: isRead ? black : white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notificationDesc,
                          // 'App Development Project almost done App Development Project almost don',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: isRead
                                  ? primaryColor
                                  : const Color(0xff8FAB94)),
                        ),
                      ],
                    ),
                  ),
                  Icon(isRead ? Icons.mark_email_read : Icons.mark_email_unread),
                ],
              ),
            ],
          ),
        ));
  }
}
