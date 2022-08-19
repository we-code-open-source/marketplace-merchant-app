import 'dart:convert';
import 'dart:io';
import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:http/http.dart' as http;

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/statistic.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;


Future<Statistics?> getStatistics() async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'statistics?$_apiToken';
  try {
    final client = new http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      print('TOMap: ${json.decode(response.body)['data']}');
      return Statistics.fromJson(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      throw new Exception(response.body);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
  }
}