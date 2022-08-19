import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/repository/restaurant_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/credit_card.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class SettingsController extends ControllerMVC {
  CreditCard creditCard = new CreditCard();
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  User user = new User();
  SettingsController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForRestaurant();
  }
  void listenForRestaurant({String? message}) async {
    getRestaurantByUser().then((value) {
      setState(() {
        user = value!;
      });
    });
  }
  void updatePass(User user) async {
    repository.updatePassword(user).then((value) {
      if(value) {
        setState(() {});
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S
              .of(state!.context)
              .change_password_successfully),
        ));
      }else scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S
            .of(state!.context)
            .the_current_password_error),
      ));
    });
  }
  void updateNotificationsState(notificationsState) {
    try {
      repository.updateNotificationState(notificationsState).then((v) {
        setState(() {});
      });
    } catch (e) {
      ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
        content: Text('حدث خطأ ما !'),
      ));
    }
  }
  void update(User user) async {
    user.device_token = null;
    repository.update(user).then((value) {
      setState(() {
        //this.favorite = value;
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).profile_settings_updated_successfully),
      ));
    });
  }

  void updateCreditCard(CreditCard creditCard) {
    repository.setCreditCard(creditCard).then((value) {
      setState(() {});
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).payment_settings_updated_successfully),
      ));
    });
  }

  void listenForUser() async {
    creditCard = await repository.getCreditCard();
    setState(() {});
  }

  Future<void> refreshSettings() async {
    creditCard = new CreditCard();
  }
}
