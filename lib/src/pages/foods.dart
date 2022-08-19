import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/food_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EmptyFoodsWidget.dart';
import '../elements/FoodItemWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

class FoodsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  FoodsWidget({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _FoodsWidgetState createState() => _FoodsWidgetState();
}

class _FoodsWidgetState extends StateMVC<FoodsWidget> {
  FoodController? _con;

  _FoodsWidgetState() : super(FoodController()) {
    _con = controller as FoodController?;
  }
  TextEditingController textFieldController = new TextEditingController();

  @override
  void initState() {
    _con!.listenForFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _con!.foods==null
        ? CircularLoadingWidget(height: 500)
        :Scaffold(
      key: _con!.scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).pushNamed('/AddFood');
          },
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          )),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey!.currentState!.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).foods,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .merge(TextStyle(letterSpacing: 1.3)),
        ),

      ),
      body: RefreshIndicator(
        onRefresh: _con!.refreshFoods,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          children: <Widget>[
            _con!.foods.isEmpty
                ? EmptyFoodsWidget()
                : ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _con!.foods.length,
                    itemBuilder: (context, index) {
                      var _food = _con!.foods.elementAt(index);
                      return FoodItemWidget(
                          heroTag: 'details_food',
                          food: _food,
                          onTap: (value) {
                            setState(() {
                              _food.available = value;
                              _con!.listenUpdateFood(_food);
                            });
                          });
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
