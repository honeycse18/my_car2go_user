import 'package:car2gouser/utils/constants/app_constants.dart';

sealed class DynamicFieldType {
  final String stringValue;

  const DynamicFieldType(this.stringValue);

  factory DynamicFieldType.parse(
          {required String type,
          bool isRequired = false,
          String fieldInfoType = '',
          int maxImageCount = 0,
          int maxSize = 0}) =>
      switch (type) {
        AppConstants.dynamicFieldTypeText => DynamicFieldText(),
        AppConstants.dynamicFieldTypeTextArea => DynamicFieldTextarea(),
        AppConstants.dynamicFieldTypeEmail => DynamicFieldEmail(),
        AppConstants.dynamicFieldTypeNumber => DynamicFieldNumber(),
        AppConstants.dynamicFieldTypeImage => switch (fieldInfoType) {
            AppConstants.dynamicFieldImageTypeSingle =>
              DynamicFieldSingleImage(),
            AppConstants.dynamicFieldImageTypeMultiple =>
              DynamicFieldMultipleImage(
                  maxImageCount: maxImageCount, maxSize: maxSize),
            _ => DynamicFieldUnknownImage(),
          },
        _ => DynamicFieldUnknown(),
      };

  bool get isTextField => switch (this) {
        DynamicFieldText() => true,
        DynamicFieldTextarea() => true,
        DynamicFieldEmail() => true,
        DynamicFieldNumber() => true,
        _ => false
      };
}

class DynamicFieldText extends DynamicFieldType {
  DynamicFieldText() : super(AppConstants.dynamicFieldTypeText);
}

class DynamicFieldTextarea extends DynamicFieldType {
  DynamicFieldTextarea() : super(AppConstants.dynamicFieldTypeTextArea);
}

class DynamicFieldEmail extends DynamicFieldType {
  DynamicFieldEmail() : super(AppConstants.dynamicFieldTypeEmail);
}

class DynamicFieldNumber extends DynamicFieldType {
  DynamicFieldNumber() : super(AppConstants.dynamicFieldTypeNumber);
}

sealed class DynamicFieldImage extends DynamicFieldType {
  DynamicFieldImage() : super(AppConstants.dynamicFieldTypeImage);
}

class DynamicFieldSingleImage extends DynamicFieldImage {}

class DynamicFieldMultipleImage extends DynamicFieldImage {
  final int maxImageCount;
  final int maxSize;
  DynamicFieldMultipleImage({
    required this.maxImageCount,
    required this.maxSize,
  });
}

class DynamicFieldUnknownImage extends DynamicFieldImage {}

class DynamicFieldUnknown extends DynamicFieldType {
  DynamicFieldUnknown() : super('unknown');
}
