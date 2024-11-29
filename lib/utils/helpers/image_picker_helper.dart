import 'dart:developer' as dev;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart' as image_picker;

/*<-------Image picker helper-------->*/
class ImagePickerHelper {
  static Future<List<image_picker.XFile>?> getPhoneImages() async {
    image_picker.ImagePicker imagePicker = image_picker.ImagePicker();
    try {
      final selectedImages = await imagePicker.pickMultiImage();
      dev.log(selectedImages.toString());
      return selectedImages;
    } on PlatformException catch (e) {
      if (e.code == 'storage_access_denied') {
        dev.log(e.toString());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<image_picker.XFile?> getPhoneImage() async {
    image_picker.ImagePicker imagePicker = image_picker.ImagePicker();
    try {
      final image_picker.XFile? selectedImage =
          await imagePicker.pickImage(source: image_picker.ImageSource.gallery);
      dev.log(selectedImage.toString());
      return selectedImage;
    } on PlatformException catch (e) {
      if (e.code == 'storage_access_denied') {
        dev.log(e.toString());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Uint8List?> getCorrectRotatedImageBytes(
      image_picker.XFile image) async {
    try {
      final selectedImageBytesBefore = (await image.readAsBytes());
      img.Image? capturedImage = img.decodeImage(selectedImageBytesBefore);
      if (capturedImage == null) return null;
      dev.log(
          'Image byte size before: ${selectedImageBytesBefore.lengthInBytes}');
      final resizedImage = capturedImage;
      final img.Image orientedImage = img.bakeOrientation(resizedImage);
      final selectedImageBytes =
          Uint8List.fromList(img.encodeJpg(orientedImage, quality: 80));
      dev.log('Image byte size after: ${selectedImageBytes.lengthInBytes}');
      return selectedImageBytes;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Uint8List>> getProcessedImages(
      List<image_picker.XFile> pickedImages) async {
    final List<Uint8List?> processedImages =
        await Future.wait(pickedImages.map((pickedImage) async {
      return await getCorrectRotatedImageBytesFromXFile(pickedImage);
    }).toList());
    final List<Uint8List> filteredProcessedImages =
        processedImages.whereNotNull().toList();
    return filteredProcessedImages;
  }

  static Future<Uint8List?> getProcessedImage(
      image_picker.XFile pickedImage) async {
    final Uint8List? processedImage =
        await getCorrectRotatedImageBytesFromXFile(pickedImage);
    return processedImage;
  }

  static Future<Uint8List?> getCorrectRotatedImageBytesFromXFile(
      image_picker.XFile image) async {
    final imageBytes = await compute(getCorrectRotatedImageBytes, image);
    if (imageBytes == null) return null;
    return imageBytes;
  }
}
