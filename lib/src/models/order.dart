import '../helpers/custom_trace.dart';
import '../models/address.dart';
import '../models/food_order.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../models/user.dart';

class Order {
  String? id;
  List<FoodOrder>? foodOrders;
  UnregisteredCustomer? unregisteredCustomer;
  DeliveryAddress? deliveryAdd;
  OrderStatus? orderStatus;
  double? tax;
  double? deliveryFee;
  double? restaurantDeliveryFee;
  String? hint;
  String? reason;
  int? processingTime;
  bool? active;
  DateTime? dateTime;
  User? user;
  User? driver;
  Payment? payment;
  Address? deliveryAddress;
  List<String>? time = ['10', '15', '20', '25', '30', '40', '50', '60'];
  List<String>? reasonCancel = [
    'عدم توفر صنف',
    'عدم توفر جميع الاصناف',
    'لا يمكن تحضير طلبك الان'
  ];

  Order();

  Order.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      tax = jsonMap['tax'] != null ? jsonMap['tax'].toDouble() : 0.0;
      processingTime = jsonMap['processing_time'] != null
          ? jsonMap['processing_time']
          : null;
      deliveryFee = jsonMap['delivery_fee'] != null
          ? jsonMap['delivery_fee'].toDouble()
          : 0.0;
      restaurantDeliveryFee = jsonMap['restaurant_delivery_fee'] != null
          ? jsonMap['restaurant_delivery_fee'].toDouble()
          : 0.0;
      hint = jsonMap['hint'] != null ? jsonMap['hint'].toString() : '';
      reason = jsonMap['reason'] != null ? jsonMap['reason'].toString() : '';
      active = jsonMap['active'] ?? false;
      orderStatus = jsonMap['order_status'] != null
          ? OrderStatus.fromJSON(jsonMap['order_status'])
          : OrderStatus.fromJSON({});
      dateTime = DateTime.parse(jsonMap['updated_at']);
      user = jsonMap['user'] != null
          ? User.fromJSON(jsonMap['user'])
          : User.fromJSON({});
      unregisteredCustomer = jsonMap['unregistered_customer'] != null
          ? new UnregisteredCustomer.fromJson(jsonMap['unregistered_customer'])
          : null;
      deliveryAdd = jsonMap['delivery_address'] != null
          ? new DeliveryAddress.fromJson(jsonMap['delivery_address'])
          : null;
      driver = jsonMap['driver'] != null
          ? User.fromJSON(jsonMap['driver'])
          : User.fromJSON({});
      // deliveryAddress = jsonMap['delivery_address'] != null ? Address.fromJSON(jsonMap['delivery_address']) : Address.fromJSON({});
      payment = jsonMap['payment'] != null
          ? Payment.fromJSON(jsonMap['payment'])
          : Payment.fromJSON({});
      foodOrders = jsonMap['food_orders'] != null
          ? List.from(jsonMap['food_orders'])
              .map((element) => FoodOrder.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      id = '';
      tax = 0.0;
      deliveryFee = 0.0;
      restaurantDeliveryFee = 0.0;
      hint = '';
      active = false;
      orderStatus = OrderStatus.fromJSON({});
      dateTime = DateTime(0);
      user = User.fromJSON({});
      unregisteredCustomer = UnregisteredCustomer.fromJson({});
      payment = Payment.fromJSON({});
      deliveryAdd = DeliveryAddress.fromJson({});
      deliveryAddress = Address.fromJSON({});
      foodOrders = [];
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_id"] = user?.id;
    map["order_status_id"] = orderStatus?.id;
    map["tax"] = tax;
    map['hint'] = hint;
    map["delivery_fee"] = deliveryFee;
    map["restaurant_delivery_fee"] = restaurantDeliveryFee;
    map["foods"] = foodOrders?.map((element) => element.toMap()).toList();
    map["payment"] = payment?.toMap();
    map['delivery_address'] = deliveryAdd?.toJson();
    map['unregistered_customer'] = unregisteredCustomer?.toJson();
    return map;
  }

  Map editableMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    if (orderStatus?.id != 'null') map["order_status_id"] = orderStatus?.id;
    if (driver?.id != 'null') map["driver_id"] = driver?.id;
    print(driver?.id);
    map['hint'] = hint;
    map['tax'] = tax;
    map["delivery_fee"] = deliveryFee;
    return map;
  }

  Map cancelMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["order_status_id"] = '120';
    map["active"] = false;
    return map;
  }

  Map acceptMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["order_status_id"] = '30';
    return map;
  }

  bool canCancelOrder() {
    return this.active == true &&
        this.orderStatus!.id == '1'; // 1 for order received status
  }

  bool canEditOrder() {
    return this.orderStatus!.key == 'order_received' ||
        this.orderStatus!.key == 'waiting_for_drivers' ||
        this.orderStatus!.key == 'waiting_for_restaurant' ||
        this.orderStatus!.key ==
            'driver_assigned'; // 1 for order received status
  }

  bool showOrderStateWithOutCancel(orderstatus) {
    return orderstatus.key == 'canceled_restaurant_did_not_accept' ||
        orderstatus.key == 'canceled_from_customer' ||
        orderstatus.key == 'canceled_no_drivers_available' ||
        orderstatus.key == 'canceled_from_restaurant' ||
        orderstatus.key == 'canceled_from_driver' ||
        orderstatus.key ==
            'canceled_from_company'; // 1 for order received status
  }
}

class UnregisteredCustomer {
  String? id;
  String? phone;
  String? name;

  UnregisteredCustomer({this.id, this.phone, this.name});

  UnregisteredCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}

class DeliveryAddress {
  String? address;
  double? latitude;
  double? longitude;

  DeliveryAddress({this.address, this.latitude, this.longitude});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
