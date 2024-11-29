import 'package:car2gouser/controller/introscreen_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/screen_widget/intro_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<IntroScreenController>(
        init: IntroScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              appBar:
                  CoreWidgets.appBarWidget(screenContext: context, actions: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 50,
                  width: 90,
                  decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )),

                  /* <---- Skip button ----> */
                  child: RawButtonWidget(
                    borderRadiusValue: 30,
                    child: Center(
                        child: Text(
                      AppLanguageTranslation.skipTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    )),
                    onTap: () {
                      Get.toNamed(AppPageNames.loginScreen);
                    },
                  ),
                )
              ]),
              /* <-------- Content --------> */
              body: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      /* <---- Intro screens ----> */
                      child: PageView.builder(
                        controller: controller.pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          controller.fakeIntroContent =
                              FakeData.introContents[index];
                          controller.currentIndex = index;
                          controller.update();
                        },
                        itemCount: FakeData.introContents.length,
                        itemBuilder: (context, index) {
                          /*<------- Single intro screen data ------>*/

                          controller.fakeIntroContent =
                              FakeData.introContents[index];
                          /* <---- Single Intro screen widget ----> */
                          return IntroContentWidget(
                              screenSize: screenSize,
                              localImageLocation: controller
                                  .fakeIntroContent.localSVGImageLocation,
                              slogan: controller.fakeIntroContent.slogan,
                              subtitle: controller.fakeIntroContent.content);
                        },
                      ),
                    ),
                    /* <---- For extra 10px gap in height ----> */
                    AppGaps.hGap10,
                    /* <---- Current page circular percent indicator widget ----> */
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 6.0,
                      percent: ((controller.currentIndex + 1) /
                          FakeData.introContents.length),
                      center: RawButtonWidget(
                        borderRadiusValue: 50,
                        onTap: () async {
                          controller.gotoNextIntroSection(context);
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor),
                          child: Center(
                              child: Text(
                            !controller
                                    .isLastPage/*<------- Show the arrow if it is not the last page.------>*/
                                ? '➜'
                                : AppLanguageTranslation
                                    .goTransKey.toCurrentLanguage,
                            /*<------- // Show the text 'Go' in the button if it will be the last page.------>*/
                            style: const TextStyle(
                                color: AppColors.primaryButtonColor),
                          )),
                        ),
                      ),
                      progressColor: AppColors.primaryColor,
                    ),
                    /* <---- For extra 80px gap in height ----> */
                    AppGaps.hGap80,
                  ]),
            ));
  }
}
