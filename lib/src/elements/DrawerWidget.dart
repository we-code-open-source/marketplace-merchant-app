import 'dart:io';

import 'package:flutter/material.dart';
import '../helpers/sabek_icons.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/profile_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  //ProfileController? _con;

  _DrawerWidgetState() : super(ProfileController()) {
    //_con = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: currentUser.value.apiToken == null
          ? CircularLoadingWidget(height: 500)
          : ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 0);
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      currentUser.value.restaurant!.name??'',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    accountEmail: Text(
                      currentUser.value.email!,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: NetworkImage(currentUser.value.restaurant!.image!.thumb!),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 1);
                  },
                  leading: Icon(
                    SabekIcons.fast_food,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).foods,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 3);
                  },
                  leading: Icon(
                    SabekIcons.list,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).orders,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 4);
                  },
                  leading: Icon(
                    SabekIcons.messenger,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).messages,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Notifications');
                  },
                  leading: Icon(
                    SabekIcons.bell1,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).notifications,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Extra');
                  },
                  leading: Icon(
                    SabekIcons.food_serving,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).extras,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/AddUser');
                  },
                  leading: Icon(
                    SabekIcons.user1,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).addUser,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/addOrder');
                  },
                  leading: Icon(
                    SabekIcons.fast_food,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).addOrder,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    S.of(context).application_preferences,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Icon(
                    Icons.remove,
                    color: Theme.of(context).focusColor.withOpacity(0.3),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Help');
                  },
                  leading: Icon(
                    SabekIcons.information,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).help__support,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Settings');
                  },
                  leading: Icon(
                    SabekIcons.settings,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).settings,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Languages');
                  },
                  leading: Icon(
                    SabekIcons.translate,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).languages,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    if (Theme.of(context).brightness == Brightness.dark) {
                      setBrightness(Brightness.light);
                      setting.value.brightness.value = Brightness.light;
                    } else {
                      setting.value.brightness.value = Brightness.dark;
                      setBrightness(Brightness.dark);
                    }
                    setting.notifyListeners();
                  },
                  leading: Icon(
                    SabekIcons.night_mode,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    Theme.of(context).brightness == Brightness.dark ? S.of(context).light_mode : S.of(context).dark_mode,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    logout().then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                    });
                  },
                  leading: Icon(
                    SabekIcons.logout,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    S.of(context).log_out,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                setting.value.enableVersion!
                    ? ListTile(
                        dense: true,
                        title: Text(
                          Platform.isIOS
                              ?S.of(context).version + " " + setting.value.appVersionIOS!
                          :S.of(context).version + " " + setting.value.appVersionAndroid!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        trailing: Icon(
                          Icons.remove,
                          color: Theme.of(context).focusColor.withOpacity(0.3),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
    );
  }
}
