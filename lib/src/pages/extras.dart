import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/models/route_argument.dart';
import '../elements/EmptyExtrasWidget.dart';
import '../controllers/food_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

class ExtrasWidget extends StatefulWidget {
  ExtrasWidget({Key? key}) : super(key: key);

  @override
  _ExtrasWidgetState createState() => _ExtrasWidgetState();
}

class _ExtrasWidgetState extends StateMVC<ExtrasWidget> {
  FoodController? _con;

  _ExtrasWidgetState() : super(FoodController()) {
    _con = controller as FoodController?;
  }

  @override
  void initState() {
    _con!.listenForExtras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _con!.extras == null
        ? CircularLoadingWidget(height: 500)
        : Scaffold(
            key: _con!.scaffoldKey,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/AddExtra');
                },
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                )),
            appBar: AppBar(
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              title: Text(
                S.of(context).extras,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
              leading: IconButton(
                  icon: new Icon(Icons.arrow_back,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            body: RefreshIndicator(
              onRefresh: _con!.refreshExtras,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: <Widget>[
                  _con!.extras.isEmpty
                      ? EmptyExtrasWidget()
                      : ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con!.extras.length,
                          itemBuilder: (context, index) {
                            var _extra = _con!.extras.elementAt(index);
                            return Card(
                                child: Padding(padding: EdgeInsets.only(left: 10,right: 20),
                                    child:Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text(_extra.name!, style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .merge(TextStyle(fontWeight: FontWeight.w300))),
                                  IconButton(
                                      icon: new Icon(Icons.edit,
                                          color: Theme.of(context).accentColor),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            '/EditExtra',
                                            arguments: RouteArgument(
                                                id: '0',
                                                param: {'extra': _extra}));
                                      }),
                                ])));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 5);
                          },
                        ),
                ],
              ),
            ),
          );
  }
}
