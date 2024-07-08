import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:hiringbell/models/api_response.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/user.dart';
import 'package:hiringbell/utilities/Util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HttpService extends GetConnect {
  static HttpService? ajax;
  String _baseUrl = Constants.empty;
  String _resourceBaseUrl = Constants.empty;
  String? _token;

  HttpService._internal() {
    _initialized(isProdMode: Constants.isProduction);
  }

  String get token => _token ?? "";

  set setToken(String value) {
    _token = value;
  }

  void _initialized({bool isProdMode = true}) {
    String url = isProdMode
        ? "https://www.hiringbell.com/"
        : "http://192.168.1.100:8090/";

    setBaseUrl(
      baseUrl: "${url}hb/api/",
      resourceBaseUrl: "${url}resources/",
    );
  }

  static HttpService getInstance() {
    // ajax.setUpBaseUrl(true);
    return ajax ??= HttpService._internal();
  }

  void setBaseUrl({required String baseUrl, required String resourceBaseUrl}) {
    _baseUrl = baseUrl;
    _resourceBaseUrl = resourceBaseUrl;
  }

  String get getBaseUrl {
    return _baseUrl;
  }

  String get getImageBaseUrl {
    return _resourceBaseUrl;
  }

  Map<String, String> header() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
  }

  Map<String, String> imageHeader() {
    return {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': token
    };
  }

  Future<dynamic> httpGet(String url) async {
    var apiUrl = Uri.parse(getBaseUrl + url);
    // debugPrint("Page url: $apiUrl");
    final response = await get('$apiUrl', headers: header());
    if (response.status.isOk) {
      var body = ApiResponse.fromJson(response.body);
      return body.responseBody;
    } else {
      debugPrint(
          'Get Request failed with status: ${response.statusCode} for the $apiUrl');
      return null;
    }
  }

  Future<ApiResponse?> httpPost(String url, Map data) async {
    var apiUrl = getBaseUrl + url;
    final response = await post(apiUrl, data, headers: header());
    if (response.status.isOk) {
      var body = ApiResponse.fromJson(response.body);
      return body;
    } else {
      debugPrint(
          'Post Request failed with status: ${response.statusCode} for the path: $apiUrl');
      return null;
    }
  }

  Future<ApiResponse?> httpDelete(String url) async {
    var apiUrl = getBaseUrl + url;
    final response = await delete(apiUrl, headers: header());
    if (response.status.isOk) {
      var body = ApiResponse.fromJson(response.body);
      return body;
    } else {
      debugPrint(
          'Delete Request failed with status: ${response.statusCode} for the path: $apiUrl');
      return null;
    }
  }

  Future<String> login(String url, Map<String, dynamic> data) async {
    final response = await post(getBaseUrl + url, data, headers: header());
    if (response.status.isOk) {
      var body = ApiResponse.fromJson(response.body);
      User? user = User.fromJson(body.responseBody["UserDetail"]);
      Util util = Util.getInstance();
      setToken = user.token!;
      util.setUserDetail(body.responseBody["UserDetail"]);
      util.setAuthDetail(data);

      return Constants.success;
    } else {
      return Constants.fail;
    }
  }

  Future<Response<T>> httpPut<T>(String url, Map body) async {
    var apiUrl = getBaseUrl + url;
    final response = await put(apiUrl, body, headers: header());
    if (response.status.isOk) {
      return Response(
          body: response.body as T, statusCode: response.statusCode);
    } else {
      throw Exception(
          'Request failed with status: ${response.statusCode} for the path: $apiUrl');
    }
  }

  Future<void> uploadDataWithImage(
      String url, dynamic data, List<XFile> files) async {
    try {
      var formData = FormData({"userPost": data});

      for (var file in files) {
        formData.files.add(
          MapEntry(
            "postImages",
            MultipartFile(
              await file.readAsBytes(),
              filename:
                  "${DateTime.now().microsecondsSinceEpoch}.${file.path.split('.').last}",
            ),
          ),
        );
      }

      final response = await GetConnect().post(
        getBaseUrl + url,
        formData,
        headers: imageHeader(),
      );

      if (response.statusCode == 200) {
        // Handle successful upload
        debugPrint('Data uploaded successfully!');
      } else {
        // Handle upload error
        debugPrint('Upload failed with status code: ${response.statusCode}');
      }
    } on GetHttpException catch (e) {
      // Handle HTTP errors
      debugPrint('Error uploading data: $e');
    } catch (e) {
      // Handle other errors
      debugPrint('Error uploading data: $e');
    }
  }

  dynamic getResponseResult(dynamic data) {
    dynamic response = {};
    try {
      if (data == null) {
        throw Exception("User authentication is invalid");
      }

      response = data["ResponseBody"];
      if (response == null) {
        throw Exception("User authentication is invalid");
      }
      // ignore: empty_catches
    } on Exception catch (e) {
      rethrow;
    }

    return response;
  }

  Future<dynamic> upload(String url, List<XFile> files, dynamic data) async {
    var uri = Uri.parse("$_baseUrl$url");
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(imageHeader());

    request.fields['userPost'] = json.encode(data);
    if (files.isNotEmpty) {
      for (var image in files) {
        request.files.add(
          http.MultipartFile.fromBytes('postImages', await image.readAsBytes(),
              filename: image.path),
        );
      }
    } else {
      request.fields['postImages'] = jsonEncode(List.empty());
    }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (result["HttpStatusCode"] == 200) {
      return result["ResponseBody"];
    } else {
      return null;
    }
  }

  Future<dynamic> uploadUser(
      String url, XFile? profileImage, List<XFile>? docs, dynamic data) async {
    var uri = Uri.parse("$_baseUrl$url");
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(imageHeader());

    request.fields['user'] = json.encode(data);
    if (profileImage != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
            'profileImage', await profileImage.readAsBytes(),
            filename: profileImage.path),
      );
    } else {
      request.fields['profileImage'] = jsonEncode(List.empty());
    }

    if (docs != null) {
      for (var i = 0; i < docs.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes('Documents', await docs[i].readAsBytes(),
              filename: docs[i].path),
          // filename: docs[i].path ),
        );
      }
    } else {
      request.fields['Documents'] = jsonEncode(List.empty());
    }

    // if (deletedDocsId != null) {
    //   request.fields['deletedDocsId'] = jsonEncode(deletedDocsId);
    // } else {
    //   request.fields['deletedDocsId'] = jsonEncode(null);
    // }

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (result["HttpStatusCode"] == 200) {
      return result["ResponseBody"];
    } else {
      return null;
    }
  }
}
