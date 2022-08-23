import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  bool? isCreated;
  String? profile;
   

  // String? age;

  UserModel(
      {this.uid,
      this.email,
      this.name,
      this.phone,
      this.isCreated,
      this.profile,
      });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      isCreated: map['isCreated'],
      profile: map['profile'],
    );
  }

 

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'profile': profile,
      'isCreated': isCreated,
    };
  }
}






class ItemModel {
  String? title;
  String? shortInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? longDescription;
  String? status;
  int? discount;
  int? price;
  String? category;
  String? brand;

  ItemModel(
      {required this.title,
        required this.shortInfo,
        required this.publishedDate,
        required this.thumbnailUrl,
        required this.longDescription,
        required this.discount,
        required this.status,
        required this.category,
        required this.brand
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    category = json['category'];
    brand = json['brand'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['category'] = this.category;
    data['brand'] = this.brand;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    return data;
  }
}

class PublishedDate {
  String? date;

  PublishedDate({required this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}



class CartItemModel {
  String? title;
  String? shortInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? longDescription;
  String? status;
  int? discount;
  int? price;
  int? quantity;
  String? category;
  String? brand;
  String? size;

  CartItemModel(
      {required this.title,
        required this.shortInfo,
        required this.publishedDate,
        required this.thumbnailUrl,
        required this.longDescription,
        required this.discount,
        required this.status,
        required this.quantity,
        required this.size,
        required this.category,
        required this.brand
        });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    shortInfo = json['shortInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    status = json['status'];
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
    brand = json['brand'];
    size = json['size'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    data['category'] = this.category;
    data['size'] = this.size;
    data['brand'] = this.brand;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['status'] = this.status;
    return data;
  }
}

class CartPublishedDate {
  String? date;

  CartPublishedDate({required this.date});

  CartPublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}


