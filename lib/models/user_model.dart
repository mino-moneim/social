class UserModel {
  late String uId;
  late String name;
  late String email;
  late String password;
  late String phone;
  late String image;
  late String cover;
  late String bio;
  late bool passwordVerified;

  UserModel({
    this.uId = '',
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.image = '',
    this.cover = '',
    this.bio = '',
    this.passwordVerified = false,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    passwordVerified = json['passwordVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
      'passwordVerified': passwordVerified,
    };
  }
}
