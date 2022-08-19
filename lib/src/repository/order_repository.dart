import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:food_delivery_owner/src/models/credit_card.dart';
import 'package:food_delivery_owner/src/models/payment.dart';
import 'package:http/http.dart' as http;

import '../helpers/custom_trace.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as userRepo;

Future<Stream<Order>> getOrders(
    {List<String>? statusesIds, num? offset}) async {
  Uri uri = Uri.parse(base_url + 'api/orders');
  // Uri uri = Uri.parse(base_url + 'api/orders');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['limit'] = '20';
  _queryParams['offset'] = offset.toString();
  _queryParams['with'] =
      'foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment';
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';

  if (statusesIds != null && statusesIds.isNotEmpty) {
    _queryParams['statuses[]'] = statusesIds;
  }
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Order.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Order.fromJSON({}));
  }
}

Future<Stream<Order>> getNearOrders(
    Address myAddress, Address areaAddress) async {
  Uri uri = Uri.parse(base_url + 'api/orders');
  // Uri uri = Uri.parse(base_url + 'api/orders');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['limit'] = '6';
  _queryParams['with'] =
      'foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment';
  _queryParams['search'] = 'delivery_address_id:null';
  _queryParams['searchFields'] = 'delivery_address_id:<>';
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
  uri = uri.replace(queryParameters: _queryParams);

  //final String url = api_base_url + 'orders?${_apiToken}with=driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress&search=driver.id:${_user.id};order_status_id:$orderStatusId&searchFields=driver.id:=;order_status_id:=&searchJoin=and&orderBy=id&sortedBy=desc';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      print("Data : $data");
      return Order.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Order.fromJSON({}));
  }
}

Future<Stream<Order>> getOrdersHistory() async {
  Uri uri = Uri.parse(base_url + 'api/orders');
  // Uri uri = Uri.parse(base_url + 'api/orders');
  Map<String, dynamic> _queryParams = {};
  final String orderStatusId = "80"; // for delivered status
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['with'] =
      'driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment';
  _queryParams['search'] =
      'driver.id:${_user.id};order_status_id:$orderStatusId;delivery_address_id:null';
  _queryParams['searchFields'] =
      'driver.id:=;order_status_id:=;delivery_address_id:<>';
  _queryParams['searchJoin'] = 'and';
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
  uri = uri.replace(queryParameters: _queryParams);

  //final String url = api_base_url + 'orders?${_apiToken}with=driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress&search=driver.id:${_user.id};order_status_id:$orderStatusId&searchFields=driver.id:=;order_status_id:=&searchJoin=and&orderBy=id&sortedBy=desc';
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return Order.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Order.fromJSON({}));
  }
}

Future<Stream<Order>> getOrder(orderId) async {
  Uri uri = Uri.parse(base_url + 'api/orders/$orderId');
  // Uri uri = Uri.parse(base_url + 'api/orders/$orderId');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Stream.value(new Order());
  }

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['with'] =
      'driver;user;foodOrders;foodOrders.food;foodOrders.food.restaurant.users;foodOrders.extras;orderStatus;deliveryAddress;payment';
  uri = uri.replace(queryParameters: _queryParams);
  print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getObjectData(data as Map<String, dynamic>))
        .map((data) {
      return Order.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Order.fromJSON({}));
  }
}

Future<Stream<Order>> getRecentOrders() async {
  Uri uri = Uri.parse(base_url + 'api/orders');
  // Uri uri = Uri.parse(base_url + 'api/orders');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['limit'] = '4';
  _queryParams['with'] =
      'driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment';
  _queryParams['search'] = 'driver.id:${_user.id};delivery_address_id:null';
  _queryParams['searchFields'] = 'driver.id:=;delivery_address_id:<>';
  _queryParams['searchJoin'] = 'and';
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'desc';
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
      return Order.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Order.fromJSON({}));
  }
}

Future<Stream<QuerySnapshot>> getOrderNotification() async {
  return await FirebaseFirestore.instance
      .collection("current_orders")
      .where('restaurant_id',
          isEqualTo: userRepo.currentUser.value.restaurant!.id)
      .snapshots();
}

Future<Stream<OrderStatus>> getOrderStatuses() async {
  Uri uri = Uri.parse(base_url + 'api/order_statuses');
  // Uri uri = Uri.parse(base_url + 'api/order_statuses');
  Map<String, dynamic> _queryParams = {};
  User _user = userRepo.currentUser.value;

  _queryParams['api_token'] = _user.apiToken;
  _queryParams['orderBy'] = 'id';
  _queryParams['sortedBy'] = 'asc';
  _queryParams['filter'] = 'id;status;key';
  uri = uri.replace(queryParameters: _queryParams);
  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return OrderStatus.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(OrderStatus.fromJSON({}));
  }
}

Future<Stream<OrderStatus>> getOrderStatuses1() async {
  User _user = userRepo.currentUser.value;

  final String uri =
      'http://localhost:2222/api/order_statuses?ids[]=30&ids[]=120&api_token=${_user.apiToken}&orderBy=id&sortedBy=asc';

  print(uri);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', Uri.parse(uri)));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) {
      return OrderStatus.fromJSON(data);
    });
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(OrderStatus.fromJSON({}));
  }
}

Future<Order> updateOrder(Order order) async {
  Uri uri = Uri.parse(base_url + 'api/orders/${order.id}');

  // Uri uri = Uri.parse(base_url + 'api/orders/${order.id}');
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Order();
  }
  Map<String, dynamic> _queryParams = {};
  _queryParams['api_token'] = _user.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  //final String url = api_base_url + 'orders/${order.id}?$_apiToken';
  final client = new http.Client();
  final response = await client.put(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(order.editableMap()),
  );
  return Order.fromJSON(json.decode(response.body)['data']);
}

Future<bool> acceptOrder(id, time) async {
  print('id=>$id time => $time}');
  Uri uri = Uri.parse(base_url + 'api/orders/$id');

  // Uri uri = Uri.parse(base_url + 'api/orders/$id');
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  Map<String, dynamic> _queryParams = {};
  _queryParams['api_token'] = _user.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  final client = new http.Client();
  final response = await client.put(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(
        {"id": "$id", "processing_time": "$time", "order_status_id": "30"}),
  );
  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<bool> cancelOrder(id, reason) async {
  print('id => $id reason => $reason');
  Uri uri = Uri.parse(base_url + 'api/orders/$id');

  // Uri uri = Uri.parse(base_url + 'api/orders/$id');
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return false;
  }
  Map<String, dynamic> _queryParams = {};
  _queryParams['api_token'] = _user.apiToken;
  uri = uri.replace(queryParameters: _queryParams);

  final client = new http.Client();
  final response = await client.put(
    uri,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json
        .encode({"id": "$id", "reason": "$reason", "order_status_id": "120"}),
  );
  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<Order> addOrder(Order order, Payment payment) async {
  User _user = userRepo.currentUser.value;
  if (_user.apiToken == null) {
    return new Order();
  }
  CreditCard _creditCard = await userRepo.getCreditCard();
  order.user = null;
  order.payment = payment;
  print('+++++++++++++++++++++order++++++++++++++++++++++++++++');
  print(order.toMap());
  print('+++++++++++++++++++++++order++++++++++++++++++++++++++');

  final String _apiToken = 'api_token=${_user.apiToken}';
  final String url = api_base_url_ + 'orders?$_apiToken';
  final client = new http.Client();
  Map params = order.toMap();
  params.addAll(_creditCard.toMap());
  print('++++++++++++++++++++++++Url+++++++++++++++++++++++++');
  print(url);
  print('+++++++++++++++++++++++++++++++++++++++++++++++++');
  final response = await client.post(
    Uri.parse(url),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(params),
  );
  print(response.body);
  print(response.statusCode);
  return Order.fromJSON(json.decode(response.body)['data']);
}
