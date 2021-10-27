import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/models/messsage_model/message.dart';
import 'package:link_refurb/repositories/pdf_repository/pdf_provider.dart';

class PDFRepository {
  final FlutterSecureStorage storage;
  final PDFProvider provider;

  PDFRepository({required this.provider, required this.storage});

  Future<MessageModel> upload({required File selectedfile}) async {
    var token = await storage.read(key: 'token');
    var response =
        await provider.upload(selectedfile: selectedfile, token: token);
    var model = messageModelFromJson(response);

    return model;
  }

   Future<MessageModel> delete() async {
    var token = await storage.read(key: 'token');
    var response =
        await provider.delete(token: token);
    var model = messageModelFromJson(response);

    return model;
  }
}
