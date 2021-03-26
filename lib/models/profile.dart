import 'package:flutter/material.dart';

class Profile {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final bool isOk;

  Profile(
      {@required this.id,
      @required this.name,
      @required this.phoneNumber,
      @required this.email,
      @required this.isOk});

  factory Profile.fromJson({@required Map<String, dynamic> data}) => Profile(
      id: data['_id'] as String,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      email: data['email'] as String,
      isOk: true);

  factory Profile.hasError() => Profile(
      id: null, name: null, phoneNumber: null, email: null, isOk: false);
}
