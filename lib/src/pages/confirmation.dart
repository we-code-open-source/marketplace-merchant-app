import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import '../models/cart.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class ConfirmationWidget extends StatefulWidget {
  final RouteArgument? routeArgument;

  ConfirmationWidget({Key? key, this.routeArgument}) : super(key: key);

  @override
  _ConfirmationWidgetState createState() => _ConfirmationWidgetState();
}

class _ConfirmationWidgetState extends StateMVC<ConfirmationWidget> {
  CartController? _con;

  _ConfirmationWidgetState() : super(CartController()) {
    _con = controller as CartController?;
  }

  List<Cart> carts = <Cart>[];
  String? total;
  String? subTotal;

  @override
  void initState() {
    carts = widget.routeArgument!.param;
    total = widget.routeArgument!.id;
    subTotal = widget.routeArgument!.heroTag;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con!.scaffoldKey,
        bottomNavigationBar: Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.15),
                    offset: Offset(0, -2),
                    blurRadius: 5.0)
              ]),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: FlatButton(
                        onPressed: () {
                          _con!.getDistance();
                        },
                        disabledColor:
                            Theme.of(context).focusColor.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                        child: Text(
                          S.of(context).confirm_order,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).hintColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).confirm_order,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: orderReview(),
      ),
    );
  }

  Widget orderReview() {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          child: Icon(
                        Icons.payment,
                        color: Theme.of(context).accentColor,
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(S.of(context).payment_mode,
                              style: Theme.of(context).textTheme.headline6),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(S.of(context).cash_on_delivery,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          child: Icon(
                        Icons.account_circle_outlined,
                        color: Theme.of(context).accentColor,
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                            child: Text(S.of(context).customer_details,
                                style: Theme.of(context).textTheme.headline6)),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Form(
                    key: _con!.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con!.unregisteredCustomer.name = input!.trim(),
                          maxLength: 30,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: S.of(context).please_enter_name),
                            MinLengthValidator(3,
                                errorText: S
                                    .of(context)
                                    .should_be_more_than_3_characters),
                          ]),
                          decoration: InputDecoration(
                            labelText: S.of(context).full_name,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'فلان الفلاني',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.account_circle_outlined,
                                color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (input) =>
                              _con!.unregisteredCustomer.phone = input!.trim(),
                          maxLength: 10,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    S.of(context).please_enter_phone_number),
                            MinLengthValidator(10,
                                errorText: S
                                    .of(context)
                                    .should_be_more_than_10_letters),
                            PatternValidator(
                              r'^(09?(9[0-9]{8}))$',
                              errorText: S.of(context).not_a_valid_phone,
                            )
                          ]),
                          decoration: InputDecoration(
                            labelText: S.of(context).phone,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: S.of(context).phone_ex,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.phone,
                                color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con!.deliveryAddress.address = input!.trim(),
                          maxLength: 30,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: S.of(context).please_enter_address),
                          ]),
                          decoration: InputDecoration(
                            labelText: S.of(context).address,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'طرابلس باب البحر',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.add_location_alt_outlined,
                                color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _con!.order.restaurantDeliveryFee =
                                  double.tryParse(input!.trim()),
                          maxLength: 4,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    S.of(context).please_enter_delivery_fee),
                          ]),
                          decoration: InputDecoration(
                            labelText: S.of(context).delivery_fee,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: '10.0',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.monetization_on_outlined,
                                color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: (size.width * .4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor,
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 4, left: 4, top: 8, bottom: 8),
                              child: Text(
                                S.of(context).detect_location,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              // LocationResult result = await showLocationPicker(
                              //   context,
                              //   setting.value.googleMapsKey,
                              //   initialCenter: LatLng(32.885353, 13.180161),
                              //   requiredGPS: true,
                              //   myLocationButtonEnabled: true,
                              //   automaticallyAnimateToCurrentLocation: true,

                              //   //resultCardAlignment: Alignment.bottomCenter,
                              // );
                              LocationResult result =
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                                setting.value.googleMapsKey!,
                                              )));
                              print("result = $result");
                              print("result = ${result.latLng!.latitude}");
                              print("result = ${result.latLng!.longitude}");
                              _con!.deliveryAddress.latitude = double.tryParse(
                                      result.latLng!.latitude
                                          .toStringAsFixed(6)) ??
                                  0;
                              _con!.deliveryAddress.longitude = double.tryParse(
                                      result.latLng!.longitude
                                          .toStringAsFixed(6)) ??
                                  0;
                              _con!.userInputLattitude.text =
                                  result.latLng!.latitude.toStringAsFixed(6);
                              _con!.userInputLongitude.text =
                                  result.latLng!.longitude.toStringAsFixed(6);
                              print("result = $result");
                              _con!.order.deliveryAdd = _con!.deliveryAddress;
                              _con!.order.unregisteredCustomer =
                                  _con!.unregisteredCustomer;
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // TextField(
                        //   enabled: false,
                        //     keyboardType: TextInputType.number,
                        //     maxLines: null,
                        //     textDirection: TextDirection.ltr,
                        //     textAlign:
                        //         Directionality.of(context) == TextDirection.ltr
                        //             ? TextAlign.left
                        //             : TextAlign.right,
                        //     controller: _con!.userInputLattitude,
                        //     style: Theme.of(context).textTheme.bodyText1,
                        //     decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.only(
                        //         left: 12,
                        //         bottom: 8,
                        //       ),
                        //       border: InputBorder.none,
                        //       hintText: '',
                        //       hintStyle: Theme.of(context)
                        //           .textTheme
                        //           .bodyText1
                        //           .copyWith(color: Colors.black),
                        //     )),
                        // TextField(
                        //     enabled: false,
                        //     keyboardType: TextInputType.number,
                        //     maxLines: null,
                        //     textDirection: TextDirection.ltr,
                        //     textAlign:
                        //     Directionality.of(context) == TextDirection.ltr
                        //         ? TextAlign.left
                        //         : TextAlign.right,
                        //     controller: _con!.userInputLongitude,
                        //     style: Theme.of(context).textTheme.bodyText1,
                        //     decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.only(
                        //         left: 12,
                        //         bottom: 8,
                        //       ),
                        //       border: InputBorder.none,
                        //       hintText: '',
                        //       hintStyle: Theme.of(context)
                        //           .textTheme
                        //           .bodyText1
                        //           .copyWith(color: Colors.black),
                        //     )),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width - 40,
                        //   child: FlatButton(
                        //     onPressed: () {
                        //       _con!.getDistance();
                        //     },
                        //     disabledColor:
                        //     Theme.of(context).focusColor.withOpacity(0.5),
                        //     padding: EdgeInsets.symmetric(vertical: 14),
                        //     color: Theme.of(context).accentColor,
                        //     shape: StadiumBorder(),
                        //     child: Text(
                        //       'confirm_payment',
                        //       textAlign: TextAlign.start,
                        //       style: Theme.of(context).textTheme.bodyText1.merge(
                        //           TextStyle(color: Theme.of(context).primaryColor)),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
