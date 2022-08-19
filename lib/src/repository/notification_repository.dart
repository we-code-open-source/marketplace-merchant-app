import 'dart:convert';
import 'dart:io';

import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:http/http.dart' as http;

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/notification.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;
import 'settings_repository.dart';

Future<Stream<Notification>> getNotifications() async {
  print('im heeer ');
  User _user = userRepo.currentUser.value;
  // if (_user.apiToken == null) {
  //   return new Stream.value(null);
  // }
  if (_user.apiToken == null) {
    return new Stream.value(Notification.fromJSON({}));
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      'http://localhost:2222/api/notifications?${_apiToken}search=notifiable_id:${_user.id}&searchFields=notifiable_id:=&orderBy=created_at&sortedBy=desc&limit=10';

  final client = new http.Client();
  try {
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Notification.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Stream.value(new Notification.fromJSON({}));
  }
}

Future<Stream<Notification>> getNotifications_1() async {
  print("getNotification");
  Uri uri = Uri.parse(base_url + 'api/notifications');

  // Uri uri = Uri.parse(base_url + 'api/notifications');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(Notification.fromJSON({}));
  }
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['search'] = 'notifiable_id:${_user.id}';
  _queryParams['searchFields'] = 'notifiable_id:=';
  _queryParams['orderBy'] = 'created_at';
  _queryParams['sortedBy'] = 'desc';
  _queryParams['limit'] = '10';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Notification.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Notification.fromJSON({}));
  }
}

Future<Notification> markAsReadNotifications(Notification notification) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Notification();
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      api_base_url + 'notifications/${notification.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(notification.markReadMap()),
  );
  print(
      "[${response.statusCode}] NotificationRepository markAsReadNotifications");
  return Notification.fromJSON(json.decode(response.body)['data']);
}

Future<Notification> removeNotification(Notification cart) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Notification();
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = api_base_url + 'notifications/${cart.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.delete(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print("[${response.statusCode}] NotificationRepository removeCart");
  return Notification.fromJSON(json.decode(response.body)['data']);
}

Future<void> sendNotification(String body, String title, User user) async {
  final data = {
    "notification": {"body": "$body", "title": "$title"},
    "priority": "high",
    "data": {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "messages",
      "status": "done"
    },
    "to": "${user.device_token}"
  };
  final String url = 'https://fcm.googleapis.com/fcm/send';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "key=${setting.value.fcmKey}",
    },
    body: json.encode(data),
  );
  if (response.statusCode != 200) {
    print('notification sending failed');
  }
}
