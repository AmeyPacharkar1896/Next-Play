import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    required this.id,
    this.name,
    this.email,
    // this.userType,
  });

  final String id;
  final String? name;
  final String? email;
  // final UserTypeEnum? userType;

  // Converts the enum to a string when saving to Firestore
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      // 'userType': userType?.toString().split('.').last, // Save enum as a string
    };
  }

  // Converts the string back to an enum when retrieving from Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      // userType: map['userType'] != null
      //     ? UserTypeEnum.values.firstWhere(
      //         (e) => e.toString().split('.').last == map['userType'],
      //       )
      //     : null,
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName,
      email: user.email,
      // userType: null,
    );
  }

  factory UserModel.placeholder() {
    return UserModel(
      id: '',
      name: 'Unknown User',
      email: '',
      // userType: null,
    );
  }
}
