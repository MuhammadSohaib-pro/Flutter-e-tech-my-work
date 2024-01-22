import 'package:activityapp/global/colors.dart';
import 'package:activityapp/global/layout/mySize.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/settings/privacyAndTerms.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.ticketcolor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Privacy Policy & Terms',
          style: MyTextStyles.latoTextstyle(15, FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                  fontSize: MySize.size20, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const PrivacyPolicy();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            // No animation, just return the child
                            return child;
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: MySize.size153,
                      height: MySize.size28,
                      // padding:  EdgeInsets.symmetric(horizontal: MySize.size42, vertical: 7),
                      // clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MySize.size12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            // height: 0,
                            // letterSpacing: -0.30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MySize.size153,
                    height: MySize.size28,
                    // padding:  EdgeInsets.symmetric(horizontal: MySize.size42, vertical: 7),
                    // clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2538E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Terms & Conditions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MySize.size12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          // height: 0,
                          // letterSpacing: -0.30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Text(
                'Norem ipsum dolor sit amet, consectetur adipiscing elit.'
                ' Etiam eu turpis molestie, dictum est a, mattis tellus. '
                'Sed dignissim, metus nec fringilla accumsan, risus sem '
                'sollicitudin lacus, ut interdum tellus elit sed risus'
                '. Maecenas eget condimentum velit, sit amet feugiat lectus.'
                ' Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
                ' per inceptos himenaeos. Praesent auctor purus luctus enim egestas, '
                'ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac '
                'rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi'
                ' convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.'
                'Curabitur tempor quis eros tempus lacinia.'
                ' Nam bibendum pellentesque quam a convallis.'
                ' Sed ut vulputate nisi. Integer in felis sed '
                'leo vestibulum venenatis. Suspendisse quis arcu sem.'
                ' Aenean feugiat ex eu vestibulum vestibulum. Morbi a '
                'eleifend magna. Nam metus lacus, porttitor eu mauris a,'
                ' blandit ultrices nibh. Mauris sit amet magna non ligula '
                'vestibulum eleifend. Nulla varius volutpat turpis sed lacinia. '
                'Nam eget mi in purus lobortis eleifend. Sed nec ante dictum sem '
                'condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis nisi,'
                ' ac posuere leo.')
          ],
        ),
      ),
    );
  }
}
