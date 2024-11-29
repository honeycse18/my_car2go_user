import 'package:car2gouser/utils/constants/app_components.dart';

class GraphItemData {
  double value;
  DateTime dateTime;
  GraphItemData({
    this.value = 0,
    required this.dateTime,
  });
  factory GraphItemData.empty() =>
      GraphItemData(dateTime: AppComponents.defaultUnsetDateTime);
}
