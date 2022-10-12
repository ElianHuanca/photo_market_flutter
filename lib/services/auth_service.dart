import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:photo_market/models/models.dart';

class AuthService extends ChangeNotifier {
  static UserModel? user;
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyA-fYv6FgTePKWrh0U5TcV-F6Br_J-BUzc';

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      await storageWrite(decodedResp['idToken'], email, password);
      await loginLaravel(email, password);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }


  Future loginLaravel(String email, String password) async {
    final response = await http.post(
        Uri.parse('http://192.168.100.235/sw-photo/public/api/login'),
        body: ({
          'email': email,
          'password': password,
        }));
    user = UserModel.fromJson(response.body);
  }
  Future logout() async {
    await storage.deleteAll();
    return;
  }
  Future storageWrite(String idToken, String email, String password) async {
    await storage.write(key: 'token', value: idToken);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
  }
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
  Future<String> readEmail() async {
    return await storage.read(key: 'email') ?? '';
  }
  Future<String> readPassword() async {
    return await storage.read(key: 'password') ?? '';
  }
}
