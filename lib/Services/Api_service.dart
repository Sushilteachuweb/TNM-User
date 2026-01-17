import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = "https://api.thenaukrimitra.com/api";

  // Send OTP (Login)
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final url = Uri.parse("$baseUrl/phone/send-otp");
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"phone": phone});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to send OTP: ${response.reasonPhrase}");
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final url = Uri.parse("$baseUrl/phone/verify-otp");
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "phone": phone,
      "otp": int.parse(otp),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final rawCookie = response.headers['set-cookie'];
      print("cookie=$rawCookie");

      if (rawCookie != null) {
        final pref = await SharedPreferences.getInstance();
        await pref.setString("cookie", rawCookie);
        print("cookiesaved=$rawCookie");
      }
      return json.decode(response.body);
    } else {
      throw Exception("Failed to verify OTP: ${response.reasonPhrase}");
    }
  }
}