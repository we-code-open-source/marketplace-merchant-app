
import 'package:food_delivery_owner/src/models/distance.dart';

import '../helpers/custom_trace.dart';
import '../models/media.dart';
import 'user.dart';

class Restaurant {
  String? id;
  String? name;
  Media? image;
  String? rate;
  String? address;
  String? description;
  String? phone;
  String? mobile;
  String? information;
  var deliveryFee;
  double? adminCommission;
  double? defaultTax;
  String? latitude;
  String? longitude;
  bool? closed;
  bool? open;
  bool? featured;
  bool? privateDrivers;
  bool? availableForDelivery;
  String? delivery_price_type;
  double? deliveryRange;
  List<User>? users;
  DistanceGoogle? distanceGoogle;

  Restaurant();

  Restaurant.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      description = jsonMap['description'];
      address = jsonMap['address'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      phone = jsonMap['phone'];
      mobile = jsonMap['mobile'];
      information = jsonMap['information'];
      adminCommission = jsonMap['admin_commission'] != null ? jsonMap['admin_commission'].toDouble() : 0.0;
      deliveryFee = jsonMap['delivery_fee'] ?? null;
      deliveryRange = jsonMap['delivery_range'] != null ? jsonMap['delivery_range'].toDouble() : 0.0;
      delivery_price_type = jsonMap['delivery_price_type'];
      defaultTax = jsonMap['default_tax'] != null ? jsonMap['default_tax'].toDouble() : 0.0;
      closed = jsonMap['closed'] ?? false;
      open = !closed!;
      privateDrivers = jsonMap['private_drivers'] ?? false;
      availableForDelivery = jsonMap['available_for_delivery'] ?? false;
      featured = jsonMap['featured'] ?? false;
      rate = jsonMap['rate'] ?? '0';
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      distanceGoogle = jsonMap['distance'] != null
          ? new DistanceGoogle.fromJson(jsonMap['distance'])
          : null;
      users = jsonMap['users'] != null && (jsonMap['users'] as List).length > 0
          ? List.from(jsonMap['users']).map((element) => User.fromJSON(element)).toSet().toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      image = new Media();
      rate = '0';
      deliveryFee = 0.0;
      adminCommission = 0.0;
      deliveryRange = 0.0;
      address = '';
      description = '';
      phone = '';
      mobile = '';
      defaultTax = 0.0;
      information = '';
      latitude = '0';
      longitude = '0';
      delivery_price_type = '';
      closed = false;
      privateDrivers = false;
      featured = false;
      availableForDelivery = false;
      distanceGoogle = new DistanceGoogle();
      users = [];
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
  Map<String, dynamic> toMapUpdate() {
    return {
      'id': id,
      'name': name,
      'information': information,
      'description': description,
    };
  }
  Map<String, dynamic> toMapStatus() {
    return {
      'id': id,
      'closed': closed,
      'name': name,
      'information': information,
      'description': description,
      'phone': phone,
      'mobile': mobile,
      'available_for_delivery': availableForDelivery,
    };
  }
  @override
  String toString() {
    return 'Restaurant{id: $id, name: $name, image: $image, rate: $rate, address: $address, description: $description, phone: $phone, mobile: $mobile, information: $information, deliveryFee: $deliveryFee, adminCommission: $adminCommission, defaultTax: $defaultTax, latitude: $latitude, longitude: $longitude, closed: $closed, featured: $featured,availableForDelivery: $availableForDelivery, deliveryRange: $deliveryRange, distance: $distanceGoogle,delivery_price_type: $delivery_price_type}';
  }
}
