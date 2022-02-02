import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:database_pharmacy/model/http_result.dart';
import "package:http/http.dart" as http;

class AppProvider {
  String baseUrl = "https://api.gopharm.uz/api/v1/";
  static Duration duration = const Duration(seconds: 30);

  static Future<HttpResult> _getResponse(String url) async {
    print(url);
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "Internet error",
      );
    } on SocketException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "InternetError",
      );
    }
  }

  static Future<HttpResult> _postResponse(String url, data) async {
    print(url);
    print(data);
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(duration);

      return _result(response);
    } on SocketException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "Internet Error",
      );
    } on TimeoutException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "Internet Error",
      );
    }
  }

  static Future<HttpResult> _postResponseRegister(
      String url, data, header) async {
    print(url);
    print(data);
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: header,
          )
          .timeout(duration);

      return _result(response);
    } on SocketException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "Internet Error",
      );
    } on TimeoutException catch (_) {
      return HttpResult(
        statusCode: -1,
        isSucces: false,
        result: "Internet Error",
      );
    }
  }

  static HttpResult _result(http.Response response) {
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return HttpResult(
        statusCode: response.statusCode,
        isSucces: true,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    } else if (response.statusCode >= 500) {
      return HttpResult(
        statusCode: response.statusCode,
        isSucces: false,
        result: "Server error",
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSucces: false,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    }
  }

  Future<HttpResult> getCategory() async {
    String url = baseUrl + "categories";
    return _getResponse(url);
  }

  Future<HttpResult> getLogin(String number) async {
    String url = baseUrl + "register";
    var data = {
      "login": number,
    };
    return _postResponse(url, data);
  }

  Future<HttpResult> getAccept(String number, String code) async {
    String url = baseUrl + "accept";
    var data = {
      "login": number,
      "smscode": code,
    };
    return _postResponse(url, data);
  }

  Future<HttpResult> registerData(
    String firstName,
    String lastName,
    String gender,
    String birthData,
    String token,
  ) async {
    String url = baseUrl + "register-profil";

    var data = {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender,
      "birth_date": birthData,
    };
    var head = {"Authorization": "Bearer " + token};
    return _postResponseRegister(url, data, head);
  }

  Future<HttpResult> getDrugs() async {
    String url = baseUrl + "drugs";
    return _getResponse(url);
  }

  Future<HttpResult> senData() async {
    String url = baseUrl + "categories";
    return _getResponse(url);
  }

  Future<HttpResult> getSales() async {
    String url = baseUrl + "sales";
    return _getResponse(url);
  }

  Future<HttpResult> getChoice() async {
    String url = baseUrl + "pages";
    return _getResponse(url);
  }

  Future<HttpResult> getStory() async {
    String url = baseUrl + "stores";
    return _getResponse(url);
  }

  Future<HttpResult> getRegion() async {
    String url = baseUrl + "regions";
    return _getResponse(url);
  }

  Future<HttpResult> getSearch() async {
    String url = baseUrl + "drugs?search=";
    return _getResponse(url);
  }
}
