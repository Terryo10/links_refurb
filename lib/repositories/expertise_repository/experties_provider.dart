import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:http/http.dart' as http;

class ExpertiseProvider {
  final FlutterSecureStorage storage;

  ExpertiseProvider({required this.storage});

  Future getExpertiesList() async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.expertiseList}';
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.body);
        throw new Exception("Oops! Something went wrong.");
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }

  Future selectExperties({required expertiseId}) async {
    try {
      print('submitting experties $expertiseId');
      var token = await storage.read(key: 'token');
      String url = '${AppStrings.baseUrl}${AppStrings.updateExpertise}';

      print(url);
      var body = jsonEncode(<String, int>{'expertise_id': expertiseId});
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      };

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

  Future changeExperties({required expertiseId}) async {
    try {
      print('submitting experties $expertiseId');
      var token = await storage.read(key: 'token');
      String url = '${AppStrings.baseUrl}${AppStrings.changeExpertise}';

      print(url);
      var body = jsonEncode(<String, int>{'expertise_id': expertiseId});
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      };

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
}
