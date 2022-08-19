import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/helpers/helper.dart';
import 'package:food_delivery_owner/src/models/category.dart';
import 'package:food_delivery_owner/src/models/user.dart';
import 'package:food_delivery_owner/src/repository/category_repository.dart';
import 'package:food_delivery_owner/src/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/food.dart';
import '../models/gallery.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../repository/food_repository.dart';
import '../repository/gallery_repository.dart';
import '../repository/restaurant_repository.dart';

class RestaurantController extends ControllerMVC {
  Restaurant? restaurant;
  User user = new User();
  bool loading = true;
  List<Gallery> galleries = <Gallery>[];
  List<Restaurant> restaurants = <Restaurant>[];
  List<Food> foods = <Food>[];
  List<Category> categories = <Category>[];
  List<Food> trendingFoods = <Food>[];
  List<Food> featuredFoods = <Food>[];
  List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState>? scaffoldKey;
  GlobalKey<FormState>? restaurantFormKey;
  OverlayEntry? loader;

  ///Image_picker
  final picker = ImagePicker();
  File? image;

  RestaurantController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.restaurantFormKey = new GlobalKey<FormState>();
    listenForRestaurant();
    listenForFeaturedFoods();
  }

  void imgFromCamera() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {}
  }

  void imgFromGallery() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {}
  }

  void listenForRestaurants({String? message}) async {
    final Stream<Restaurant> stream = await getRestaurants();
    stream.listen((Restaurant _restaurant) {
      setState(() => restaurants.add(_restaurant));
    }, onError: (a) {
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void updateRestaurantState(restaurantState) {
    try {
      updateRestaurantAvailable(restaurantState).then((v) {
        setState(() {});
      });
    } catch (e) {
      ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
        content: Text('حدث خطأ ما !'),
      ));
    }
  }

  void listenUpdateRestaurant(restaurant) {
    if (image != null) {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (restaurantFormKey!.currentState!.validate()) {
        restaurantFormKey!.currentState!.save();
        Overlay.of(state!.context)!.insert(loader!);
        updateRestaurantWithImage(restaurant, image!).then((_restaurant) {
          if (_restaurant) {
            Navigator.of(scaffoldKey!.currentContext!)
                .pushReplacementNamed('/Pages', arguments: 0);
            ScaffoldMessenger.of(scaffoldKey!.currentContext!)
                .showSnackBar(SnackBar(
              content:
                  Text(S.of(state!.context).updated_restaurant_successfully),
            ));
          }
        }).catchError((e) {
          loader?.remove();
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text(e),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader!);
        });
      }
    } else {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (restaurantFormKey!.currentState!.validate()) {
        restaurantFormKey!.currentState!.save();
        Overlay.of(state!.context)!.insert(loader!);
        updateRestaurant(restaurant).then((value) {
          if (value != null) {
            Navigator.of(scaffoldKey!.currentContext!)
                .pushReplacementNamed('/Pages', arguments: 0);
            ScaffoldMessenger.of(scaffoldKey!.currentContext!)
                .showSnackBar(SnackBar(
              content:
                  Text(S.of(state!.context).updated_restaurant_successfully),
            ));
          }
        }).catchError((e) {
          loader?.remove();
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text(e),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader!);
        });
      }
    }
  }

  void listenForRestaurant({String? message}) async {
    getRestaurantByUser().then((value) {
      setState(() {
        user = value!;
      });
    });
  }

  Future<void> listenForCategories(String restaurantId) async {
    final Stream<Category> stream =
        await getCategoriesOfRestaurant(restaurantId);
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      categories.insert(0,
          new Category.fromJSON({'id': '0', 'name': S.of(state!.context).all}));
    });
  }

  Future<void> selectCategory(List<String> categoriesId) async {
    foods.clear();
    listenForFoods(restaurant!.id!, categoriesId: categoriesId);
  }

  void listenForGalleries(String idRestaurant) async {
    final Stream<Gallery> stream = await getGalleries(idRestaurant);
    stream.listen((Gallery _gallery) {
      setState(() => galleries.add(_gallery));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForRestaurantReviews({String? id, String? message}) async {
    final Stream<Review> stream = await getRestaurantReviews(id!);
    stream.listen((Review _review) {
      setState(() => reviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForFoods(String idRestaurant, {List<String>? categoriesId}) async {
    final Stream<Food> stream =
        await getFoodsOfRestaurant(idRestaurant, categories: categoriesId);
    stream.listen((Food _food) {
      setState(() => foods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      restaurant!.name = foods.elementAt(0).restaurant!.name;
    });
  }

  void listenForTrendingFoods(String idRestaurant) async {
    final Stream<Food> stream =
        await getTrendingFoodsOfRestaurant(idRestaurant);
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void listenForFeaturedFoods() async {
    final Stream<Food> stream = await getFeaturedFoodsOfRestaurant("3");
    stream.listen((Food _food) {
      setState(() => featuredFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> refreshRestaurant() async {
    //var _id = restaurant.id;
    restaurant = new Restaurant();
    galleries.clear();
    reviews.clear();
    featuredFoods.clear();
    listenForRestaurant(
        message: S.of(state!.context).restaurant_refreshed_successfuly);
    //listenForRestaurantReviews(id: _id);
    //listenForGalleries(_id);
    //listenForFeaturedFoods(_id);
  }

  Future<void> refreshRestaurants() async {
    restaurants.clear();
    listenForRestaurants(
        message: S.of(state!.context).restaurant_refreshed_successfuly);
  }
}
