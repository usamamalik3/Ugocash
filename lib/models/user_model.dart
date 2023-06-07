// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? email;
  String? customerid;
  String? fundingid;
  UserModel({
    this.email,
    this.customerid,
    this.fundingid,
  });


  UserModel copyWith({
    String? email,
    String? customerid,
    String? fundingid,
  }) {
    return UserModel(
      email: email ?? this.email,
      customerid: customerid ?? this.customerid,
      fundingid: fundingid ?? this.fundingid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'customerid': customerid,
      'fundingid': fundingid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      customerid: map['customerid'] != null ? map['customerid'] as String : null,
      fundingid: map['fundingid'] != null ? map['fundingid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, customerid: $customerid, fundingid: $fundingid)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.customerid == customerid &&
      other.fundingid == fundingid;
  }

  @override
  int get hashCode => email.hashCode ^ customerid.hashCode ^ fundingid.hashCode;
  }
