
import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../models/cart.dart';
import '../models/credit_card.dart';
import '../models/food_order.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../repository/order_repository.dart' as orderRepo;
import '../repository/user_repository.dart' as userRepo;
import 'cart_controller.dart';

class CheckoutController extends CartController {
  Payment? payment;
 late  Order order;
  CreditCard creditCard = new CreditCard();
  bool loading = true;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }

  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }
  @override
  void onLoadingCartDone() {
    if (payment != null && order != null){
      addOrder(carts,order);
    }
      super.onLoadingCartDone();
    }

  void addOrder(List<Cart> carts,Order order) async {

    Order _order = new Order();
    _order.foodOrders = <FoodOrder>[];
    _order.tax = carts[0].food!.restaurant!.defaultTax;

        _order.deliveryFee = order.deliveryFee??0;
        _order.restaurantDeliveryFee = order.restaurantDeliveryFee??0;


      _order.deliveryFee = payment!.method == 'Pay on Pickup' ? 0
          :  _order.deliveryFee;
    OrderStatus _orderStatus = new OrderStatus();
    _orderStatus.id = '1'; // TODO default order status Id
    _order.orderStatus = _orderStatus;
    _order.deliveryAdd=order.deliveryAdd;
    _order.unregisteredCustomer=order.unregisteredCustomer;
    carts.forEach((_cart) {
      FoodOrder _foodOrder = new FoodOrder();
      _foodOrder.quantity = _cart.quantity;
      _foodOrder.price = _cart.food!.price;
      _foodOrder.food = _cart.food;
      _foodOrder.extras = _cart.extras;
      _order.foodOrders!.add(_foodOrder);
    });
    orderRepo.addOrder(_order, this.payment!).then((value) async {
      // settingRepo.coupon = new Coupon.fromJSON({});
      return value;
    }).then((value) {
      if (value is Order) {
        setState(() {
          loading = false;
          //   Navigator.of(state!.context).pushNamed('/Tracking',
          //       arguments: RouteArgument(id: value.id));
          //
        });
      }
    });
  }
  //}




}
