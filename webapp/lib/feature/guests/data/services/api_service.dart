import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../models/guest_model.dart';
import 'package:flutter/foundation.dart';

class APIService {
  static var client = http.Client();
  static final APIService instance = APIService._init();
  static Guest? _guest;

  APIService._init();

  Future<List<Guest>?> getGuests() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.guestURL);

    debugPrint('url: $url');

    var response = await http.get(url, headers: requestHeaders);
    debugPrint('response: $response');

    if (response.statusCode == 200) {
      List<Guest> _guest = guestFromJson(response.body);

      return _guest;
    } else {
      return null;
    }
  }

  Future<Guest> saveGuest(
    Guest model,
  ) async {
    var guestURL = Config.guestURL;

    var url = Uri.http(Config.apiURL, guestURL);
    debugPrint('url: $url');

    Map data;
    var body;
    var response;

    data = {
      'name': model.name,
      'phone': model.phone,
      'email': model.email,
    };
    body = json.encode(data);

    response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    debugPrint('response $response');

    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('response $response.statusCode');
      return model;
    } else {
      debugPrint('response $response.statusCode');
      return model;
    }
  }

  Future<Guest> updateGuests(
    Guest model,
  ) async {
    var guestURL = Config.guestURL;

    var url = Uri.http(Config.apiURL, guestURL);
    debugPrint('url: $url');

    Map data;
    var body;
    var response;

    data = {
      'id': model.id,
      'name': model.name,
      'phone': model.phone,
      'email': model.email,
    };
    body = json.encode(data);

    response = await http.put(url,
        headers: {"Content-Type": "application/json"}, body: body);

    debugPrint('response $response');

    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('response $response.statusCode');
      return model;
    } else {
      debugPrint('response $response.statusCode');
      return model;
    }
  }

  Future<bool> deleteGuest(id) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.guestURL + "/" + id.toString());
    debugPrint('url: $url');

    var response = await client.delete(url, headers: requestHeaders);
    debugPrint('response: $response');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
