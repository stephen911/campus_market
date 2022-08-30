import 'package:cloud_firestore/cloud_firestore.dart';

class cartModel {
  String? title;
  // String? shortInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? description;
  String? status;
  int? discount;
  double? price;
  String? category;
  String? brand;

  // String? age;

  cartModel(
      {  this.title,
      // required this.shortInfo,
        this.publishedDate,
        this.thumbnailUrl,
        this.description,
        this.discount,
        this.status,
        this.category,
        this.brand});

  // receiving data from server
  factory cartModel.fromMap(map) {
    return cartModel(
      title: map['title'],
      publishedDate: map['publishedDate'],
      thumbnailUrl: map['thumbnailUrl'],
      description: map['description'],
      discount: map['discount'],
      status: map['status'],
      brand: map['brand'],
      category: map['category'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'publishedDate': publishedDate,
      'category': category,
      'thumbnailUrl': thumbnailUrl,
      'brand': brand,
      'description': description,
      'status': status,
      'discount': discount,
    };
  }
}
