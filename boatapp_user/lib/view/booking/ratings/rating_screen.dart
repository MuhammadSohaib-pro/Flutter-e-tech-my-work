import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/custom_widgets/back_arrow.dart';
import 'package:boat_app/custom_widgets/container_for_rating.dart';
import 'package:boat_app/custom_widgets/loader_view.dart';
import 'package:boat_app/provider/loader_view_provider.dart';
import 'package:boat_app/provider/rating_tiles_provider.dart';
import 'package:boat_app/utils/global_function.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/utils/utils.dart';
import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../languages/LocaleString.dart';
import '../../../provider/loading_provider/loading_provider.dart';
import '../../../utils/colors.dart';

class RatingScreen extends StatefulWidget {
  final String boatId, ownerId, orderId;
  const RatingScreen(
      {Key? key,
      required this.boatId,
      required this.ownerId,
      required this.orderId})
      : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  bool everything = false;
  bool boat = false;
  bool service = false;
  bool communication = false;
  bool loveIt = false;
  double? ratings;
  String reviewId = DateTime.now().millisecondsSinceEpoch.toString();
  final _formKey = GlobalKey<FormState>();
  String? _validateReview(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocale
          .pleaseEnterAReview; //AppLocale.pleaseGiveOverviewAboutYourBoat.getString(context);
    }
    return null; // Return null if input is valid
  }

  TextEditingController reviewController = TextEditingController();

  void _onSubmitForm() {

    final ratingTileProvider =
        Provider.of<RatingTileProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      final loadingprovider =
      Provider.of<LoaderViewProvider>(context, listen: false);
      loadingprovider.changeShowLoaderValue(true);
     if(ratings != null){
       FirebaseFirestore.instance.collection('Reviews').doc(reviewId).set({
         'reviewId': reviewId,
         'userId': FirebaseAuth.instance.currentUser!.uid,
         'boatId': widget.boatId,
         'orderId': widget.orderId,
         'ownerId': widget.ownerId,
         'everything': ratingTileProvider.everything,
         'boat': ratingTileProvider.boat,
         'service': ratingTileProvider.service,
         'communication': ratingTileProvider.communtication,
         'LoveIt': ratingTileProvider.loveIt,
         'rating': ratings,
         'review': reviewController.text,
       }).then((value) {
         loadingprovider.changeShowLoaderValue(false);
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => const BottomBarScreen()));
       });
     }else{
       loadingprovider.changeShowLoaderValue(false);

       Utils.toastMessage('please rate the boat');
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratingTileProvider =
        Provider.of<RatingTileProvider>(context, listen: false);
    final loadingProvider =
    Provider.of<LoadingProvider>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
            body: SingleChildScrollView(
                child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Back_Arrow(
                  image: close,
                  ontap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const BottomBarScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
                SizedBox(
                  width: width(context),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0, bottom: 10),
                          child: Text(
                            AppLocale.howDoYouLikeBooking.getString(context),
                            style: text18600,
                          ),
                        ),
                        Text(
                          AppLocale.boatComfortAndOwnerBehavior.getString(context),
                          style: text11400op,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<RatingTileProvider>(
                          builder: (context, value, child) {
                            return Wrap(alignment: WrapAlignment.center, children: [
                              ratingTileProvider.everything == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider
                                              .changeEverything(false);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size120,
                                          height: MySize2.size30,
                                          color: appColorBlue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.everything
                                                    .getString(context),
                                                style: text14500white,
                                              ),
                                               SizedBox(
                                                width: MySize2.size5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      color: appColorBlue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child:  Icon(
                                                    Icons.done,
                                                    size: MySize2.size15,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeEverything(true);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size120,
                                          height: MySize2.size30,
                                          color: const Color(0xff494AFF)
                                              .withOpacity(0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.everything
                                                    .getString(context),
                                                style: text14500,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: appColorBlue)),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MySize2.size15,
                                                    color: appColorBlue,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ratingTileProvider.boat == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeBoat(false);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size80,
                                          height: MySize2.size30,
                                          color: appColorBlue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.boat.getString(context),
                                                style: text14500white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      color: appColorBlue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child:  Icon(
                                                    Icons.done,
                                                    size: MySize2.size15,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeBoat(true);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size80,
                                          height: MySize2.size30,
                                          color: const Color(0xff494AFF)
                                              .withOpacity(0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.boat.getString(context),
                                                style: text14500,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: appColorBlue)),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MySize2.size15,
                                                    color: appColorBlue,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ratingTileProvider.service == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeService(false);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size100,
                                          height: MySize2.size30,
                                          color: appColorBlue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.service
                                                    .getString(context),
                                                style: text14500white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      color: appColorBlue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child:  Icon(
                                                    Icons.done,
                                                    size: MySize2.size15,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeService(true);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size100,
                                          height: MySize2.size30,
                                          color: const Color(0xff494AFF)
                                              .withOpacity(0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.service
                                                    .getString(context),
                                                style: text14500,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: appColorBlue)),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MySize2.size15,
                                                    color: appColorBlue,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ratingTileProvider.communtication == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider
                                              .changeCommunication(false);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size180,
                                          height: MySize2.size30,
                                          color: appColorBlue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.communication
                                                    .getString(context),
                                                style: text14500white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      color: appColorBlue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child:  Icon(
                                                    Icons.done,
                                                    size: MySize2.size15,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider
                                              .changeCommunication(true);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size180,
                                          height: MySize2.size30,
                                          color: const Color(0xff494AFF)
                                              .withOpacity(0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.communication
                                                    .getString(context),
                                                style: text14500,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: appColorBlue)),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MySize2.size15,
                                                    color: appColorBlue,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              ratingTileProvider.loveIt == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeLoveIt(false);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size90,
                                          height: MySize2.size30,
                                          color: appColorBlue,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.loveIt.getString(context),
                                                style: text14500white,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      color: appColorBlue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child:  Icon(
                                                    Icons.done,
                                                    size: MySize2.size15,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: InkWell(
                                        onTap: () {
                                          ratingTileProvider.changeLoveIt(true);
                                        },
                                        child: ContainerForRating(
                                          width: MySize2.size90,
                                          height: MySize2.size30,
                                          color: const Color(0xff494AFF)
                                              .withOpacity(0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocale.loveIt.getString(context),
                                                style: text14500,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                  height: MySize2.size20,
                                                  width: MySize2.size20,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: appColorBlue)),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MySize2.size15,
                                                    color: appColorBlue,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Text(
                          AppLocale.rating.getString(context),
                          style: text18600,
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        Text(
                          AppLocale.giveUsRatingStar.getString(context),
                          style: text11400op,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: height(context) * 0.02,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xff006EFE).withOpacity(0.1),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(5.0),
                        //           child: Icon(Icons.star,size: 30, color: Color(0xffFFD913),),
                        //         ),
                        //       ),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xff006EFE).withOpacity(0.1),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(5.0),
                        //           child: Icon(Icons.star,size: 30, color: Color(0xffFFD913),),
                        //         ),
                        //       ),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xff006EFE).withOpacity(0.1),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(5.0),
                        //           child: Icon(Icons.star,size: 30, color: Color(0xffFFD913),),
                        //         ),
                        //       ),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xff006EFE).withOpacity(0.1),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(5.0),
                        //           child: Icon(Icons.star,size: 30, color: Color(0xffFFD913),),
                        //         ),
                        //       ),
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: const Color(0xff006EFE).withOpacity(0.1),
                        //           shape: BoxShape.circle,
                        //         ),
                        //         child: const Padding(
                        //           padding: EdgeInsets.all(5.0),
                        //           child: Icon(Icons.star,size: 30, color: Color(0xffFFD913),),
                        //         ),
                        //       ),
                        //
                        //
                        //     ],
                        //   ),
                        // ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratings = rating;
                            });
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Form(
                          key: _formKey,
                          child: SizedBox(
                            height: height(context) * 0.2,
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                validator: _validateReview,
                                controller: reviewController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  hintText:
                                      AppLocale.writeFewWords.getString(context),
                                  hintStyle: text14500,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(16)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.03,
                        ),
                        Consumer<LoadingProvider>(
                          builder: (context, value, child){
                            return  AppButton(
                              loading: loadingProvider.loading,
                                onPressed: () async {
                                  bool? isConnected = await Utils.checkInternetConnection();
                                  if (isConnected == true) {
                                    _onSubmitForm();
                                  }
                                  else{
                                  showNoInternetDialog(context);
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const TrackingScreen()));
                                },
                                text: AppLocale.submitReview.getString(context));
                          },
                        )
                      ]),
                ),
              ],
            ),
          ),
        ))),
        const LoaderView()
      ],
    );
  }
}
