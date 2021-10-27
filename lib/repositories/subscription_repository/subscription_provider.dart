import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/data/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class SubscriptionProvider {
  final FlutterSecureStorage storage;

  SubscriptionProvider({required this.storage});

  Future getPrice() async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.getPrice}';
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

  Future makePayment(
      {required String phoneNumber, required String method}) async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.makePayment}';
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode(
              <String, String>{'method': method, 'phone_number': phoneNumber}));
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

  Future checkPayment({required num orderId}) async {
    try {
      var token = await storage.read(key: 'token');
      var url = '${AppStrings.baseUrl}${AppStrings.checkPayment}$orderId';
      print(url);
      var headers = <String, String>{
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print(response.body);
        var data = jsonDecode(response.body);
        throw new Exception(data['message']);
      }
    } on SocketException {
      throw Exception('We cannot connect, check your connection');
    } catch (e) {
      throw new Exception("Oops! Something went wrong.");
    }
  }
}
