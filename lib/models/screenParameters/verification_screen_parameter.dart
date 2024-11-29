import 'package:car2gouser/models/enums/otp_verify_purpose.dart';

class VerificationScreenParameter {
  final OtpVerifyPurpose purpose;
  final bool isIdentifierTypeEmail;
  final String identifier;
  final Map<String, dynamic> signUpDetails;
  final Map<String, dynamic> forgetPasswordDetails;
  final Map<String, dynamic> profileUpdateDetails;
  VerificationScreenParameter({
    required this.purpose,
    required this.identifier,
    required this.isIdentifierTypeEmail,
    this.signUpDetails = const {},
    this.forgetPasswordDetails = const {},
    this.profileUpdateDetails = const {},
  });
}
