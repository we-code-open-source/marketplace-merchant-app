import 'package:food_delivery_owner/src/models/extra_group.dart';

import '../helpers/custom_trace.dart';
import '../models/media.dart';

class Extra {
  String? id;
  String? extraGroupId;
  String? restaurantId;
  String? name;
  double? price;
  Media? image;
  String? description;
  bool? checked;
  ExtraGroup? extraGroup;

  Extra();

  Extra.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      extraGroupId = jsonMap['extra_group_id'] != null ? jsonMap['extra_group_id'].toString() : '0';
      restaurantId = jsonMap['restaurant_id'] != null ? jsonMap['restaurant_id'].toString() : '0';
      extraGroup = jsonMap['extragroup'] != null ? ExtraGroup.fromJSON(jsonMap['extragroup']) : ExtraGroup.fromJSON({});
      name = jsonMap['name'].toString();
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0;
      description = jsonMap['description'];
      checked = jsonMap['checked'];
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
    } catch (e) {
      id = '';
      extraGroupId = '0';
      name = '';
      price = 0.0;
      description = '';
      checked = false;
      image = new Media();
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["price"] = price;
    map["description"] = description;
    map["extra_group_id"] = extraGroupId;
    map["restaurant_id"] = restaurantId;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
