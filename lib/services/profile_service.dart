import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rental/models/profile.dart';
import 'package:rental/constants.dart';

class ProfileService {
  Future<Profile> getProfileData() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();

    var url = Uri.https(api, '/user/profiles/personal');
    String token = await storage.read(key: 'token');
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Profile profileData;
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      profileData = Profile.fromJson(data: data['profile']);
      return profileData;
    } else {
      profileData = Profile.hasError();
      return profileData;
    }
  }
}
