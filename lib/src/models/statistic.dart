import '../helpers/custom_trace.dart';

class Statistics {
  Settlements? settlements;
  Settlements? availabelOrdersForSettlement;

  Statistics();

  Statistics.fromJson(Map<String, dynamic> json) {
    settlements = json['settlements'] != null
        ? new Settlements.fromJSON(json['settlements'])
        : null;
    availabelOrdersForSettlement =
    json['availabel_orders_for_settlement'] != null
        ? new Settlements.fromJSON(
        json['availabel_orders_for_settlement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.settlements != null) {
      data['settlements'] = this.settlements!.toMap();
    }
    if (this.availabelOrdersForSettlement != null) {
      data['availabel_orders_for_settlement'] =
          this.availabelOrdersForSettlement!.toMap();
    }
    return data;
  }
}

class Settlements {
  String? amount;
  String? manager_fee;
  String? count;

  Settlements();

  Settlements.fromJSON(Map<String, dynamic> jsonMap) {
  try {
  amount = jsonMap['amount'] != null ? jsonMap['amount'].toString() : '0.0';
  manager_fee = jsonMap['manager_fee'] != null ? jsonMap['manager_fee'].toString() : '0.0';
  count = jsonMap['count'] != null ? jsonMap['count'].toString() : '0';
  } catch (e) {
  print(CustomTrace(StackTrace.current, message: e.toString()));
  }
  }

  Map<String, dynamic>  toMap() {
  var map = new Map<String, dynamic>();
  map['amount'] = this.amount;
  map['delivery_fee'] = this.manager_fee;
  map['count'] = this.count;
  return map;
  }


  }