import 'dart:convert';
import 'dart:io';

import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/filter.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

Future<User?> getRestaurantByUser() async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'profile?$_apiToken';
  print("++++++++++++++getRestaurantByUser+++++++++++++++++");
  print(url);
  print("+++++++++++++++++++++++++++++++");
  try {
    final client = new http.Client();
    final response = await client.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      return User.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      throw new Exception(response.body);
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
  }
}

Future<Stream<Restaurant>> getRestaurants() async {
  Uri uri = Uri.parse(base_url + 'api/manager/restaurants');
  // Uri.parse(base_url + 'api/manager/restaurants');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(new Restaurant.fromJSON({}));
  }
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> getNearRestaurants(Address myLocation, Address areaLocation) async {
  Uri uri = Uri.parse(base_url + 'api/restaurants');
  // Uri.parse(base_url + 'api/restaurants');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));

  _queryParams['limit'] = '6';
  if (!myLocation.isUnknown() && !areaLocation.isUnknown()) {
    _queryParams['myLon'] = myLocation.longitude.toString();
    _queryParams['myLat'] = myLocation.latitude.toString();
    _queryParams['areaLon'] = areaLocation.longitude.toString();
    _queryParams['areaLat'] = areaLocation.latitude.toString();
  }
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> searchRestaurants(String search) async {
  Uri uri = Uri.parse(base_url + 'api/restaurants');
  // Uri uri = Uri.parse(base_url + 'api/restaurants');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = 'name:$search;description:$search';
  _queryParams['searchFields'] = 'name:like;description:like';
  _queryParams['limit'] = '5';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
      return Restaurant.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Restaurant>> getRestaurant(String id) async {
  Uri uri = Uri.parse(base_url + 'api/restaurants/$id');
  // Uri uri = Uri.parse(base_url + 'api/restaurants/$id');
  Map<String, dynamic> _queryParams = {};
  _queryParams['with'] = 'users';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).map((data) => Restaurant.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Restaurant.fromJSON({}));
  }
}

Future<Stream<Review>> getRestaurantReviews(String id) async {
  Uri uri = Uri.parse(base_url + 'api/restaurant_reviews');
  // Uri uri = Uri.parse(base_url + 'api/restaurant_reviews');
  Map<String, dynamic> _queryParams = {};
  _queryParams['with'] = 'user';
  _queryParams['search'] = 'restaurant_id:$id';
  _queryParams['limit'] = '5';
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Stream<Review>> getRecentReviews() async {
  final String url = api_base_url + 'restaurant_reviews?orderBy=updated_at&sortedBy=desc&limit=3&with=user';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data as Map<String,dynamic>)).expand((data) => (data as List)).map((data) {
      return Review.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Review.fromJSON({}));
  }
}

Future<Review> addRestaurantReview(Review review, Restaurant restaurant) async {
  final String url = api_base_url + 'restaurant_reviews';
  final client = new http.Client();
  review.user = userRepo.currentUser.value;
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.ofRestaurantToMap(restaurant)),
    );
    if (response.statusCode == 200) {
      return Review.fromJSON(json.decode(response.body)['data']);
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
      return Review.fromJSON({});
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Review.fromJSON({});
  }
}
