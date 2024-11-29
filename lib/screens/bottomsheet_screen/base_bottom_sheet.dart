import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  final Widget child;
  final bool showCloseButton;
  final void Function()? onCloseButtonTap;
  const BaseBottomSheet(
      {required this.child,
      super.key,
      this.showCloseButton = false,
      this.onCloseButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: SingleChildScrollView(
          child: child,
        ));
  }
}
