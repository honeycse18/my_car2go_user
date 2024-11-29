import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/*<-------Per intro page content widget------>*/
class IntroContentWidget extends StatelessWidget {
  final Size screenSize;
  final String localImageLocation;
  final String slogan;
  final String subtitle;
  const IntroContentWidget({
    Key? key,
    required this.localImageLocation,
    required this.slogan,
    required this.subtitle,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppGaps.hGap60,
        Expanded(child: Image.asset(localImageLocation)),
        AppGaps.hGap40,
        HighlightAndDetailTextWidget(slogan: slogan, subtitle: subtitle),
        AppGaps.hGap40,
      ],
    );
  }
}
