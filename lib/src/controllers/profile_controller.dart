import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/statistic.dart';
import '../models/user.dart';
import '../repository/dashboard_repository.dart';
import '../repository/user_repository.dart';

class ProfileController extends ControllerMVC {
  User user = new User();
  Restaurant restaurant = new Restaurant();
  GlobalKey<ScaffoldState>? scaffoldKey;
  Statistics statistics = new Statistics();

  ProfileController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForUser();
  }

  void listenForUser() {
    getCurrentUser().then((_user) {
      setState(() {
        user = _user;
      });
    });
  }

  void listenForStatistics({String? message}) async {
    getStatistics()
        .then((_statistics) => setState(() => statistics = _statistics!));
  }

  Future<void> refreshProfile() async {
    statistics = new Statistics();
    user = new User();
    listenForStatistics();
    listenForUser();
  }
}
