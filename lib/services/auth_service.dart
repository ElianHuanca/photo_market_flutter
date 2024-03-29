import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:photo_market/models/models.dart';
import 'package:photo_market/const/const.dart';

class AuthService extends ChangeNotifier {
  static UserModel? user;
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyA-fYv6FgTePKWrh0U5TcV-F6Br_J-BUzc';

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien! :)
  Future<String?> createUser(
      List<String> fotos, String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // * GUARDAR LAS FOTOS DEL USER NUEVO

    try {
      await registerLaravel(email, password);
      //var respuesta = await registrarFotos(fotos, email);
    } catch (e) {
      print('ocurrió un error al subir las fotos ${e.toString()}');
    }

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future registerLaravel(String email, String password) async {
   final response = await http.post(Uri.parse('$baseUrl/register'),
        body: ({'email': email, 'password': password, 'idRol': "1"}));
    user = UserModel.fromJson(response.body);
    print(user);
  }

  Future<String> registrarFotos(List<String> fotos, String email) async {
    //create multipart request for POST or PATCH method
    var request =
        http.MultipartRequest("POST", Uri.parse("$baseUrl/userPhotho"));

    request.fields["email"] = email;

    //create multipart using filepath, string or bytes
    var foto1 = await http.MultipartFile.fromPath("foto", fotos[0]);
    //add multipart to request
    request.files.add(foto1);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print('responseString: $responseString');
    return responseString;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      await loginLaravel(email, password);
      await storageWrite(decodedResp['idToken'], email, password);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future loginLaravel(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: ({
          'email': email,
          'password': password,
        }));
    user = UserModel.fromJson(response.body);
    print(user);
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
