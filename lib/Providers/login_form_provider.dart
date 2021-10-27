import 'dart:convert';

import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LoginFormProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  final formKey = new GlobalKey<FormState>();  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoginFormProvider() {
    print('LoginFormProvider starts');
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    // Await the http get response, then decode the json-formatted response.
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': this.email, 'password': this.password}
            ));
    return response.body;
  }

  getToken() async {
    final jsonData =
        await this._getJsonData('api_carros/public/api/v1/auth/login');
    final loginResponse = LoginModel.fromJson(jsonData);

    myToken = loginResponse.token;
    if (myToken != null) {
      print('Login token ' + myToken!);
    } else {
      print(loginResponse.message);
    }
    notifyListeners();
  }

  loginAsInvite() async {
    this.email = 'usertest@test.com';
    this.password = 'Usertest1234.';
    final jsonData =
        await this._getJsonData('api_carros/public/api/v1/auth/login');
    final loginResponse = LoginModel.fromJson(jsonData);
    myToken = loginResponse.token;
    if (myToken != null) {
      print('token ' + myToken!);
    } else {
      print(loginResponse.message!);
    }
    notifyListeners();
  }

  bool isValidForm() {
  return formKey.currentState?.validate() ?? false;
}
}
