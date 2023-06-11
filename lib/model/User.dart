import 'dart:convert';

class UserModel {

  String email;
  String name;
  String imgProfilePath;
  String? id;
  UserModel({
    required this.email,
    required this.name,
    required this.imgProfilePath,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'imgProfilePath': imgProfilePath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imgProfilePath: map['imgProfilePath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'User(email: $email, name: $name, imgProfilePath: $imgProfilePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.name == name &&
      other.imgProfilePath == imgProfilePath;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ imgProfilePath.hashCode;
}
