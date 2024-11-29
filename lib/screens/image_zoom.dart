import 'package:car2gouser/controller/image_zoom_screen_controller.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageZoomScreen extends StatelessWidget {
  const ImageZoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = Helper.getScreenSize(context);
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ImageZoomScreenController>(
        init: ImageZoomScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: true),
              /* <-------- Body Content --------> */

              body: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                /* <-------- Image View From Api at a large scale --------> */
                child: InteractiveViewer(
                    maxScale: 4,
                    child: MixedImageWidget(
                        boxFit: BoxFit.contain,
                        imageData: controller
                            .imageData) /*  Image.network(
                    controller.imageData,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const DocumentLoadingImagePlaceholderWidget(
                                loadingAssetImageLocation:
                                    AppAssetImages.imagePlaceholderIconImage),
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
                            wasSynchronouslyLoaded
                                ? child
                                : AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                    child: child,
                                  ),
                    errorBuilder: (context, error, stackTrace) =>
                        const ErrorLoadedIconWidget(isLargeIcon: true),
                  ), */
                    ),
              ),
            ));
  }
}
