import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

// ignore: must_be_immutable
class ManageEmployeeList extends StatelessWidget {
  String? title;
  int? uidsCount;
  String? image;

  ManageEmployeeList({super.key, this.title, this.uidsCount, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(MySize.size10),
          boxShadow: [
            BoxShadow(
                color: blackColor.withOpacity(0.10),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(2, 2))
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size12, vertical: MySize.size16),
        child: Row(children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MySize.size10),
                  color: const Color(0xff7DC247).withOpacity(0.12)),
              child: CachedNetworkImage(
                imageUrl: image!,
                height: MySize.size25,
                width: MySize.size25,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: MySize.size12, vertical: MySize.size12),
              //   child: Image.network(
              //     image!,
              //     height: MySize.size25,
              //     width: MySize.size25,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              ),
          SizedBox(
            width: MySize.size20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 'Designer Team',
                title!,
                style: poppinBold.copyWith(fontSize: MySize.size14),
              ),
              SizedBox(
                height: MySize.size6,
              ),
              Text(
                '${uidsCount.toString()} Employes',
                style: poppineRegular.copyWith(
                    fontSize: MySize.size10, color: primaryColor),
              ),
            ],
          ),
          const Spacer(),
          // SizedBox(
          //   width: MySize.screenWidth * 0.3,
          //   height: MySize.size40,
          //   child: Stack(alignment: Alignment.centerLeft, children: [
          //     imageWidget(image: AppIcons.employe1),
          //     Positioned(
          //         left: MySize.size20,
          //         child: imageWidget(image: AppIcons.employe2)),
          //     Positioned(
          //         left: MySize.size40,
          //         child: imageWidget(image: AppIcons.employe3)),
          //     Positioned(
          //         left: MySize.size60,
          //         child: imageWidget(image: AppIcons.employe4)),
          //     Positioned(
          //       left: MySize.size80,
          //       child: Container(
          //         height: MySize.size30,
          //         width: MySize.size30,
          //         decoration: BoxDecoration(
          //             color: whiteColor,
          //             shape: BoxShape.circle,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 8,
          //                   spreadRadius: 0,
          //                   offset: const Offset(2, 2),
          //                   color: blackColor.withOpacity(0.15))
          //             ]),
          //         child: Center(
          //           child: Text(
          //             '16+',
          //             style: poppinMedium.copyWith(
          //                 fontSize: MySize.size10, color: primaryColor),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ]),
          // )
        ]),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          image,
          height: MySize.size30,
          width: MySize.size30,
        ));
  }
}
