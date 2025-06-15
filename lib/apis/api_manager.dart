import 'dart:convert';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiManager {
  // POST REQUEST
  static Future<Map<String, dynamic>> post(
    String endPoints,
    Map<String, dynamic>? body,
  ) async {
    Logger logger = Logger();
    dynamic responseData;
    try {
      final response = await http.post(
        Uri.parse(endPoints),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json', // ✅ Important
        },
      );

      if (response.statusCode == 201) {
        responseData = {'status': response.statusCode, 'data': response.body};
        logger.i(responseData);
      } else {
        responseData = {'status': response.statusCode, 'data': response.body};
        logger.e(responseData);
      }
      return responseData;
    } catch (e) {
      logger.e(e);
    }
    return responseData;
  }

  // GET REQUEST

  static Future<Map<String, dynamic>> get(String endPoint) async {
    Logger logger = Logger();
    dynamic responseData;
    try {
      final response = await http.get(
        Uri.parse(endPoint),
        headers: {
          'Content-Type': 'application/json', // ✅ Optional but good practice
        },
      );

      if (response.statusCode == 200) {
        responseData = {'status': response.statusCode, 'data': response.body};
        logger.i(responseData);
      } else {
        responseData = {'status': response.statusCode, 'data': response.body};
        logger.e(responseData);
      }
      return responseData;
    } catch (e) {
      logger.e(e);
    }
    return responseData;
  }

  static Future<List<dynamic>> getList(String endPoint) async {
    Logger logger = Logger();
    try {
      final response = await http.get(
        Uri.parse(endPoint),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(
          response.body,
        ); // ✅ decode directly
        logger.i({'status': response.statusCode, 'data': responseData});
        return responseData;
      } else {
        logger.e({'status': response.statusCode, 'data': response.body});
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e(e);
      rethrow; // Let caller handle error
    }
  }

  /// FOR CHECKING IF USER EXISTS IN POSTGRES DB

  static Future<bool> isUserExistsInDB(String uid) async {
    try {
      final response = await ApiManager.get(AppReqEndPoint.getUserById(uid));
      if (response['status'] == 200) {
        return true;
      } else if (response['status'] == 404) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
