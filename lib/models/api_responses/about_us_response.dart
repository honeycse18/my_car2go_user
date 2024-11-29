import 'dart:convert';

import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class AboutUsResponse {
  bool error;
  String msg;
  AboutUsData data;

  AboutUsResponse({this.error = false, this.msg = '', required this.data});

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) {
    return AboutUsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: AboutUsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory AboutUsResponse.empty() => AboutUsResponse(data: AboutUsData.empty());
  static AboutUsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AboutUsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AboutUsResponse.empty();
}

class AboutUsData {
  String id;
  String title;
  String slug;
  String contentType;
  ContentResponse content;
  DateTime createdAt;
  DateTime updatedAt;

  AboutUsData({
    this.id = '',
    this.title = '',
    this.slug = '',
    this.contentType = '',
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AboutUsData.fromJson(Map<String, dynamic> json) => AboutUsData(
        id: APIHelper.getSafeString(json['_id']),
        title: APIHelper.getSafeString(json['title']),
        slug: APIHelper.getSafeString(json['slug']),
        contentType: APIHelper.getSafeString(json['content_type']),
        content: ContentResponse.getAPIResponseObjectSafeValue(
            jsonDecode(json['content'])),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'content_type': contentType,
        'content': content,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory AboutUsData.empty() => AboutUsData(
      content: ContentResponse.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static AboutUsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AboutUsData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : AboutUsData.empty();
}

class ContentResponse {
  OurHistory ourHistory;
  DownloadApp downloadApp;

  ContentResponse({required this.ourHistory, required this.downloadApp});

  factory ContentResponse.fromJson(Map<String, dynamic> json) {
    return ContentResponse(
      ourHistory: OurHistory.getAPIResponseObjectSafeValue(json['our_history']),
      downloadApp:
          DownloadApp.getAPIResponseObjectSafeValue(json['download_app']),
    );
  }

  Map<String, dynamic> toJson() => {
        'our_history': ourHistory.toJson(),
        'download_app': downloadApp.toJson(),
      };

  factory ContentResponse.empty() => ContentResponse(
        downloadApp: DownloadApp.empty(),
        ourHistory: OurHistory(),
      );
  static ContentResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ContentResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ContentResponse.empty();
}

class DownloadApp {
  String heading;
  String description;
  User user;
  Driver driver;
  String image;

  DownloadApp({
    this.heading = '',
    this.description = '',
    required this.user,
    required this.driver,
    this.image = '',
  });

  factory DownloadApp.fromJson(Map<String, dynamic> json) => DownloadApp(
        heading: APIHelper.getSafeString(json['heading']),
        description: APIHelper.getSafeString(json['description']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'heading': heading,
        'description': description,
        'user': user.toJson(),
        'driver': driver.toJson(),
        'image': image,
      };

  factory DownloadApp.empty() => DownloadApp(driver: Driver(), user: User());
  static DownloadApp getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DownloadApp.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DownloadApp.empty();
}

class User {
  String googlePlay;
  String appStore;

  User({this.googlePlay = '', this.appStore = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        googlePlay: APIHelper.getSafeString(json['google_play']),
        appStore: APIHelper.getSafeString(json['app_store']),
      );

  Map<String, dynamic> toJson() => {
        'google_play': googlePlay,
        'app_store': appStore,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class OurHistory {
  String heading;
  String description1;
  String description2;
  String image;

  OurHistory({
    this.heading = '',
    this.description1 = '',
    this.description2 = '',
    this.image = '',
  });

  factory OurHistory.fromJson(Map<String, dynamic> json) => OurHistory(
        heading: APIHelper.getSafeString(json['heading']),
        description1: APIHelper.getSafeString(json['description_1']),
        description2: APIHelper.getSafeString(json['description_2']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'heading': heading,
        'description_1': description1,
        'description_2': description2,
        'image': image,
      };

  static OurHistory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OurHistory.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : OurHistory();
}

class Driver {
  String googlePlay;
  String appStore;

  Driver({this.googlePlay = '', this.appStore = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        googlePlay: APIHelper.getSafeString(json['google_play']),
        appStore: APIHelper.getSafeString(json['app_store']),
      );

  Map<String, dynamic> toJson() => {
        'google_play': googlePlay,
        'app_store': appStore,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}
