import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../controllers/order_controller.dart';
import '../models/order_noti.dart';
import '../elements/OrderNotificationItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;
import '../../generated/l10n.dart';
import '../elements/DrawerWidget.dart';

class OrderNotificationsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  OrderNotificationsWidget({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrderNotificationsWidgetState createState() =>
      _OrderNotificationsWidgetState();
}

class _OrderNotificationsWidgetState
    extends StateMVC<OrderNotificationsWidget> {
  OrderController? _con;

  _OrderNotificationsWidgetState() : super(OrderController()) {
    _con = controller as OrderController?;
  }

  @override
  void initState() {
    _con!.listenForOrderNotification();

    super.initState();
  }

  Widget conversationsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _con!.OrderNoti,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _docs = snapshot.data!.docs;
          print('length : ${_docs.length}');
          print('length : ${_docs.length}');
          return _docs.length == 0
              ? EmptyOrdersWidget()
              : ListView.separated(
                  itemCount: _docs.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 7);
                  },
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    OrderNotification orderNotification =
                        OrderNotification.fromJson(_docs[index].data() as Map<String, dynamic>);
                    print(orderNotification.order_status_id == 20);
                    return orderNotification.order_status_id == 20
                        ? OrderNotificationItemWidget(
                            orderNotification: orderNotification,
                            onAcceptanceOrder: () {
                              displayTextInputDialog(
                                  context: context,
                                  orderId: orderNotification.id!,
                                  accept: true);
                            },
                            onCancelOrder: () {
                              displayTextInputDialog(
                                  context: context,
                                  orderId: orderNotification.id!);
                            },
                          )
                        : SizedBox();
                  });
        } else {
          return EmptyOrdersWidget();
        }
      },
    );
  }

  Future<void> displayTextInputDialog(
      {BuildContext? context, bool accept = false, String? orderId}) async {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Text(
                accept ? S.of(context).processing_time : S.of(context).reason),
            content:
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                // labelText: labelText,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
              ),
              value: _con!.selected,
              items: accept?_con!.order.time!.map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: new Text(item),
                  );
                },
              ).toList():_con!.order.reasonCancel!.map(
                    (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: new Text(item),
                  );
                },
              ).toList(),
              isExpanded: true,

              hint: Text(accept?'الرجاء تحديد وقت التحضير':'الرجاء تحديد سبب الرفض'),
              onChanged: (String? value) {
                _con!.order.reason=value;
                 _con!.onChangeDropdownTypeItem(value!);
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    textStyle:
                        TextStyle(color: Theme.of(context).accentColor)),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                    textStyle:
                        TextStyle(color: Theme.of(context).accentColor)),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
                  child: Text(
                    S.of(context).Ok,
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                ),
                onPressed: () {
                  if(_con!.order.reason!=null)
                  {accept
                      ? _con!.acceptanceOrderByRes(orderId)
                      : _con!.doCancelOrder(orderId);
                  Navigator.of(context).pop();
                  }else ScaffoldMessenger.of(_con!.scaffoldKey!.currentContext!).showSnackBar(SnackBar(
                    content: Text(accept?'الرجاء تحديد وقت التحضير':'الرجاء تحديد سبب الرفض'),
                  ));
                  },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      drawer: DrawerWidget(),
       appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _con!.scaffoldKey!.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).orders,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: ListView(
        primary: false,
        children: <Widget>[
          conversationsList(),
        ],
      ),
    );
  }
}
