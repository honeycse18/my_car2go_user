import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardScreenController extends GetxController {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  var scanResult = "Scan a barcode".obs;

  // Method to scan barcode
  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan(); // Open scanner
      scanResult.value = result.rawContent.isNotEmpty
          ? result.rawContent
          : "Failed to scan barcode";
    } catch (e) {
      scanResult.value = "Error occurred: $e";
    }
  }
}
