import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/restaurant_controller.dart';
import '../helpers/helper.dart';
import 'package:food_delivery_owner/src/models/food.dart';
import 'package:food_delivery_owner/src/models/restaurant.dart';
import '../models/route_argument.dart';
import '../controllers/food_controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class EditRestaurantWidget extends StatefulWidget {
  final RouteArgument?  routeArgument;

  EditRestaurantWidget({Key? key, this.routeArgument}) : super(key: key);

  @override
  _EditRestaurantWidgetState createState() => _EditRestaurantWidgetState();
}

class _EditRestaurantWidgetState extends StateMVC<EditRestaurantWidget> {
  RestaurantController? _con;

  _EditRestaurantWidgetState() : super(RestaurantController()) {
    _con = controller as RestaurantController?;
  }

  @override
  void initState() {
    _con!.restaurant = widget.routeArgument!.param['restaurant'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          S.of(context).update_restaurant,
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
      key: _con!.scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _con!.restaurantFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 130,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          _con!.image != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(300)),
                                  child: Image.file(
                                    _con!.image!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(300)),
                                  child: CachedNetworkImage(
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    imageUrl: _con!.restaurant!.image!.url!,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                      height: 120,
                                      width: 120,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () => _showPicker(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: _con!.restaurant!.name,
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con!.restaurant!.name = input!.trim(),
                  maxLength: 30,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: S.of(context).please_enter_Field),
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).restaurant_name,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).restaurant_name,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.restaurant,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                TextFormField(
                  initialValue: Helper.skipHtml(_con!.restaurant!.description!),
                  keyboardType: TextInputType.text,
                  onSaved: (input) =>
                      _con!.restaurant!.description = input!.trim(),
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: S.of(context).description,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).description,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.description,
                        color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),

                TextFormField(
                  initialValue: Helper.skipHtml(_con!.restaurant!.information!),
                  keyboardType: TextInputType.text,
                  onSaved: (input) =>
                      _con!.restaurant!.information = input!.trim(),
                  maxLength: 100,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: S.of(context).please_enter_Field),
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).information,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).information,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon:
                        Icon(Icons.info, color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                TextFormField(
                  initialValue: _con!.restaurant!.phone,
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con!.restaurant!.phone = input!.trim(),
                  maxLength: 10,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please enter phone number"),
                    MinLengthValidator(10,
                        errorText:
                            S.of(context).should_be_more_than_10_letters),
                    PatternValidator(
                      r'^(09?(9[0-9]{8}))$',
                      errorText: S.of(context).not_a_valid_phone,
                    )
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).phone_1,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).phone_ex,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon:
                        Icon(Icons.phone, color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                TextFormField(
                  initialValue: _con!.restaurant!.mobile,
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con!.restaurant!.mobile = input!.trim(),
                  maxLength: 10,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Please enter phone number"),
                    MinLengthValidator(10,
                        errorText:
                            S.of(context).should_be_more_than_10_letters),
                    PatternValidator(
                      r'^(09?(9[0-9]{8}))$',
                      errorText: S.of(context).not_a_valid_phone,
                    )
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).phone_2,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).phone_ex,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon:
                        Icon(Icons.phone, color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                SizedBox(height: 20),
                // SizedBox(
                //   width: (size.width * .4),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Theme.of(context).accentColor,
                //       textStyle:
                //           TextStyle(color: Theme.of(context).primaryColor),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: new BorderRadius.circular(30.0),
                //       ),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //           right: 4, left: 4, top: 8, bottom: 8),
                //       child: Text(
                //           S.of(context).uploadImage,
                //         style: TextStyle(fontSize: 16, color: Colors.white),
                //       ),
                //     ),
                //     onPressed: () async {
                //       _con!.loadAssets();
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                        textStyle:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onPressed: () {
                      _con!.listenUpdateRestaurant(_con!.restaurant);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(
                        S.of(context).Gallery,
                      ),
                      onTap: () {
                        _con!.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                      S.of(context).Camera,
                    ),
                    onTap: () {
                      _con!.imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
