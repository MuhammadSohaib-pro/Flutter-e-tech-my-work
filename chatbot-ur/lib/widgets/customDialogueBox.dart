// ignore_for_file: must_be_immutable

import 'package:chatbot/core/app_export.dart';
import 'package:chatbot/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class CustomDialogBox extends StatelessWidget {
  bool isYoutube;
  String query;
  CustomDialogBox({
    super.key,
    required this.query,
    required this.isYoutube,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.65,
        child: Column(
          children: [
            Text(
              'Permission Required',
              style: CustomTextStyles.titleMediumInter,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                'You are being redirected to ${isYoutube ? 'www.youtube.com' : 'www.google.com'}',
                style: CustomTextStyles.bodyMediumInterBluegray500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomElevatedButton(
                height: 50.v,
                text: 'Yes, Continue',
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle: CustomTextStyles.titleMediumInterOnPrimary,
                onPressed: () async {
                  query = query
                      .toLowerCase()
                      .replaceAll('youtube', '')
                      .replaceAll('google', '');
                  List<String> queries = query.split(' ').toList();
                  try {
                    await _launchUrl(Uri.parse(isYoutube
                        ? 'https://www.youtube.com/results?search_query=${queries.join('+')}'
                        : 'https://www.google.com/search?q=${queries.join('+')}'));
                  } catch (e) {}
                }),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
                height: 50.v,
                text: "No, Back to app".tr,
                buttonStyle: CustomButtonStyles.secondary,
                buttonTextStyle: const TextStyle(color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
