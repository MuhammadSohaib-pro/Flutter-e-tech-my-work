import 'package:event_app/helper/imports.dart';

class PrivacyPolicyAndTermsView extends StatefulWidget {
  const PrivacyPolicyAndTermsView({super.key});

  @override
  State<PrivacyPolicyAndTermsView> createState() =>
      _PrivacyPolicyAndTermsViewState();
}

bool flag = true;

class _PrivacyPolicyAndTermsViewState extends State<PrivacyPolicyAndTermsView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.privacyTerms.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MySize.size153,
                      height: MySize.size40,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.privacyPolicy.toString(),
                        backgroundColor:
                            flag ? ThemeColors.mainColor : ThemeColors.grey5,
                        textColor:
                            flag ? ThemeColors.bgColor : ThemeColors.black1,
                        onPressed: !flag
                            ? () {
                                setState(() {
                                  flag = !flag;
                                });
                              }
                            : () {},
                      ),
                    ),
                    SizedBox(
                      width: MySize.size153,
                      height: MySize.size40,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.termsConditions.toString(),
                        backgroundColor:
                            !flag ? ThemeColors.mainColor : ThemeColors.grey5,
                        textColor:
                            !flag ? ThemeColors.bgColor : ThemeColors.black1,
                        onPressed: flag
                            ? () {
                                setState(() {
                                  flag = !flag;
                                });
                              }
                            : () {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: flag
                    ? const Text(
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
                    : const Text(
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
                        '\n\nCurabitur tempor quis eros tempus lacinia.'
                        ' Nam bibendum pellentesque quam a convallis.'
                        ' Sed ut vulputate nisi. Integer in felis sed '
                        'leo vestibulum venenatis. Suspendisse quis arcu sem.'
                        ' Aenean feugiat ex eu vestibulum vestibulum. Morbi a '
                        'eleifend magna. Nam metus lacus, porttitor eu mauris a,'
                        ' blandit ultrices nibh. Mauris sit amet magna non ligula '
                        'vestibulum eleifend. Nulla varius volutpat turpis sed lacinia. '
                        'Nam eget mi in purus lobortis eleifend. Sed nec ante dictum sem '
                        'condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis nisi,'
                        ' ac posuere leo.'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
