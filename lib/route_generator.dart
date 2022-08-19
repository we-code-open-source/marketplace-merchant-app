import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/pages/add_extra.dart';
import 'package:food_delivery_owner/src/pages/add_user.dart';
import 'package:food_delivery_owner/src/pages/confirmation.dart';
import 'package:food_delivery_owner/src/pages/edit_extra.dart';
import 'package:food_delivery_owner/src/pages/extras.dart';
import 'src/pages/forceUpdateView.dart';
import 'src/pages/cart.dart';
import 'src/pages/food.dart';
import 'src/pages/order_success.dart';
import 'src/pages/addOrder.dart';
import 'src/pages/add_food.dart';
import 'src/pages/code_view.dart';
import 'src/pages/edit_food.dart';
import 'src/pages/edit_restaurant.dart';
import 'src/pages/reset_password.dart';

import 'src/models/route_argument.dart';
import 'src/pages/chat.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/help.dart';
import 'src/pages/languages.dart';
import 'src/pages/login.dart';
import 'src/pages/notifications.dart';
import 'src/pages/order.dart';
import 'src/pages/order_edit.dart';
import 'src/pages/pages.dart';
import 'src/pages/settings.dart';
import 'src/pages/signup.dart';
import 'src/pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/SignUp':
        return MaterialPageRoute(
            builder: (_) => SignUpWidget(routeArgument: args as RouteArgument));
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification2':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/CashOnDelivery':
        return MaterialPageRoute(
            builder: (_) =>
                OrderSuccessWidget(routeArgument: args as RouteArgument));
      case '/Confirmation':
        return MaterialPageRoute(
            builder: (_) =>
                ConfirmationWidget(routeArgument: args as RouteArgument));
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/code':
        return MaterialPageRoute(
            builder: (_) => CodeView(routeArgument: args as RouteArgument));
      case '/ResetPassword':
        return MaterialPageRoute(
            builder: (_) =>
                ResetPasswordWidget(routeArgument: args as RouteArgument));
      case '/ForgetPassword':
        return MaterialPageRoute(
            builder: (_) =>
                ForgetPasswordWidget(routeArgument: args as RouteArgument));
      case '/AddFood':
        return MaterialPageRoute(builder: (_) => AddFoodWidget());
      case '/AddUser':
        return MaterialPageRoute(builder: (_) => AddUserWidget());
      case '/EditFood':
        return MaterialPageRoute(
            builder: (_) =>
                EditFoodWidget(routeArgument: args as RouteArgument));
    case '/EditExtra':
        return MaterialPageRoute(
            builder: (_) =>
                EditExtraWidget(routeArgument: args as RouteArgument));
      case '/Food':
        return MaterialPageRoute(
            builder: (_) => FoodWidget(routeArgument: args as RouteArgument));
      case '/Cart':
        return MaterialPageRoute(
            builder: (_) => CartWidget(routeArgument: args as RouteArgument));
      case '/ForceUpdate':
        return MaterialPageRoute(
            builder: (_) =>
                ForceUpdateView(routeArgument: args as RouteArgument));
      case '/EditRestaurant':
        return MaterialPageRoute(
            builder: (_) =>
                EditRestaurantWidget(routeArgument: args as RouteArgument));
      case '/Pages':
        return MaterialPageRoute(
            builder: (_) => PagesTestWidget(currentTab: args));
      case '/Chat':
        return MaterialPageRoute(
            builder: (_) => ChatWidget(routeArgument: args as RouteArgument));
      // case '/Details':
      //   return MaterialPageRoute(builder: (_) => DetailsWidget(routeArgument: args));
      case '/OrderDetails':
        return MaterialPageRoute(
            builder: (_) => OrderWidget(routeArgument: args as RouteArgument));
      case '/OrderEdit':
        return MaterialPageRoute(
            builder: (_) =>
                OrderEditWidget(routeArgument: args as RouteArgument));
      case '/addOrder':
        return MaterialPageRoute(builder: (_) => AddOrderWidget());
        case '/AddExtra':
        return MaterialPageRoute(builder: (_) => AddExtraWidget());
        case '/Extra':
        return MaterialPageRoute(builder: (_) => ExtrasWidget());
      case '/Notifications':
        return MaterialPageRoute(builder: (_) => NotificationsWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
