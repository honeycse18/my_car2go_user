import 'location.dart';

class Datum {
  String? id;
  String? uid;
  String? title;
  int? price;
  Location? location;
  List<String>? images;

  Datum({
    this.id,
    this.uid,
    this.title,
    this.price,
    this.location,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['_id'] as String?,
        uid: json['uid'] as String?,
        title: json['title'] as String?,
        price: json['price'] as int?,
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        images: json['images'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'title': title,
        'price': price,
        'location': location?.toJson(),
        'images': images,
      };
}
