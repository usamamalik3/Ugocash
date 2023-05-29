// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
   String? email;
  String? phoneno;
  String? password;
  UserModel({
    this.email,
    this.phoneno,
    this.password,
  });

  UserModel copyWith({
    String? email,
    String? phoneno,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      phoneno: phoneno ?? this.phoneno,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phoneno': phoneno,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      phoneno: map['phoneno'] != null ? map['phoneno'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, phoneno: $phoneno, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.phoneno == phoneno &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ phoneno.hashCode ^ password.hashCode;
}
