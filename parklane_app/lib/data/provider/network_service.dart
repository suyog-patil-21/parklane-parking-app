import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/location_model.dart';
import '../../constants/globals.dart';

class NetworkService {
  final String baseUrl = "http://localhost:3000";
  Future<Map<String, dynamic>?> postLogin(String email, String password) async {
    Uri url = Uri.parse(baseUrl + "/login");
    try {
      final response = await http.post(url,
          body: <String, dynamic>{"email": email, "password": password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body)["error"];
        if (error["email"] != "") {
          throw CustomError(error["email"]);
        } else if (error["password"] != "") {
          throw CustomError(error["password"]);
        } else {
          throw CustomError(error);
        }
      }
    } on SocketException {
      throw CustomError("Server Error");
    }
  }

  Future<Map<String, dynamic>?> postSignUp(
      String userName, String email, String password) async {
    Uri url = Uri.parse(baseUrl + "/signup");
    print(url.toString());
    try {
      final response = await http.post(url, body: <String, dynamic>{
        "userName": userName,
        "email": email,
        "password": password
      });
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        final error = json.decode(response.body)["error"];
        if (error["email"] != "") {
          throw CustomError(error["email"]);
        }
        throw CustomError(error);
      }
    } on SocketException {
      throw CustomError("Server Error");
    }
  }

  Future<String?> getCurrentUser(String token) async {
    Uri url = Uri.parse(baseUrl + "/getCurrentUser");
    try {
      final response = await http.get(url, headers: <String, String>{
        "authorization": "Bearor " + token,
      });
      return response.body;
    } catch (err) {
      print(err);
      // throw Exception(err);
    }
  }

  Future<String?> getParkingArea() async {
    Uri url = Uri.parse(baseUrl + "/getParkingArea");

    try {
      final response = await http.get(url, headers: <String, String>{
        "authorization": "Bearor " + Globals.accessToken.toString(),
      });

      return response.body;
    } catch (err) {
      // throw err;
      print("Error in Repository : $err");
    }
  }
}

class CustomError implements Exception {
  final dynamic message;

  CustomError(this.message);
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }
}
