import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FoodOrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/conversation.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';
import '../models/user.dart';

class OrderWidget extends StatefulWidget {
  final RouteArgument?  routeArgument;

  OrderWidget({Key? key, this.routeArgument}) : super(key: key);

  @override
  _OrderWidgetState createState() {
    return _OrderWidgetState();
  }
}

class _OrderWidgetState extends StateMVC<OrderWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _tabIndex = 0;
  OrderController? _con;

  _OrderWidgetState() : super(OrderController()) {
    _con = controller as OrderController?;
  }

  @override
  void initState() {
    _con!.listenForOrder(id: widget.routeArgument!.id!);
    _tabController = TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController!.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar: _con!.isLoading
          ? SizedBox(height: 0,)
          :Container(
              height: 190 ,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            S.of(context).subtotal,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Helper.getPrice(Helper.getSubTotalOrdersPrice(_con!.order), context, style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            S.of(context).delivery_fee,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Helper.getPrice(_con!.order.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                    Divider(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            S.of(context).total,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Helper.getPrice(Helper.getTotalOrdersPrice(_con!.order), context, style: Theme.of(context).textTheme.headline6)
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
      body: _con!.isLoading
          ? CircularLoadingWidget(height: 500)
          : CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    icon: new Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
                    onPressed: () {
                      Navigator.of(context).pop();

                    }),
                centerTitle: true,
                title: Text(
                  S.of(context).order_details,
                  style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
                ),
                actions: <Widget>[
                  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
                ],
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 238,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(top: 95, bottom: 65),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).order_id + ": #${_con!.order.id}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                    Text(
                                      _con!.order.orderStatus!.status!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm', 'en').format(_con!.order.dateTime!),
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Helper.getPrice(Helper.getTotalOrdersPrice(_con!.order), context, style: Theme.of(context).textTheme.headline4),
                                  Text(
                                     S.of(context).cash_on_delivery,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    S.of(context).items + ':' + _con!.order.foodOrders!.length.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                bottom: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(horizontal: 10),
                    unselectedLabelColor: Theme.of(context).accentColor,
                    labelColor: Theme.of(context).primaryColor,
                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50), border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(S.of(context).ordered_foods),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50), border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.2), width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(S.of(context).customer),
                          ),
                        ),
                      ),
                    ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Offstage(
                    offstage: 0 != _tabIndex,
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 20, bottom: 50),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con!.order.foodOrders?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        return FoodOrderItemWidget(heroTag: 'my_orders', order: _con!.order, foodOrder: _con!.order.foodOrders!.elementAt(index));
                      },
                    ),
                  ),
                  Offstage(
                    offstage: 1 != _tabIndex,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).fullName,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      _con!.order.user!.name??_con!.order.unregisteredCustomer!.name!,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 42,
                                height: 42,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  disabledColor: Theme.of(context).focusColor.withOpacity(0.4),
                                  onPressed: () {
                                    // Restaurant _restaurant = _con!.order.foodOrders[0].food.restaurant;
                                    // List<User> _users = _restaurant.users
                                    //     .map((e) {
                                    //       e.image = _restaurant.image;
                                    //       return e;
                                    //     })
                                    //     .toSet()
                                    //     .toList();
                                    // _users.insert(0, _con!.order.user);
                                    // Navigator.of(context).pushNamed('/Chat', arguments: RouteArgument(param: new Conversation(_users, name: _restaurant.name)));
                                  },
                                  //onPressed: () {
//                                    Navigator.of(context).pushNamed('/Profile',
//                                        arguments: new RouteArgument(param: _con!.order.deliveryAddress));
                                  //},
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context).primaryColor,
                                    size: 24,
                                  ),
                                  color: Theme.of(context).accentColor.withOpacity(0.9),
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).deliveryAddress,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      _con!.order.deliveryAddress?.address ?? _con!.order.deliveryAdd!.address!,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 42,
                                height: 42,
                               child: FlatButton(
                                 padding: EdgeInsets.all(0),
                                 disabledColor: Theme.of(context).focusColor.withOpacity(0.4),
                                 onPressed: () {
                                   launch('https://www.google.com/maps/dir/?api=1&destination=' +
                                       _con!.order.deliveryAddress!
                                           .latitude
                                           .toString() +
                                       ',' +
                                       _con!.order.deliveryAddress!
                                           .longitude
                                           .toString() +
                                       '&travelmode=driving&dir_action=navigate');
                                 },
                                 child: Icon(
                                   Icons.directions,
                                   color: Theme.of(context).primaryColor,
                                   size: 24,
                                 ),
                                 color: Theme.of(context).accentColor.withOpacity(0.9),
                                 shape: StadiumBorder(),
                               ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).phoneNumber,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      '0${_con!.order.user!.phone}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 42,
                                height: 42,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    launch("tel:${_con!.order.user!.phone}");
                                  },
                                  child: Icon(
                                    Icons.call,
                                    color: Theme.of(context).primaryColor,
                                    size: 24,
                                  ),
                                  color: Theme.of(context).accentColor.withOpacity(0.9),
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ]),
    );
  }
}
