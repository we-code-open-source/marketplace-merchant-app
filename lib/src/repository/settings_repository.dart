import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_owner/src/helpers/const.dart';
import 'package:food_delivery_owner/src/models/route_argument.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/custom_trace.dart';
import '../models/address.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<Address> myAddress = new ValueNotifier(new Address());
final navigatorKey = GlobalKey<NavigatorState>();
//LocationData locationData;
const APP_STORE_URL =
    'https://apps.apple.com/gb/app/sabek-merchant/id1600324102';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=ly.sabek.owner';

Future<Setting> initSettings() async {
  Setting _setting;
  final String url =
      api_base_url_  + 'settings';
  try {
    final response = await http
        .get(Uri.parse(url), headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200 &&
        response.headers.containsValue('application/json')) {
      if (json.decode(response.body)['data'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'settings', json.encode(json.decode(response.body)['data']));
        _setting = Setting.fromJSON(json.decode(response.body)['data']);
        if (prefs.containsKey('language')) {
          _setting.mobileLanguage!.value = Locale(prefs.get('language').toString() , '');
        }
        _setting.brightness.value = prefs.getBool('isDark') ?? false
            ? Brightness.dark
            : Brightness.light;
        setting.value = _setting;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    } else {
      print(CustomTrace(StackTrace.current, message: response.body).toString());
    }
  } catch (e) {
    print(CustomTrace(StackTrace.current, message: url).toString());
    return Setting.fromJSON({});
  }
  return setting.value;
}

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (brightness == Brightness.dark) {
    prefs.setBool("isDark", true);
    brightness = Brightness.dark;
  } else {
    prefs.setBool("isDark", false);
    brightness = Brightness.light;
  }
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language').toString() ;
  }
  return defaultLanguage;
}

Future<void> saveMessageId(String messageId) async {
  if (messageId != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('google.message_id', messageId);
  }
}

Future<String> getMessageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('google.message_id').toString() ;
}

versionCheck(context) async {
  //Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
  print("currentVersion:$currentVersion");
  print(
      "currentVersion:${double.tryParse(setting.value.appVersionAndroid!.replaceAll(".", ""))}");
  Platform.isIOS
      ? {
          if (double.tryParse(setting.value.appVersionIOS!.replaceAll(".", ""))! >
              currentVersion)
            {
              if (setting.value.forceUpdateIOS!)
                Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                    arguments: RouteArgument(id: ''))
              else
                {
                  Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                      arguments: RouteArgument(id: '0'))
                }
            }
          else
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0)
        }
      : {
          if (double.tryParse(
                  setting.value.appVersionAndroid!.replaceAll(".", ""))! >
              currentVersion)
            {
              if (setting.value.forceUpdateAndroid!)
                Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                    arguments: RouteArgument(id: ''))
              else
                {
                  Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                      arguments: RouteArgument(id: '0'))
                }
            }
          else
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0)
        };
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
