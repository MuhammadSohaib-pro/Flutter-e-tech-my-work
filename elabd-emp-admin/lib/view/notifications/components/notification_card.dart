// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

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
            color: isRead ? whiteColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(MySize.size10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(2, 2),
                  color: blackColor.withOpacity(0.10))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MySize.size10, vertical: MySize.size18),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(MySize.size10),
                      child: CachedNetworkImage(
                        imageUrl: personImage,
                        height: MySize.size48,
                        width: MySize.size48,
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
                  SizedBox(
                    width: MySize.size14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          personName,
                          style: poppinSemiBold.copyWith(
                              fontSize: MySize.size14, color: blackColor),
                        ),
                        SizedBox(
                          height: MySize.size6,
                        ),
                        Text(
                          notificationDesc,
                          // 'App Development Project almost done App Development Project almost don',
                          style: poppinMedium.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: MySize.size14,
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
