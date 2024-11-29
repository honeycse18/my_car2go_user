import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService extends GetxService {
  late Box localBox;
  Future<LocalStorageService> init() async {
    await GetStorage.init();
    await Hive.initFlutter();
    localBox = await Hive.openBox(AppConstants.hiveBoxName);
    return this;
  }
}
