import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacrapapp/app/util/app_constant.dart';
import 'package:sacrapapp/app/widget/logo.dart';


import 'fade_slide_transition.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Logo(
            color: kBlue,
            size: 48.0,
          ),
          const SizedBox(height: kSpaceM),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,

            child: Text(
              'welcome'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: kBlack, fontWeight: kFontWeightBold, fontFamily: kFontFamily),
            ),
          ),
          // const SizedBox(height: kSpaceS),
          // FadeSlideTransition(
          //   animation: animation,
          //   additionalOffset: 16.0,
          //   child: Text(
          //    'نقوم بتخليصك من اغراضك',
          //     style: Theme.of(context)
          //         .textTheme
          //         .subtitle1!
          //         .copyWith(color: kBlack.withOpacity(0.5), fontWeight: kFontWeightNormal, fontFamily: kFontFamily),
          //   ),
          // ),
        ],
      ),
    );
  }
}
