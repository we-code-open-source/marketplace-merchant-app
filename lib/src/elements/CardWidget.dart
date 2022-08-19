import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/controllers/restaurant_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/restaurant.dart';

class CardWidget extends StatefulWidget {
  final Restaurant? restaurant;
  final String? heroTag;
  CardWidget({Key? key, this.restaurant,this.heroTag}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}
  class _CardWidgetState extends StateMVC<CardWidget> {
  RestaurantController? _con;

  _CardWidgetState() : super(RestaurantController()) {
  _con = controller as RestaurantController?;
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: widget.heroTag! + widget.restaurant!.id!,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: widget.restaurant!.image!.url!,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(color: widget.restaurant!.closed !? Colors.grey : Colors.green, borderRadius: BorderRadius.circular(24)),
                    child: widget.restaurant!.closed!
                        ? Text(
                            S.of(context).closed,
                            style: Theme.of(context).textTheme.caption!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                          )
                        : Text(
                            S.of(context).open,
                            style: Theme.of(context).textTheme.caption!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(color: widget.restaurant!.availableForDelivery! ? Colors.green : Colors.orange, borderRadius: BorderRadius.circular(24)),
                    child: widget.restaurant!.availableForDelivery!
                        ? Text(
                            S.of(context).delivery,
                            style: Theme.of(context).textTheme.caption!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                          )
                        : Text(
                            S.of(context).pickup,
                            style: Theme.of(context).textTheme.caption!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.restaurant!.name!,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Divider(),
                      Card(
                        child: SwitchListTile(
                          title:  Text(S.of(context).open),
                          value: !(widget.restaurant!.closed ?? true),
                          onChanged: (bool value) {
                            setState(() {
                              widget.restaurant!.closed = !value;
                              _con!.listenUpdateRestaurant(widget.restaurant);
                            });
                          },
                          secondary: const Icon(Icons.lightbulb_outline),
                        ),
                      ),
                      Divider(),
                      Text(
                        Helper.skipHtml(widget.restaurant!.description!),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: Helper.getStarsList(double.parse(widget.restaurant!.rate!)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
