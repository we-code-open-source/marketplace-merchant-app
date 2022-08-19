import '../helpers/custom_trace.dart';

class DistancePrice {
  String? id;
  double? price;
  double? from;
  double? to;
  int? is_available;
  String? restaurant_id;

  DistancePrice();

  DistancePrice.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      from = jsonMap['from'] != null ? jsonMap['from'].toDouble() : 0.0;
      to = jsonMap['to'] != null ? jsonMap['to'].toDouble() : 0.0;
      is_available = jsonMap['is_available'] ?? 0;
    } catch (e) {
      id = '';
      price = 0.0;
      from = 0.0;
      to = 0.0;
      is_available = 0;
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }
}
