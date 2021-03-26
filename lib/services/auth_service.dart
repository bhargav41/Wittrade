import 'dart:developer' as developer;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rental/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<int> signUp(
      {@required String username,
      @required String password,
      @required String phone,
      @required String email}) async {
    var url = Uri.https(api, "/user/signup");
    developer.log('URL : ${url.toString()}', name: 'AuthService');
    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': username,
          'phoneNumber': '+91 $phone',
          'email': email,
          'password': password
        }));

    developer.log(
        'Request Body : ${jsonEncode({
          'name': username,
          'phoneNumber': '+91 $phone',
          'email': email,
          'password': password
        })}',
        name: 'AuthService');

    developer.log('Response Body : ${jsonDecode(response.body)}',
        name: 'AuthService');

    if (response.statusCode == 200) {
      storage.write(key: 'token', value: jsonDecode(response.body)['token']);
    }

    return response.statusCode;
  }

  Future<int> login({@required String password, @required String email}) async {
    var url = Uri.https(api, "/user/login");

    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}));

    developer.log('Response Body : ${jsonDecode(response.body)}',
        name: 'AuthService');

    if (response.statusCode == 200) {
      storage.write(key: 'token', value: jsonDecode(response.body)['token']);
    }

    return response.statusCode;
  }
}
