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
