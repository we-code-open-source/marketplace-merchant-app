import 'package:food_delivery_owner/src/models/restaurant.dart';

import '../helpers/custom_trace.dart';
import '../models/media.dart';

enum UserState { available, away, busy }

class User {
  String? id;
  String? restaurantId;
  String? name;
  String? email;
  String? password;
  String? newPassword;
  String? apiToken;
  String? device_token;
  String? phone;
  String? token;
  String? address;
  String? bio;
  Media? image;
  Restaurant? restaurant;
  // used for indicate if client logged in or not
  bool? auth;
  bool? enableNotifications;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      apiToken = jsonMap['api_token'];
      device_token = jsonMap['device_token'];
      enableNotifications = jsonMap['enable_notifications']==1?true:false;
      phone=jsonMap['phone_number'] != null ? jsonMap['phone_number'] : '';
      try {
        address = jsonMap['custom_fields']['address']['view'];
      } catch (e) {
        address = "";
      }
      try {
        bio = jsonMap['custom_fields']['bio']['view'];
      } catch (e) {
        bio = "";
      }
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      restaurant = jsonMap['restaurants'] != null && (jsonMap['restaurants'] as List).length > 0 ? Restaurant.fromJSON(jsonMap['restaurants'][0]) : new Restaurant();
    } catch (e) {
      id = '';
      name = '';
      image = new Media();
      bio = '';
      restaurant = new Restaurant();
      apiToken = '';
      address = '';
      address = '';
      phone = '';
      email = '';
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }
  Map toPasswordMap() {
    var map = new Map<String, dynamic>();
    map["password"] = password;
    map["new_password"] = newPassword;

    return map;
  }
  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (device_token != null) {
      map["device_token"] = device_token;
    }
    map["phone_number"] = phone;
    map["token"] = token;
    map["address"] = address;
    map["bio"] = bio;
    map["media"] = image?.toMap();
    map["restaurants"] = restaurant?.toMap();
    return map;
  }
  Map toAddUserMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["phone_number"] = phone;
    map["restaurant_id"] = restaurantId;
    return map;
  }
  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = image?.thumb;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    return address != null && address != '' && phone != null && phone != '';
  }
}
