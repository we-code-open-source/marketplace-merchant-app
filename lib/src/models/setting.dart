import 'package:flutter/material.dart';

import '../helpers/custom_trace.dart';

class Setting {
  String? appName = '';
  double? defaultTax;
  String? defaultCurrency;
  String? distanceUnit;
  bool? currencyRight = false;
  int? currencyDecimalDigits = 2;
  bool? payPalEnabled = true;
  bool? stripeEnabled = true;
  bool? razorPayEnabled = true;
  String? mainColor;
  String? mainDarkColor;
  String? secondColor;
  String? secondDarkColor;
  String? accentColor;
  String? accentDarkColor;
  String? scaffoldDarkColor;
  String? scaffoldColor;
  String? googleMapsKey;
  String? fcmKey;
  ValueNotifier<Locale>? mobileLanguage = new ValueNotifier(Locale('en', ''));
  String? appVersionAndroid;
  String? appVersionIOS;
  String? initial_price;
  String? price_per_minute;
  String? price_per_km;
  bool? enableVersion = true;
  bool? forceUpdateAndroid;
  bool? forceUpdateIOS;

  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      price_per_km = jsonMap['price_per_km'] ?? null;
      initial_price = jsonMap['initial_price'] ?? null;
      price_per_minute = jsonMap['price_per_minute'] ?? null;
      mainColor = jsonMap['main_color'] ?? null;
      mainDarkColor = jsonMap['main_dark_color'] ?? '';
      secondColor = jsonMap['second_color'] ?? '';
      secondDarkColor = jsonMap['second_dark_color'] ?? '';
      accentColor = jsonMap['accent_color'] ?? '';
      accentDarkColor = jsonMap['accent_dark_color'] ?? '';
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] ?? '';
      scaffoldColor = jsonMap['scaffold_color'] ?? '';
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      fcmKey = jsonMap['fcm_key'] ?? null;
      mobileLanguage!.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      appVersionAndroid = jsonMap['app_manager_version_android'] ?? '';
      appVersionIOS = jsonMap['app_manager_version_ios'] ?? '';
      forceUpdateAndroid = jsonMap['app_manager_force_update_android'] == null || jsonMap['app_manager_force_update_android'] == '0' ? false : true;
      forceUpdateIOS = jsonMap['app_manager_force_update_ios'] == null || jsonMap['app_manager_force_update_ios'] == '0' ? false : true;

      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      enableVersion = jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0' ? false : true;
      defaultTax = double.tryParse(jsonMap['default_tax']) ?? 0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency'] ?? '';
      currencyDecimalDigits = int.tryParse(jsonMap['default_currency_decimal_digits']) ?? 2;
      currencyRight = jsonMap['currency_right'] == null || jsonMap['currency_right'] == '0' ? false : true;
      payPalEnabled = jsonMap['enable_paypal'] == null || jsonMap['enable_paypal'] == '0' ? false : true;
      stripeEnabled = jsonMap['enable_stripe'] == null || jsonMap['enable_stripe'] == '0' ? false : true;
      razorPayEnabled = jsonMap['enable_razorpay'] == null || jsonMap['enable_razorpay'] == '0' ? false : true;
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    map["default_currency_decimal_digits"] = currencyDecimalDigits;
    map["currency_right"] = currencyRight;
    map["enable_paypal"] = payPalEnabled;
    map["enable_stripe"] = stripeEnabled;
    map["enable_razorpay"] = razorPayEnabled;
    map["mobile_language"] = mobileLanguage!.value.languageCode;
    return map;
  }
}
