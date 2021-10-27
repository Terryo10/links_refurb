import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:link_refurb/data/strings.dart';

class AuthenticationProvider {
  final FlutterSecureStorage storage;

  AuthenticationProvider({required this.storage});
  Future login({required String password, required String email}) async {
    String url = '${AppStrings.baseUrl}${AppStrings.loginUrl}';
    print(url);
    var body =
        jsonEncode(<String, String>{'email': email, 'password': password});
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        var data = jsonDecode(response.body);
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future logout() async {
    await storage.deleteAll();
  }

  Future register(
      {required String name,
      required String password,
      required String email}) async {
    String url = '${AppStrings.baseUrl}${AppStrings.registerUrl}';
    print(url);
    var body = jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'confirm_password': password
    });
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        var data = jsonDecode(response.body);
        if (data['errors'] != null) {
          throw Exception(data['errors']);
        } else {
          throw Exception(data['message']);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
