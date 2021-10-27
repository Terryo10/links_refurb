import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final FlutterSecureStorage storage;

  UserProvider({required this.storage});
  Future getUserData() async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.userData}';
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw new Exception("Oops! Something went wrong.");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }

  Future getAppliedJobs() async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.appliedJobs}';
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw new Exception("Oops! Something went wrong.");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }

  Future jobApplication({required jobId}) async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.jobApplication}$jobId';
      print(url);
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        var message = jsonDecode(response.body);
        throw new Exception(message['message']);
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }

  Future changePassword({required oldPassword, required newPassword}) async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.changePassword}';
      print(url);
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };

      var response = await http.post(Uri.parse(url),
          body: jsonEncode(<String, String>{
            'current_password': oldPassword,
            'new_password': newPassword
          }),
          headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        var message = jsonDecode(response.body);
        throw new Exception(message['message']);
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future uploadProfile(
      {required File selectedfile, required String phoneNumber}) async {
    var url = '${AppStrings.baseUrl}${AppStrings.createProfile}';
    var token = await storage.read(key: 'token');
    try {
      print(url);
      var response = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-type": "multipart/form-data"
      };

      response.headers['Authorization'] = 'Bearer $token';
      response.headers['content-type'] = 'application/json';
      response.fields['phone_number'] = phoneNumber;
      response.files.add(
        http.MultipartFile(
          'image',
          selectedfile.readAsBytes().asStream(),
          selectedfile.lengthSync(),
          filename: selectedfile.path,
          // contentType: MediaType('image','jpeg'),
        ),
      );
      var res = await response.send();
      final k = await http.Response.fromStream(res);
      print(k.body);
      print(res.headers);
      print(res.statusCode);
      if (k.statusCode == 200) {
        print(k.body);
        return k.body;
      } else {
        var decoded = jsonDecode(k.body);
        var message = decoded['message'];
        throw Exception(message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future deleteProfile() async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.deleteProfile}';
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw new Exception("Oops! Something went wrong.");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }
}
