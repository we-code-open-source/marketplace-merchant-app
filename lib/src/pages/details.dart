import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/restaurant_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class DetailsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  DetailsWidget({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  late RestaurantController _con;

  _DetailsWidgetState() : super(RestaurantController()) {
    _con = controller as RestaurantController ;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _con.user.apiToken == null
        ? CircularLoadingWidget(height: 500)
        : Scaffold(
        key: _con.scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('/EditRestaurant',
                  arguments: RouteArgument(
                      id: '0', param: {'restaurant': _con.user.restaurant}));
            },
            backgroundColor: Theme
                .of(context)
                .accentColor,
            child: Icon(
              Icons.edit,
              color: Theme
                  .of(context)
                  .primaryColor,
            )),
        body: RefreshIndicator(
          onRefresh: _con.refreshRestaurant,
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor:
                Theme
                    .of(context)
                    .accentColor
                    .withOpacity(0.9),
                expandedHeight: 300,
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort,
                      color: Theme
                          .of(context)
                          .primaryColor),
                  onPressed: () =>
                      widget
                          .parentScaffoldKey!.currentState
                          !.openDrawer(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Hero(
                    tag: 'my_restaurant' + _con.user.restaurant!.id!,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: _con.user.restaurant!.image!.url!,
                      placeholder: (context, url) =>
                          Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 10, top: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _con.user.restaurant?.name ?? '',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 2,
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .headline3,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Chip(
                              padding: EdgeInsets.all(0),
                              label: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_con.user.restaurant!.rate!,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1
                                          !.merge(TextStyle(
                                          color: Theme
                                              .of(context)
                                              .primaryColor))),
                                  Icon(
                                    Icons.star_border,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                              backgroundColor: Theme
                                  .of(context)
                                  .accentColor
                                  .withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 3),
                          decoration: BoxDecoration(
                              color: _con.user.restaurant!.closed!
                                  ? Colors.grey
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(24)),
                          child: _con.user.restaurant!.closed!
                              ? Text(
                            S
                                .of(context)
                                .closed,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                !.merge(TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor)),
                          )
                              : Text(
                            S
                                .of(context)
                                .open,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                !.merge(TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor)),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    Divider(),
                    Card(
                      child: SwitchListTile(
                        title: const Text('مفتوح'),
                        value: _con.user.restaurant!.open!,
                        onChanged: (value) => setState(() {
                          _con.user.restaurant!.open= value;
                          _con.user.restaurant!.closed = !value;
                          _con.updateRestaurantState(_con.user.restaurant!.closed);
                        }),
                        secondary: const Icon(Icons.lightbulb_outline),
                      ),
                    ),
                    Divider(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Helper.applyHtml(
                          context, _con.user.restaurant!.description!),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            leading: Icon(
                              Icons.stars,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                            title: Text(
                              S
                                  .of(context)
                                  .information,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Helper.applyHtml(
                              context, _con.user.restaurant!.information!),
                        ),
                      ],
                    ),

                    _con.user.restaurant!.address != null
                        ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _con.user.restaurant!.address ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                // Navigator.of(context).pushNamed('/Map', arguments: new RouteArgument(id: '0', param: _con.order));
                                launch(
                                    'https://www.google.com/maps/dir/?api=1&destination=' +
                                        _con.user.restaurant
                                            !.latitude
                                            .toString() +
                                        ',' +
                                        _con.user.restaurant
                                            !.longitude
                                            .toString() +
                                        '&travelmode=driving&dir_action=navigate');
                              },
                              child: Icon(
                                Icons.directions,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                size: 24,
                              ),
                              color: Theme
                                  .of(context)
                                  .accentColor
                                  .withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ) : SizedBox(height: 0,),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${_con.user.restaurant!.phone != null
                                  ? _con.user.restaurant!.phone : ''} \n${_con
                                  .user.restaurant!.mobile != null
                                  ? _con.user.restaurant!.mobile : ''}',
                              overflow: TextOverflow.ellipsis,
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                launch(
                                    "tel:${_con.user.restaurant!.mobile}");
                              },
                              child: Icon(
                                Icons.call,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                size: 24,
                              ),
                              color: Theme
                                  .of(context)
                                  .accentColor
                                  .withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _con.featuredFoods.isEmpty
                    //     ? SizedBox(height: 0)
                    //     : Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 20),
                    //         child: ListTile(
                    //           dense: true,
                    //           contentPadding:
                    //               EdgeInsets.symmetric(vertical: 0),
                    //           leading: Icon(
                    //             Icons.shopping_basket,
                    //             color: Theme.of(context).hintColor,
                    //           ),
                    //           title: Text(
                    //             S.of(context).featuredFoods,
                    //             style:
                    //                 Theme.of(context).textTheme.headline4,
                    //           ),
                    //         ),
                    //       ),
                    // _con.featuredFoods.isEmpty
                    //     ? SizedBox(height: 0)
                    //     : ListView.separated(
                    //         padding: EdgeInsets.symmetric(vertical: 10),
                    //         scrollDirection: Axis.vertical,
                    //         shrinkWrap: true,
                    //         primary: false,
                    //         itemCount: _con.featuredFoods.length,
                    //         separatorBuilder: (context, index) {
                    //           return SizedBox(height: 10);
                    //         },
                    //         itemBuilder: (context, index) {
                    //           return FoodItemWidget(
                    //             heroTag: 'details_featured_food',
                    //             food: _con.featuredFoods.elementAt(index),
                    //           );
                    //         },
                    //       ),
                    // SizedBox(height: 100),
                    // _con.reviews.isEmpty
                    //     ? SizedBox(height: 5)
                    //     : Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 20),
                    //         child: ListTile(
                    //           dense: true,
                    //           contentPadding:
                    //               EdgeInsets.symmetric(vertical: 0),
                    //           leading: Icon(
                    //             Icons.recent_actors,
                    //             color: Theme.of(context).hintColor,
                    //           ),
                    //           title: Text(
                    //             S.of(context).whatTheySay,
                    //             style:
                    //                 Theme.of(context).textTheme.headline4,
                    //           ),
                    //         ),
                    //       ),
                    // _con.reviews.isEmpty
                    //     ? SizedBox(height: 5)
                    //     : Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 10),
                    //         child: ReviewsListWidget(
                    //             reviewsList: _con.reviews),
                    //       ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
