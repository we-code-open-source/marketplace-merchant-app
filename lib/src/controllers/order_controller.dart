import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/route_argument.dart';
import '../models/statistic.dart';
import '../models/user.dart';
import '../repository/dashboard_repository.dart';
import '../repository/order_repository.dart';
import '../repository/user_repository.dart';

class OrderController extends ControllerMVC {
  Order order = new Order();
  List<Order> orders = <Order>[];
  List<OrderStatus> orderStatuses = <OrderStatus>[];
  List<User> drivers = <User>[];
  List<String>? selectedStatuses;
  Statistics statistics = new Statistics();
  GlobalKey<ScaffoldState>? scaffoldKey;
  Stream<QuerySnapshot>? OrderNoti;
  OverlayEntry? loader;
  var offset = 20;
  bool canFetchMore = true;
  bool isLoading = false;
  String? selected;
  OrderController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  onChangeDropdownTypeItem(String selected) {
    selected = selected;
  }
  listenForOrderNotification() async {
    getOrderNotification().then((snapshots) {
      setState(() {
        OrderNoti = snapshots;
      });
    });
  }

  void acceptanceOrderByRes(id) async {
    loader = Helper.overlayLoader(state!.context);
    Overlay.of(state!.context)!.insert(loader!);
    acceptOrder(id,order.reason).then((v) {
      if (v) {
        Helper.hideLoader(loader!);
        Navigator.of(state!.context).pushNamed('/OrderDetails',
            arguments: RouteArgument(id: id.toString()));
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text("لقد قمت باستلام الطلبية"),
        ));
      } else {
        loader!.remove();
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text("للاسف لقد تم الغاء طلبية"),
        ));
      }
    });
  }

  void listenForStatistics({String? message}) async {
    getStatistics()
        .then((_statistics) {
      setState(() => statistics = _statistics!);
    });
  }

  void listenForOrderStatus({String? message, bool? insertAll}) async {
    final Stream<OrderStatus> stream = await getOrderStatuses();
    stream.listen((OrderStatus _orderStatus) {
      if (!order.showOrderStateWithOutCancel(_orderStatus))
        setState(() {
          orderStatuses.add(_orderStatus);
        });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (insertAll != null &&! insertAll) {
        orderStatuses.insert(
            0,
            new OrderStatus.fromJSON({
              'id': '0',
              'status': state!.context != null ? S.of(state!.context).all : ''
            }));
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForOrderStatus1({String? message, bool? insertAll}) async {
    final Stream<OrderStatus> stream = await getOrderStatuses1();
    stream.listen((OrderStatus _orderStatus) {
      setState(() {
        orderStatuses.add(_orderStatus);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (insertAll != null &&! insertAll) {
        orderStatuses.insert(
            0,
            new OrderStatus.fromJSON({
              'id': '0',
              'status': state!.context != null ? S.of(state!.context).all : ''
            }));
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForDrivers({String? message}) async {
    final Stream<User> stream = await getDriversOfRestaurant(
        this.order.foodOrders![0].food?.restaurant?.id ?? '0');
    stream.listen((User _driver) {
      setState(() {
        drivers.add(_driver);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForOrders({statusesIds, String? message}) async {
    final Stream<Order> stream = await getOrders(statusesIds: statusesIds);
    stream.listen((Order _order) {
      setState(() {
        orders.add(_order);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForOrder(
      {String? id, String? message, bool withDrivers = false}) async {
    isLoading = true;
    final Stream<Order> stream = await getOrder(id);
    stream.listen((Order _order) {
      setState(() => order = _order);
    }, onError: (a) {
      print(a);
    }, onDone: () {
      selectedStatuses = [order.orderStatus!.id!];
      isLoading = false;

      if (withDrivers) {
        listenForDrivers();
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> selectStatus(List<String> statusesIds) async {
    orders.clear();
    listenForOrders(statusesIds: statusesIds);
  }

  Future<void> refreshOrder() async {
    listenForOrder(
        id: order.id!, message: S.of(state!.context).order_refreshed_successfuly);
  }

  Future<void> refreshOrders() async {
    orders.clear();
    statistics=new Statistics();
    listenForStatistics();
    listenForOrders(
        statusesIds: selectedStatuses,
        message: S.of(state!.context).order_refreshed_successfuly);
  }

  void doUpdateOrder(Order _order) async {
    updateOrder(_order).then((value) {
      Navigator.of(state!.context)
          .pushNamed('/OrderDetails', arguments: RouteArgument(id: order.id));
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).thisOrderUpdatedSuccessfully),
      ));
    });
  }

  void doCancelOrder(id) {

    loader = Helper.overlayLoader(state!.context);
    Overlay.of(state!.context)!.insert(loader!);
    cancelOrder(id,order.reason).then((value) {
      if (value) {
        Helper.hideLoader(loader!);
        Navigator.of(state!.context).pushNamed('/OrderDetails',
            arguments: RouteArgument(id: id));
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text("لقد قمت برفض هذه الطلبية"),
        ));
      } else {
        loader!.remove();
        ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
          content: Text("للاسف لم يتم الغاء طلبية"),
        ));
      }
    });
  }

  void loadMoreOrders() async {
    print("+++");
    if (isLoading == false && offset <= orders.length) {
      isLoading = true;
      final Stream<Order> stream =
          await getOrders(statusesIds: selectedStatuses, offset: offset);
      stream.listen((Order _order) {
        setState(() => orders.add(_order));
      }, onError: (a) {
        print(a);
      }, onDone: () {
        isLoading = false;
        offset += 20;
      });
    }
  }
}
