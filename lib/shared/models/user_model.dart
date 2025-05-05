import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? displayName;
  String? email;
  bool? isEmailVerified;
  bool? isAnonymous;
  String? phoneNumber;
  String? photoURL;
  String? refreshToken;
  String? tenantId;
  String? uid;

  UserModel({
    this.displayName,
    this.email,
    this.isEmailVerified,
    this.isAnonymous,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.tenantId,
    this.uid
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    isAnonymous = json['isAnonymous'];
    phoneNumber = json['phoneNumber'];
    photoURL = json['photoURL'];
    refreshToken = json['refreshToken'];
    tenantId = json['tenantId'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    data['isAnonymous'] = isAnonymous;
    data['phoneNumber'] = phoneNumber;
    data['photoURL'] = photoURL;
    data['refreshToken'] = refreshToken;
    data['tenantId'] = tenantId;
    data['uid'] = uid;
    return data;
  }

  UserModel toModel(User user) => UserModel(
    displayName: user.displayName,
    email: user.email,
    isEmailVerified: user.emailVerified,
    isAnonymous: user.isAnonymous,
    phoneNumber: user.phoneNumber,
    photoURL: user.photoURL,
    refreshToken: user.refreshToken,
    tenantId: user.tenantId,
    uid: user.uid,
  );
}