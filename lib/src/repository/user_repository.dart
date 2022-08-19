import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:food_delivery_owner/src/models/confirm_reset_code.dart';
import 'package:food_delivery_owner/src/models/reset_password.dart';
import 'package:food_delivery_owner/src/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/credit_card.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

ValueNotifier<User> currentUser = new ValueNotifier(User());
ValueNotifier<int> statusCode = new ValueNotifier(0);
ValueNotifier<int> numOfReq = new ValueNotifier(0);

Future<User> login(User user) async {
  final String url = api_base_url + 'login';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    statusCode.value = 200;
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  } else if (response.statusCode == 401) {
    print("statusCode 401");
    statusCode.value = 401;
  } else if (response.statusCode == 403) {
    print("statusCode 403");
    statusCode.value = 403;
  } else if (response.statusCode == 422) {
    print("statusCode 422");
    statusCode.value = 422;
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> checkPhoneRegister(String phone) async {
  numOfReq.value++;
  final String url =
      api_base_url + 'register?phone_number=$phone';
  final client = new http.Client();
  final response = await client.get(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<String> ConfirmRegister(ConfirmResetCode confirmResetCode) async {
  final String url = base_url +
      api_base_url + 'confirm_register';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(confirmResetCode.toMap()),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body)['token'];
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<User> register(User user) async {
  final String url =
      api_base_url + 'register';
  final client = new http.Client();
  final response = await client.post(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    statusCode.value = 200;
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
  return currentUser.value;
}

Future<bool> checkPhoneResetPassword(String phone) async {
  final String url =
      api_base_url + 'reset_password?phone_number=$phone';
  final client = new http.Client();
  final response = await client.get(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  print(response.body);
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<String> ConfirmResetVerificationCode(
    ConfirmResetCode confirmResetCode) async {
  final String url =
      api_base_url + 'confirm_reset_code';
  final client = new http.Client();
  final response = await client.post(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(confirmResetCode.toMap()),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body)['token'];
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<bool> resetPassword(ResetPassword resetPassword) async {
  final String url =
      api_base_url + 'reset_password';
  final client = new http.Client();
  final response = await client.post(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(resetPassword.toMap()),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    print(CustomTrace(StackTrace.current, message: response.body).toString());
    throw new Exception(response.body);
  }
}

Future<void> updateRestaurantAvailable(restaurantState) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      base_url  + 'api/restaurants/${currentUser.value.restaurant!.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode({'closed': restaurantState}),
  );
  print("res  " + response.body);
}

Future<bool> updateRestaurantWithImage(
    Restaurant restaurant, File image) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'restaurants/${restaurant.id}?$_apiToken';
  print(url);
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "multipart/form-data"
  };
  //create multipart request for POST or PATCH method
  var request = http.MultipartRequest("POST", Uri.parse(url));
  print("==========");
  print(restaurant.toMapUpdate());
  print(image.path);
  print("==========");
  var pic = await http.MultipartFile.fromPath("image", image.path);
  //add multipart to request

  request.files.add(pic);
  //add text fields
  request.fields["_method"] = 'PUT';
  request.fields["name"] = restaurant.name!;
  request.fields["description"] = restaurant.description!;
  request.fields["information"] = restaurant.information!;
  request.fields["phone"] = restaurant.phone!;
  request.fields["mobile"] = restaurant.mobile!;

  //create multipart using filepath, string or bytes

  request.headers.addAll(headers);
  // request.fields.addAll(user.toMap());

  //request.fields.addAll(user.toMap());
  print("request: " + request.fields.toString());
  print("request: " + request.files.toString());
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
  } else
    return false;
}

Future<Restaurant> updateRestaurant(Restaurant restaurant) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      base_url  + 'api/manager/restaurants/${restaurant.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(restaurant.toMapStatus()),
  );
  print("req  " + json.encode(restaurant.toMapStatus()));
  print("res  " + response.body);
  var newRestaurant = Restaurant.fromJSON(json.decode(response.body)['data']);
  return newRestaurant;
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  try {
    if (json.decode(jsonString)['data'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_user', json.encode(json.decode(jsonString)['data']));
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: jsonString).toString());
    throw new Exception(e);
  }
}

Future<void> setCreditCard(CreditCard creditCard) async {
  if (creditCard != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('credit_card', json.encode(creditCard.toMap()));
  }
}

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get('current_user').toString()));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

Future<CreditCard> getCreditCard() async {
  CreditCard _creditCard = new CreditCard();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('credit_card')) {
    _creditCard =
        CreditCard.fromJSON(json.decode(await prefs.get('credit_card').toString() ));
  }
  return _creditCard;
}

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      api_base_url + 'users/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
     Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}

Future<Stream<Address>> getAddresses() async {
  User _user = currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url =
      api_base_url + 'delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=is_default&sortedBy=desc';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Address.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Stream.value(new Address.fromJSON({}));
  }
}

Future<Address> addAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url =
      api_base_url + 'delivery_addresses?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.post(
       Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(address.toMap()),
    );
    return Address.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Address.fromJSON({});
  }
}

Future<Address> updateAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  address.userId = _user.id;
  final String url =
      api_base_url + 'delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.put(
       Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(address.toMap()),
    );
    return Address.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Address.fromJSON({});
  }
}

Future<Address> removeDeliveryAddress(Address address) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      api_base_url + 'delivery_addresses/${address.id}?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.delete(
     Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    return Address.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new Address.fromJSON({});
  }
}

Future<Stream<User>> getDriversOfRestaurant(String restaurantId) async {
  Uri uri = Uri.parse(base_url  +  'api/manager/users/drivers_of_restaurant/$restaurantId');
      // Uri.parse(base_url + 'api/manager/users/drivers_of_restaurant/$restaurantId');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
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
      return User.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(User.fromJSON({}));
  }
}

Future<User> addUser(User user) async {
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  user.restaurantId = _user.restaurant!.id;
  final String url =
      api_base_url + 'users/add?$_apiToken';
  final client = new http.Client();
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode(user.toAddUserMap()),
    );
    return User.fromJSON(json.decode(response.body)['data']);
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url));
    return new User.fromJSON({});
  }
}

Future<bool> updatePassword(User user) async {
  print(user.toPasswordMap());
  User _user = userRepo.currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url =
      api_base_url_ + 'users/change_password?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toPasswordMap()),
  );
  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<void> updateNotificationState(notificationState) async {
  var state;
  notificationState ? state = 1 : state = 0;
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url =
      api_base_url + 'users/update/${currentUser.value.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.post(
    Uri.parse(url),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    },
    body: json.encode({
      'restaurant_id': currentUser.value.restaurant!.id,
      'enable_notifications': state
    }),
  );
  print("res  " + response.body);
}
