import 'package:car2gouser/controller/menu_screen_controller/about_us_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:stroke_text/stroke_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsScreenController>(
        init: AboutUsScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.aboutUsTransKey.toCurrentLanguage,
                  hasBackButton: true),

              /* <-------- Body Content --------> */

              body: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ScaffoldBodyWidget(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  /* <---- Image Widget ----> */
                                  Expanded(
                                    child: SizedBox(
                                      height: 179,
                                      child: CachedNetworkImageWidget(
                                        imageURL:
                                            'https://github.com/surjo976/Doremon/assets/82593116/27d9872c-154e-4c38-90b2-e1e5f43c02a4',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              AppGaps.hGap24,
                              /* <---- Details about this app----> */
                              Text(
                                AppLanguageTranslation
                                    .ourHistoryTransKey.toCurrentLanguage,
                                style: AppTextStyles.titleSemiboldTextStyle,
                              ),
                              AppGaps.hGap12,
                              /* <---- Show data using API ----> */
                              Text(
                                controller
                                    .aboutUsTextItem.content.ourHistory.heading,
                                style: AppTextStyles.semiSmallXBoldTextStyle,
                              ),
                              AppGaps.hGap10,
                              Text(
                                controller.aboutUsTextItem.content.ourHistory
                                    .description1,
                                textAlign: TextAlign.justify,
                              ),
                              AppGaps.hGap10,
                              Text(
                                controller.aboutUsTextItem.content.ourHistory
                                    .description2,
                                textAlign: TextAlign.justify,
                              ),
                              AppGaps.hGap24,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.fromBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "6K+",
                                              textStyle: TextStyle(
                                                fontSize: 60,
                                              ),
                                              strokeColor: Colors.black,
                                              strokeWidth: 2,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .appDownloadTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    AppGaps.wGap15,
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.fromBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "4K+",
                                              textStyle: TextStyle(
                                                  fontSize: 60,
                                                  color: Colors.black),
                                              strokeColor: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              AppLanguageTranslation
                                                  .activeRidesTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AppGaps.hGap16,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.fromBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "30K+",
                                              textStyle: TextStyle(
                                                  fontSize: 60,
                                                  color: Colors.black),
                                              strokeColor: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              'Tripe/Order Saved',
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    AppGaps.wGap15,
                                    Container(
                                      height: 175,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.fromBorderColor),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const StrokeText(
                                              text: "3K+",
                                              textStyle: TextStyle(
                                                fontSize: 60,
                                              ),
                                              strokeColor: Colors.black,
                                              strokeWidth: 2,
                                            ),
                                            AppGaps.hGap15,
                                            Text(
                                              'Active User',
                                              style: AppTextStyles
                                                  .bodyBoldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AppGaps.hGap30,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
