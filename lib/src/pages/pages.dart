import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_owner/src/helpers/sabek_icons.dart';
import 'details.dart';
import 'foods.dart';
import 'order_notifications.dart';

import '../../generated/l10n.dart';
import '../elements/DrawerWidget.dart';
import '../models/route_argument.dart';
import 'messages.dart';
import 'orders.dart';


// ignore: must_be_immutable
class PagesTestWidget extends StatefulWidget {
  dynamic currentTab;
  DateTime? currentBackPressTime;
  RouteArgument?  routeArgument;
  Widget currentPage = OrdersWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesTestWidget({
    Key? key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesTestWidgetState createState() {
    return _PagesTestWidgetState();
  }
}

class _PagesTestWidgetState extends State<PagesTestWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesTestWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem; // == 3 ? 1 : tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = DetailsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = FoodsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      case 2:
        widget.currentPage = OrderNotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
        break;
        case 3:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = MessagesWidget(parentScaffoldKey: widget.scaffoldKey); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            print(i);
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(SabekIcons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: new Icon(SabekIcons.fast_food),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(SabekIcons.compass),
                label: '',
            ),
            BottomNavigationBarItem(
              icon: new Icon(SabekIcons.list),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: new Icon(SabekIcons.messenger),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (widget.currentBackPressTime == null || now.difference(widget.currentBackPressTime!) > Duration(seconds: 2)) {
      widget.currentBackPressTime = now;
      Fluttertoast.showToast(msg: S.of(context).tapBackAgainToLeave);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
