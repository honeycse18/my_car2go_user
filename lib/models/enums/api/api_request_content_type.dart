import 'package:car2gouser/utils/constants/app_constants.dart';

enum APIRequestContentType {
  json(AppConstants.apiContentTypeJSON),
  urlEncoded(AppConstants.apiContentTypeFormURLEncoded),
  formData(AppConstants.apiContentTypeFormData);

  final String stringValue;
  const APIRequestContentType(this.stringValue);
}
