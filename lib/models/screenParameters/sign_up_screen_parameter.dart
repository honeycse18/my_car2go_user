import 'package:country_code_picker/country_code_picker.dart';

class SignUpScreenParameter {
  bool isEmail;
  String theValue;
  CountryCode? countryCode;
  SignUpScreenParameter(
      {this.isEmail = false, this.countryCode, required this.theValue});
}
