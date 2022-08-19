import 'dart:convert';
import 'dart:io';

import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:food_delivery_owner/src/models/category.dart';
import 'package:food_delivery_owner/src/models/extra.dart';
import 'package:food_delivery_owner/src/models/extra_group.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/favorite.dart';
import '../models/filter.dart';
import '../models/food.dart';
import '../models/review.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

Future<Stream<Food>> getTrendingFoods(Address address) async {
  Uri uri = Uri.parse(base_url + 'api/foods');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  filter.delivery = false;
  filter.open = false;
  _queryParams['limit'] = '6';
  _queryParams['trending'] = 'week';
  if (!address.isUnknown()) {
    _queryParams['myLon'] = address.longitude.toString();
    _queryParams['myLat'] = address.latitude.toString();
    _queryParams['areaLon'] = address.longitude.toString();
    _queryParams['areaLat'] = address.latitude.toString();
  }
  _queryParams.addAll(filter.toQuery());
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}
Future<Stream<Category>> getCategories() async {
  Uri uri = Uri.parse(base_url + 'api/categories');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Category.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Category.fromJSON({}));
  }
}
Future<Stream<ExtraGroup>> getExtraGroups() async {
  Uri uri = Uri.parse(base_url + 'api/extra_groups');
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return ExtraGroup.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new ExtraGroup.fromJSON({}));
  }
}
Future<Stream<Food>> getFoods() async {
  Uri uri = Uri.parse(base_url + 'api/manager/foods');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['with'] = 'extras;category';
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}
Future<Stream<Extra>> getExtras() async {
  Uri uri = Uri.parse(base_url + 'api/extras');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  _queryParams['api_token'] = _user.apiToken;
  _queryParams['with'] = 'extragroup';
  _queryParams['search'] = 'restaurant_id:${_user.restaurant!.id}';
  _queryParams['searchFields'] = 'restaurant_id:=';
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Extra.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Extra.fromJSON({}));
  }
}
Future<Stream<Extra>> getExtrasByFood(id) async {
  Uri uri = Uri.parse(base_url + 'api/extras');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  _queryParams['food_id'] = id;
  _queryParams['search'] = 'restaurant_id:${_user.restaurant!.id}';
  _queryParams['searchFields'] = 'restaurant_id:=';
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Extra.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Extra.fromJSON({}));
  }
}
Future<Food> updateFood1(Food food) async {
  print(food.toMap());
  final String _apiToken = 'api_token=${userRepo.currentUser.value.apiToken}';
  final String url = base_url +
      'api/manager/foods/${food.id}?$_apiToken';
  print(url);
  try {
  final client = new http.Client();
  final response = await client.put(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    body: json.encode(food.toMap()),
  );

  print("res  " + response.body);
  print("res  " + response.statusCode.toString());
  var newFood = Food.fromJSON(json.decode(response.body)['data']);
  return newFood;
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url.toString()).toString());
    return new Food();
  }
}
Future<Stream<Food>> getFood(String foodId) async {
  Uri uri = Uri.parse(base_url + 'api/foods/$foodId');
  uri = uri.replace(queryParameters: {'with': 'restaurant;category;extras;foodReviews;foodReviews.user'});
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    print(uri);
    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Stream<Food>> searchFoods(String search, Address address) async {
  Uri uri = Uri.parse(base_url + 'api/foods');
  Map<String, dynamic> _queryParams = {};
  _queryParams['search'] = 'name:$search;description:$search';
  _queryParams['searchFields'] = 'name:like;description:like';
  _queryParams['limit'] = '5';
  if (!address.isUnknown()) {
    _queryParams['myLon'] = address.longitude.toString();
    _queryParams['myLat'] = address.latitude.toString();
    _queryParams['areaLon'] = address.longitude.toString();
    _queryParams['areaLat'] = address.latitude.toString();
  }
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Stream<Food>> getFoodsByCategory(categoryId) async {
  Uri uri = Uri.parse(base_url + 'api/foods');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  _queryParams['with'] = 'restaurant';
  _queryParams['search'] = 'category_id:$categoryId';
  _queryParams['searchFields'] = 'category_id:=';

  _queryParams = filter.toQuery(oldQuery: _queryParams);
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Stream<Favorite>> isFavoriteFood(String foodId) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    // return Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url = api_base_url + 'favorites/exist?${_apiToken}food_id=$foodId&user_id=${_user.id}';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getObjectData(data as Map<String, dynamic>)).map((data) => Favorite.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Favorite.fromJSON({}));
  }
}

Future<Stream<Favorite>> getFavorites() async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    // return Stream.value(null);
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'favorites?${_apiToken}with=food;user;extras&search=user_id:${_user.id}&searchFields=user_id:=';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));
  try {
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data  as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) => Favorite.fromJSON(data));
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return new Stream.value(new Favorite.fromJSON({}));
  }
}

Future<Favorite> addFavorite(Favorite favorite) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Favorite();
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  favorite.userId = _user.id;
  final String url = api_base_url + 'favorites?$_apiToken';
  try {
    final client = new http.Client();
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(favorite.toMap()),
    );
    return Favorite.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Favorite.fromJSON({});
  }
}

Future<Favorite> removeFavorite(Favorite favorite) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Favorite();
  }
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = api_base_url + 'favorites/${favorite.id}?$_apiToken';
  try {
    final client = new http.Client();
    final response = await client.delete(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    return Favorite.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Favorite.fromJSON({});
  }
}

Future<Stream<Food>> getFoodsOfRestaurant(String restaurantId, {List<String>? categories}) async {
  Uri uri = Uri.parse(base_url + 'api/foods/categories');
  Map<String, dynamic> query = {
    'with': 'restaurant;category;extras;foodReviews',
    'search': 'restaurant_id:$restaurantId',
    'searchFields': 'restaurant_id:=',
  };

  if (categories != null && categories.isNotEmpty) {
    query['categories[]'] = categories;
  }
  uri = uri.replace(queryParameters: query);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Stream<Food>> getTrendingFoodsOfRestaurant(String restaurantId) async {
  Uri uri = Uri.parse(base_url + 'api/foods');
  uri = uri.replace(queryParameters: {
    'with': 'category;extras;foodReviews',
    'search': 'restaurant_id:$restaurantId;featured:1',
    'searchFields': 'restaurant_id:=;featured:=',
    'searchJoin': 'and',
  });
  // TODO Trending foods only
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Stream<Food>> getFeaturedFoodsOfRestaurant(String restaurantId) async {
  Uri uri = Uri.parse(base_url + 'api/foods');
  uri = uri.replace(queryParameters: {
    'with': 'category;extras;foodReviews',
    'search': 'restaurant_id:$restaurantId;featured:1',
    'searchFields': 'restaurant_id:=;featured:=',
    'searchJoin': 'and',
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data  as Map<String, dynamic>)).expand((data) => (data as List)).map((data) {
      return Food.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Food.fromJSON({}));
  }
}

Future<Review> addFoodReview(Review review, Food food) async {
  final String url = api_base_url + 'food_reviews';
  final client = new http.Client();
  review.user = userRepo.currentUser.value;
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(review.ofFoodToMap(food)),
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
Future<bool> addFood(Food food, File image) async {
  print(food.toMap());
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'foods?$_apiToken';
  print(url);
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "multipart/form-data"
  };
  //create multipart request for POST or PATCH method
  var request = http.MultipartRequest("POST", Uri.parse(url));
  print("==========");
  print(food.toMap());
  print(image.path);
  print("==========");
  var pic = await http.MultipartFile.fromPath("image", image.path);
  //add multipart to request
  request.files.add(pic);
 // request.fields.addAll(food.toMap());
  //add text fields
  request.fields["name"] = food.name!;
  request.fields["description"] = food.description!;
  request.fields["price"] = food.price.toString();
  request.fields["discount_price"] = food.discountPrice.toString();
  request.fields["weight"] = '125';
  request.fields["featured"] = food.featured!?'1':'0';
  request.fields["deliverable"] = '1';
  request.fields["available"] = '1';
  request.fields["category_id"] = food.categoryId!;
  for (Extra item in food.extras!) {
    request.files.add(http.MultipartFile.fromString('extras[]', item.id!));
  }//create multipart using filepath, string or bytes

  request.headers.addAll(headers);
  // request.fields.addAll(user.toMap());

  //request.fields.addAll(user.toMap());
  print("request: " + request.fields.toString());
  print("request: " + request.files.toString());
  var response = await request.send();
  print("response: " + response.toString());
  if (response.statusCode == 200) {
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print("++++++++++");
    print(response.statusCode);
    print(responseString);
    print("++++++++++");
    return true;
  }else return false;
}

Future<bool> updateFood(Food food, File image) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'foods/${food.id}?$_apiToken';
  print(url);
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "multipart/form-data"
  };
  //create multipart request for POST or PATCH method
  var request = http.MultipartRequest("POST", Uri.parse(url));
  print("==========");
  print(food.toMap());
  print(image.path);
  print("==========");
  var pic = await http.MultipartFile.fromPath("image", image.path);
  //add multipart to request

  request.files.add(pic);
  //add text fields
  request.fields["_method"] = 'PUT';
  request.fields["name"] = food.name!;
  request.fields["description"] = food.description!;
  request.fields["price"] = food.price.toString();
  request.fields["discount_price"] = food.discountPrice.toString();
  request.fields["weight"] = '125';
  request.fields["featured"] = food.featured!?'1':'0';
  request.fields["deliverable"] = '1';
  request.fields["available"] = '1';
  request.fields["category_id"] = food.categoryId!;
  for (Extra item in food.extras!) {
    request.files.add(http.MultipartFile.fromString('extras[]', item.id!));
  }

  request.headers.addAll(headers);

  print("request: " + request.fields.toString());
  print("request: " + request.files.toString());
  var response = await request.send();
  if (response.statusCode == 200) {
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    print("++++++++++");
    print(response.statusCode);
    print(responseString);
    print("++++++++++");
    return true;
  }else return false;
}
Future<Extra> addExtra(Extra extra) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  extra.restaurantId=_user.restaurant!.id;
  print(extra.toMap());
  final String url =
      api_base_url_  + 'extras?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'},
      body: json.encode(extra.toMap()),
    );
    return Extra.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Extra.fromJSON({});
  }
}
Future<Extra> updateExtra(Extra extra) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  extra.restaurantId=_user.restaurant!.id;
  print(extra.toMap());
  final String url =
      api_base_url_  + 'extras/${extra.id}?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.put(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'},
      body: json.encode(extra.toMap()),
    );
    return Extra.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Extra.fromJSON({});
  }
}
