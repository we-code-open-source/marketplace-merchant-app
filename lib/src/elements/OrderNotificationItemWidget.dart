
import '../models/route_argument.dart';
import '../../generated/l10n.dart';

import '../models/order_noti.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderNotificationItemWidget extends StatelessWidget {
  final OrderNotification? orderNotification;
  final VoidCallback? onAcceptanceOrder;
  final VoidCallback? onCancelOrder;
  OrderNotificationItemWidget(
      {Key? key,
      this.orderNotification,
      this.onAcceptanceOrder,
      this.onCancelOrder,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:()=> Navigator.of(context).pushNamed('/OrderDetails', arguments: RouteArgument(id: orderNotification!.id.toString()))
      ,
    child:Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context)
          .scaffoldBackgroundColor
          .withOpacity(0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).focusColor.withOpacity(0.7),
                          Theme.of(context).focusColor.withOpacity(0.05),
                        ])),
                child: Icon(
                  Icons.notifications,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 40,
                ),
              ),
              Positioned(
                right: -30,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                top: -50,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "?????? ?????????????? #${orderNotification!.id}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(TextStyle(fontWeight: FontWeight.w300)),
                ),
                Text(
                  "?????????? ??????????????: ${orderNotification!.total}",
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  timeago.format(
                      DateTime.fromMillisecondsSinceEpoch(orderNotification!.createdAt! * 1000),
                      locale: 'ar'),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 4, left: 4, top: 8, bottom: 8),
                        child: Text(
                          S.of(context).Acceptance,
                          style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onPressed: () {
                        onAcceptanceOrder!();
                       // Navigator.of(context).pushNamed('/OrderDetails', arguments: RouteArgument(id: orderNotification.id.toString()));

                      },
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 4, left: 4, top: 8, bottom: 8),
                        child: Text(
                          S.of(context).reject,
                          style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onPressed: () {
                        onCancelOrder!();
                       // Navigator.of(context).pushNamed('/OrderDetails', arguments: RouteArgument(id: orderNotification.id.toString()));

                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
