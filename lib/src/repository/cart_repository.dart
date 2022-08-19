
import 'dart:convert';
import 'dart:io';

import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:food_delivery_owner/src/helpers/custom_trace.dart';
import 'package:food_delivery_owner/src/models/distance.dart';

import '../helpers/helper.dart';
import '../models/cart.dart';
import '../models/user.dart';
import 'user_repository.dart';
import 'package:http/http.dart' as http;

Future<Stream<Cart>> getCart() async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    // return new Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url_  + 'carts?${_apiToken}with=food;food.restaurant;extras&search=user_id:${_user.id}&searchFields=user_id:=';
  print('++++++++++++++url+++++++++++++++++');
  print(url);
  print('++++++++++++++++++++++++++++++++++');
  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
    return Cart.fromJSON(data);
  });
}


Future<Stream<int>> getCartCount() async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(0);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url = api_base_url_  + 'carts/count?${_apiToken}search=user_id:${_user.id}&searchFields=user_id:=';
 print(url);
 final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map(
        (data) => Helper.getIntData(data as Map<String, dynamic>),
  );
}


Future<Cart> addCart(Cart cart, bool reset) async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return new Cart();
  }
  Map<String, dynamic> decodedJSON = {};
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String _resetParam = 'reset=${reset ? 1 : 0}';
  cart.userId = _user.id;
  final String url = api_base_url_  + 'carts?$_apiToken&$_resetParam';
  final client = new http.Client();
  print(url);
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(cart.toMap()),
  );
  try {
    decodedJSON = json.decode(response.body)['data'] as Map<String, dynamic>;
  } on FormatException catch (e) {
    print(CustomTrace(StackTrace.current, message: e.toString()));
  }
  return Cart.fromJSON(decodedJSON);
}

Future<String> getDistanceAndTime(lng,lat) async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return "";
  }
  final String url = api_base_url_  + 'distance?from_longitude=${_user.restaurant!.longitude}&from_latitude=${_user.restaurant!.latitude}&to_longitude=$lng&to_latitude=$lat';
  final client = new http.Client();
  print(url);
  final response = await client.get(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print(json.decode(response.body)['data']);
  DistanceGoogle value= DistanceGoogle.fromJson(json.decode(response.body)['data']);
  String price =Helper.getTimePriceDouble(value.duration!
      .value! / 60, value.distance!
      .value! / 1000).toString();
  return  price;
}



Future<Cart> updateCart(Cart cart) async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return new Cart();
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  cart.userId = _user.id;
  final String url = api_base_url_  + 'carts/${cart.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(cart.toMap()),
  );
  return Cart.fromJSON(json.decode(response.body)['data']);
}

Future<bool> removeCart(Cart cart) async {
  User _user = currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = api_base_url_  + 'carts/${cart.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.delete(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  return Helper.getBoolData(json.decode(response.body));
}