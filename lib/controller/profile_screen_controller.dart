import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:car2gouser/models/api_responses/country_list_response.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/models/bottom_sheet_paramers/profile_entry_text_field_bottom_sheet_parameter.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/enums/profile_field_name.dart';
import 'package:car2gouser/models/screenParameters/select_screen_parameters.dart';
import 'package:car2gouser/screens/bottomsheet_screen/profile_field_bottomsheet.dart';
import 'package:car2gouser/services/profile_service.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:country_flags/country_flags.dart';
import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileService = Get.find<ProfileService>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  ProfileDetails get profileDetails => profileService.profileDetails;
  set profileDetails(ProfileDetails value) {
    profileService.profileDetails = value;
  }

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController genderController = TextEditingController();

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
    update();
  }

  bool _isImageUpdating = false;
  bool get isImageUpdating => _isImageUpdating;
  set isImageUpdating(bool value) {
    _isImageUpdating = value;
    update();
  }

  bool get isNotEditing => isEditing == false;

  UserDetailsCountry? selectedCountry;
  List<UserDetailsCountry> countryList = [];
  bool editActive = false;

  bool imageEdit = false;
  bool nameEdit = false;
  bool emailEdit = false;
  bool phoneEdit = false;
  bool dialEdit = false;
  bool genderEdit = false;
  bool addressEdit = false;
  // bool countryEdit = false;

  List<Uint8List> selectedProfileImages = [];
  dynamic selectedProfileImage;

  bool emailVerified = false;
  bool phoneVerified = true;
  UserDetailsData userDetails = UserDetailsData.empty();
  String dialCode = '';
  //String phoneNumber = '';
  // String? selectedGender;
  Gender? selectedGender;
  LocationModel? selectedLocation;
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  // final RxBool isDropdownOpen = false.obs;
  // final RxString selectedGender = 'Select Gender'.obs;
  // TextEditingController emailTextEditingController = TextEditingController();
  // TextEditingController phoneTextEditingController = TextEditingController();
  // TextEditingController nameTextEditingController = TextEditingController();
  // TextEditingController addressTextEditingController = TextEditingController();

  // List<String> genderOptions = ["Male", "Female", "Other"];
  // List<String> genderOptions = ["Male", "Female", "Other"];

  void onFullNameTap() async {
    final result = await Get.bottomSheet(const EditProfileFieldBottomSheet(),
        isScrollControlled: true,
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.name,
                initialValue: profileDetails.name)));
    if (result is bool) {
      // controller.nameController.text = result;
      update();
    }
  }

  void onEmailAddressTap() {
    Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                profileFieldName: ProfileFieldName.email,
                initialValue: profileDetails.email)));
  }

  void onPhoneNumberTap() {
    Get.bottomSheet(
        isScrollControlled: true,
        const EditProfileFieldBottomSheet(),
        settings: RouteSettings(
            arguments: ProfileEntryTextFieldBottomSheetParameter(
                initialValue: profileDetails.phone,
                profileFieldName: ProfileFieldName.phone)));
  }

  void onEditProfileButtonTap() {
    AppDialogs.showConfirmDialog(
      messageText: 'Confirm to edit profile?',
      onYesTap: () async {
        isEditing = true;
      },
    );
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
    if (currentCountryCode.dialCode == dialCode) {
      dialEdit = false;
    } else {
      dialEdit = true;
    }
    update();
    editable();
  }

  Widget countryElementsList(UserDetailsCountry country) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            country.code,
            height: 60,
            width: 60,
            borderRadius: 15,
          ),
          AppGaps.wGap15,
          Expanded(
              child: Text(
            country.name,
            style: AppTextStyles.bodyBoldTextStyle,
          ))
        ],
      ),
    );
  }

  /*<----------- Get country elements ride from API ----------->*/
/*   Future<void> getCountryElementsRide() async {
    CountryListResponse? response = await APIRepo.getCountryList();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(CountryListResponse response) {
    countryList = response.data;
    update();
  } */

  /* <---- Address tap ----> */
  void onAddressTap() async {
    /*  if (imageEditCheck()) {
      return;
    } */
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            screenTitle:
                AppLanguageTranslation.selectAddressTransKey.toCurrentLanguage,
            showCurrentLocationButton: true,
            locationModel: selectedLocation));
    if (result is LocationModel) {
      // addressTextEditingController.text = result.address;
      selectedLocation = result;
      update();
      log('Address: ${result.address}');
    }
  }

  /* <---- Edit image button tap ----> */
  void onEditImageButtonTap() async {
    /*  if (fieldEditCheck()) {
      return;
    } */
    final pickedImages = await Helper.pickThenUploadImage(
        // onSuccessUploadSingleImage: _onSuccessUploadingProfileImage,
        fileName: 'Profile Image');
    // _onSuccessUploadingProfileImage(pickedImages, {});
    if (pickedImages.isEmpty) {
      return;
    }
    selectedProfileImage = pickedImages;
    isImageUpdating = true;
    await updateProfile(request: {'image': (selectedProfileImage as String)});
    isImageUpdating = false;
    update();
  }

  /* <---- Success uploading profile image ----> */
  void _onSuccessUploadingProfileImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    selectedProfileImages.clear();
    selectedProfileImages.addAll(rawImagesData);
    update();
    if (selectedProfileImages.isEmpty) {
      imageEdit = false;
    } else {
      imageEdit = true;
      selectedProfileImage = selectedProfileImages.firstOrNull ?? Uint8List(0);
    }
    update();
    editable();
    Get.snackbar(
        AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
        AppLanguageTranslation
            .successfullyuploadedNewProfileImageTransKey.toCurrentLanguage);
  }

  /* <---- Save changes button tap ----> */
/*   onSaveChangesButtonTap() {
    log('Save Changes button got tapped!');
    updateProfile();
  } */

  /* <---- Update profile from API ----> */
  Future<APIResponse<ProfileDetails>?> updateProfile(
      {required Map<String, dynamic> request, bool showDialog = true}) async {
    final response = await APIRepo.updateProfileDetails(request);
    if (response == null) {
      if (showDialog) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      }
      return response;
    } else if (response.error) {
      if (showDialog) {
        AppDialogs.showErrorDialog(messageText: response.message);
      }
      return response;
    }
    log(response.toJson((data) => data.toJson()).toString());
    await Helper.updateSavedUserDetails();
    _fillUserProfileDetails(profileDetails);
    if (showDialog) {
      AppDialogs.showSuccessDialog(messageText: response.message);
    }
    return response;
    // onSuccessUpdatingProfile(response);
  }

  onSuccessUpdatingProfile(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.message);
    setUpdatedUserDetailsToLocalStorage();
  }

  /* <---- Set updated user details to local storage  ----> */
  Future<void> setUpdatedUserDetailsToLocalStorage() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);
    // getUser();
    selectedProfileImage = Uint8List(0);
    selectedProfileImages.clear();

    imageEdit = false;
    nameEdit = false;
    emailEdit = false;
    phoneEdit = false;
    dialEdit = false;
    genderEdit = false;
    addressEdit = false;
    // countryEdit = false;
    editable();
    update();
  }

  void onGenderChange(Gender? newGender) {
    selectedGender = newGender;
    genderEdit = selectedGender != userDetails.genderAsEnum;
    update();
    editable();
  }

  String getPhoneFormatted() {
    // return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
    return '';
  }

/*   void getUser() {
    userDetails = Helper.getUser() as UserDetailsData;
    // _fillUserProfileDetails();
  } */

  void _fillUserProfileDetails(ProfileDetails userDetails) {
    // nameTextEditingController.text = userDetails.name;
    // emailTextEditingController.text = userDetails.email;
    // addressTextEditingController.text = userDetails.address;
    if (userDetails.image.isNotEmpty) {
      selectedProfileImage = userDetails.image;
    }
    _setPhoneNumber(userDetails.phone);
    _selectGender(userDetails.gender);
/*     LocationModel prevLocation = LocationModel(
        latitude: userDetails.location.lat,
        longitude: userDetails.location.lng,
        address: userDetails.address); 
    selectedLocation = prevLocation; */
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    // selectedCountry = countryList
    //     .firstWhereOrNull((element) => element.id == userDetails.country.id);

    update();
  }

  void _selectGender(String gender) {
    final foundGender = Gender.list
        .firstWhereOrNull((element) => element.stringValue == gender);
    if (foundGender != null) {
      selectedGender = foundGender;
    }
  }

  void _setPhoneNumber(String phoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(phoneNumber);
    dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    // phoneTextEditingController.text = phoneNumber;
    update();
  }

  bool imageEditCheck() {
    bool ret = false;
    if (imageEdit) {
      /* AppDialogs.showConfirmDialog(
        shouldCloseDialogOnceYesTapped: true,
        messageText: AppLanguageTranslation
            .youCanUpdateEitherImageOrFieldsOnceTranskey.toCurrentLanguage,
        onYesTap: () async {
          selectedProfileImage = Uint8List(0);
          imageEdit = false;
          editable();
          ret = false;
          update();
        },
      ); */
      if (imageEdit) {
        ret = true;
      }
    }
    return ret;
  }

  /*  bool fieldEditCheck() {
    bool ret = false;
    if (nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit /* countryEdit */) {
      /* AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .youCanUpdateEitherImageOrFieldsOnceTranskey.toCurrentLanguage,
        onYesTap: () async {
          nameTextEditingController.text = '';
          emailTextEditingController.text = '';
          phoneTextEditingController.text = '';
          addressTextEditingController.text = '';
          // selectedCountry = countryList.firstWhereOrNull(
          //     (element) => element.id == userDetails.country.id);
          nameEdit = false;
          emailEdit = false;
          phoneEdit = false;
          dialEdit = false;
          genderEdit = false;
          addressEdit = false;
          // countryEdit = false;
          ret = false;
          update();
          editable();
        },
      ); */
      if (nameEdit ||
              emailEdit ||
              phoneEdit ||
              dialEdit ||
              genderEdit ||
              addressEdit /* ||
          countryEdit */
          ) {
        ret = true;
      }
    }
    return ret;
  }
 */
  editable() {
    if (imageEdit ||
            nameEdit ||
            emailEdit ||
            phoneEdit ||
            dialEdit ||
            genderEdit ||
            addressEdit /* ||
        countryEdit */
        ) {
      editActive = true;
    } else {
      editActive = false;
    }
    update();
  }

/* <---- Initial state ----> */
  @override
  void onInit() async {
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      update();
    });
    _fillUserProfileDetails(profileDetails);
    // await getCountryElementsRide();
    // getUser();
/*     nameTextEditingController.addListener(() {
      imageEditCheck();
      if (nameTextEditingController.text.isNotEmpty &&
          nameTextEditingController.text != userDetails.name) {
        nameEdit = true;
      } else {
        nameEdit = false;
      }
      update();
      editable();
    }); */
    /* emailTextEditingController.addListener(() {
      if (emailTextEditingController.text.isNotEmpty &&
          emailTextEditingController.text != userDetails.email) {
        emailEdit = true;
      } else {
        emailEdit = false;
      }
      update();
      editable();
    });
    phoneTextEditingController.addListener(() {
      if (phoneTextEditingController.text.isNotEmpty &&
          getPhoneFormatted() != userDetails.phone) {
        phoneEdit = true;
      } else {
        phoneEdit = false;
      }
      update();
      editable();
    }); */
/*     addressTextEditingController.addListener(() {
      imageEditCheck();
      if (addressTextEditingController.text.isNotEmpty &&
          addressTextEditingController.text != userDetails.address) {
        addressEdit = true;
      } else {
        addressEdit = false;
      }
      update();
      editable();
    }); */
    super.onInit();
  }

  @override
  void onClose() {
    // emailTextEditingController.dispose();
    // phoneTextEditingController.dispose();
    // nameTextEditingController.dispose();
    // addressTextEditingController.dispose();
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
