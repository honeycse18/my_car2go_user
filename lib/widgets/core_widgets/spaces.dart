import 'package:car2gouser/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class VerticalGap extends StatelessWidget {
  const VerticalGap(this.height, {super.key});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalGap extends StatelessWidget {
  const HorizontalGap(this.width, {super.key});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class ScreenTopGap extends StatelessWidget {
  const ScreenTopGap({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? AppUIConstants.screenTopGapSize);
  }
}

class ScreenBottomGap extends StatelessWidget {
  const ScreenBottomGap({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? AppUIConstants.screenBottomGapSize);
  }
}

class SidePaddedWidget extends StatelessWidget {
  const SidePaddedWidget({
    required this.child,
    super.key,
    required this.padding,
  });
  final double padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: child,
    );
  }
}
