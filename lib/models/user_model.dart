// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? email;
  String? customerid;
  String? fundingid;
  String? imei;
  String? gender;
  String? pin;
  UserModel({
    this.email,
    this.customerid,
    this.fundingid,
    this.imei,
    this.gender,
    this.pin,
  });

  UserModel copyWith({
    String? email,
    String? customerid,
    String? fundingid,
    String? imei,
    String? gender,
    String? pin,
  }) {
    return UserModel(
      email: email ?? this.email,
      customerid: customerid ?? this.customerid,
      fundingid: fundingid ?? this.fundingid,
      imei: imei ?? this.imei,
      gender: gender ?? this.gender,
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'customerid': customerid,
      'fundingid': fundingid,
      'imei': imei,
      'gender': gender,
      'pin': pin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      customerid: map['customerid'] != null ? map['customerid'] as String : null,
      fundingid: map['fundingid'] != null ? map['fundingid'] as String : null,
      imei: map['imei'] != null ? map['imei'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      pin: map['pin'] != null ? map['pin'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, customerid: $customerid, fundingid: $fundingid, imei: $imei, gender: $gender, pin: $pin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.customerid == customerid &&
      other.fundingid == fundingid &&
      other.imei == imei &&
      other.gender == gender &&
      other.pin == pin;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      customerid.hashCode ^
      fundingid.hashCode ^
      imei.hashCode ^
      gender.hashCode ^
      pin.hashCode;
  }
}
