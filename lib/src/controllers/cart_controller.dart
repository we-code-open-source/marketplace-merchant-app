import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/elements/confirm_dialog_view.dart';
import 'package:food_delivery_owner/src/models/order.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/cart_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/cart.dart';

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  Order order=new Order();
  UnregisteredCustomer unregisteredCustomer=new UnregisteredCustomer();
  DeliveryAddress deliveryAddress=new DeliveryAddress();
  double taxAmount = 0.0;
  double deliveryFee = 0.0;
  int cartCount = 0;
  double subTotal = 0.0;
  double total = 0.0;
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  final TextEditingController userInputLattitude = TextEditingController();
  final TextEditingController userInputLongitude = TextEditingController();
  CartController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
goToCheckOut(){
    print(order.toMap());
    Navigator.of(state!.context).pushNamed('/CashOnDelivery',
        arguments: RouteArgument(
            param: order, id: 'Cash on Delivery'));

}
void getDistance() async{
  if (loginFormKey!.currentState!.validate()) {
    loginFormKey!.currentState!.save();
    if(userInputLongitude.text !=null &&
        userInputLattitude.text !=null &&
        unregisteredCustomer.phone !=null &&
        unregisteredCustomer.name !=null &&
        deliveryAddress.latitude !=null &&
        deliveryAddress.longitude !=null &&
        deliveryAddress.address !=null
    )
  await getDistanceAndTime(userInputLongitude.text,userInputLattitude.text).then((value) async{
    print(value);

    if (value!=null) {
      print(value);
order.deliveryFee=double.tryParse(value);
  await showDialog<dynamic>(
      context: state!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ConfirmDialogView(
          title: S.of(context).Ok,
          description: 'سعر التوصيل هو ${value} هل توافق عليه',
          leftButtonText:
          S.of(context).close,
          rightButtonText: S.of(context).Ok,
          onAgreeTap: () {
            Navigator.pop(context);
            goToCheckOut();
          },
          onCloseTap: () {
            Navigator.pop(context);
          },
        );
      });
}});
}
}
  void listenForCarts({String? message}) async {
    carts.clear();
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      if (!carts.contains(_cart)) {
        setState(() {
          carts.add(_cart);
        });
      }
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (carts.isNotEmpty) {
        calculateSubtotal();
        onLoadingCartDone();
      }
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }

    });
  }

  void onLoadingCartDone() {}
  void listenForCartsCount({String? message}) async {
    final Stream<int> stream = await getCartCount();
    stream.listen((int _count) {
      setState(() {
        this.cartCount = _count;
      });
    }, onError: (a) {
      print(a);

    });
  }
  void removeFromCart(Cart _cart) async {
    setState(() {
      this.carts.remove(_cart);
    });
    removeCart(_cart).then((value) {
      calculateSubtotal();
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).the_food_was_removed_from_your_cart(_cart.food!.name!)),
      ));
    });
  }

  void calculateSubtotal() async {
    double cartPrice = 0;
    subTotal = 0;
    carts.forEach((cart) {
      cartPrice = cart.food!.price!;
      cart.extras!.forEach((element) {
        cartPrice += element.price!;
      });
      cartPrice *= cart.quantity!;
      subTotal += cartPrice;
    });
    total = subTotal + taxAmount + order.deliveryFee!;
    setState(() {});
  }
  incrementQuantity(Cart cart) {
    if (cart.quantity! <= 99) {
      cart.quantity = cart.quantity! + 1;
      updateCart(cart);
      calculateSubtotal();
    }
  }

  decrementQuantity(Cart cart) {
    if (cart.quantity! > 1) {
      cart.quantity = cart.quantity! - 1;
      updateCart(cart);
      calculateSubtotal();
    }
  }
  void goCheckout(BuildContext context) {

      Navigator.of(context).pushNamed('/Confirmation',
          arguments: RouteArgument(
            id: total.toStringAsFixed(2),
            heroTag: subTotal.toStringAsFixed(2),
            param: carts,
          ));
      // Navigator.of(context).pushNamed('/DeliveryPickup');

  }
  Future<void> refreshCarts() async {
    setState(() {
      carts = [];
    });
    listenForCarts(message: S.of(state!.context).carts_refreshed_successfuly);
  }
}
