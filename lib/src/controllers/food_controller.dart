import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/models/category.dart';
import 'package:food_delivery_owner/src/models/extra_group.dart';
import 'package:food_delivery_owner/src/models/route_argument.dart';
import 'package:food_delivery_owner/src/repository/cart_repository.dart';
import '../helpers/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/extra.dart';
import '../models/favorite.dart';
import '../models/food.dart';
import '../repository/food_repository.dart';

class FoodController extends ControllerMVC {
  Food food = new Food();
  Extra extra = new Extra();
  List<Food> foods = <Food>[];
  List<Extra> extras = <Extra>[];
  List<Extra> extrasfoods = <Extra>[];
  List<Category> Categories = <Category>[];
  List<ExtraGroup> ExtraGroups = <ExtraGroup>[];
  List<DropdownMenuItem<Category>>? items;
  double quantity = 1;
  double total = 0;
  Cart? cart;
  List<Cart> carts = [];
  Favorite? favorite;
  bool loadCart = false;
  bool loading = false;
  bool isDefault = false;
  GlobalKey<ScaffoldState>? scaffoldKey;
  GlobalKey<FormState>? foodFormKey;
  GlobalKey<FormState>? extraFormKey;
  OverlayEntry? loader;

  Category? _selectedCategory;
  ExtraGroup? _selectedExtraGroup;

  Category? get selectedCategory => _selectedCategory;

  ExtraGroup? get selectedExtraGroup => _selectedExtraGroup;

  set selectedCategorySetter(var value) => _selectedCategory = value;

  set selectedExtraGroupSetter(var value) => _selectedExtraGroup = value;

  void defaultAddress() async {
    setState(() {
      isDefault = !isDefault;
      food.featured = isDefault;
    });
  }

  void checkExtra(value) async {
    setState(() {
      extra.checked = !value;
    });
  }

  ///Image_picker
  final picker = ImagePicker();
  File? image;

  //////////////////////////////////////////////////
  FoodController() {
    foodFormKey = new GlobalKey<FormState>();
    extraFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCategories();
    food.featured = isDefault;
  }

  void addNewExtra() async {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (extraFormKey!.currentState!.validate()) {
      extraFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      await addExtra(extra).then((value) {
        if (value.id != null) {
          Navigator.of(scaffoldKey!.currentContext!)
              .pushReplacementNamed("/Extra");
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text(S.of(state!.context).new_Extra_added_successfully),
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

  void updateExtraFood() async {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (extraFormKey!.currentState!.validate()) {
      extraFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      await updateExtra(extra).then((value) {
        if (value.id != null) {
          Navigator.of(scaffoldKey!.currentContext!)
              .pushReplacementNamed("/Extra");
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text(S.of(state!.context).update_Extra),
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

  /// Create new Food
  void addNewFood() async {
    if (image != null) {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (foodFormKey!.currentState!.validate()) {
        foodFormKey!.currentState!.save();
        food.extras = extras.where((element) => element.checked!).toList();
        if (food.price! > food.discountPrice!) {
          Overlay.of(state!.context)!.insert(loader!);
          await addFood(food, image!).then((value) {
            if (value) {
              Navigator.of(scaffoldKey!.currentContext!)
                  .pushReplacementNamed('/Pages', arguments: 1);
              ScaffoldMessenger.of(scaffoldKey!.currentContext!)
                  .showSnackBar(SnackBar(
                content: Text(S.of(state!.context).new_Food_added_successfully),
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
        } else
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text('سعر التخفيض يجب ان يكون اقل من سعر الاصلي للوجبة'),
          ));
      }
    } else
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).please_enter_your_image),
      ));
  }

  void updateFoods() async {
    if (image != null) {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (foodFormKey!.currentState!.validate()) {
        foodFormKey!.currentState!.save();
        food.extras = extrasfoods.where((element) => element.checked!).toList();
        if (food.price! > food.discountPrice!) {
          Overlay.of(state!.context)!.insert(loader!);
          await updateFood(food, image!).then((value) {
            if (value) {
              Navigator.of(scaffoldKey!.currentContext!)
                  .pushReplacementNamed('/Pages', arguments: 1);
              ScaffoldMessenger.of(scaffoldKey!.currentContext!)
                  .showSnackBar(SnackBar(
                content: Text(S.of(state!.context).updated_food_successfully),
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
        } else
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text('سعر التخفيض يجب ان يكون اقل من سعر الاصلي للوجبة'),
          ));
      }
    } else {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (foodFormKey!.currentState!.validate()) {
        foodFormKey!.currentState!.save();
        food.extras = extrasfoods.where((element) => element.checked!).toList();
        if (food.price! > food.discountPrice!) {
          Overlay.of(state!.context)!.insert(loader!);
          await updateFood1(food).then((value) {
            if (value != null) {
              Navigator.of(scaffoldKey!.currentContext!)
                  .pushReplacementNamed('/Pages', arguments: 1);
              ScaffoldMessenger.of(scaffoldKey!.currentContext!)
                  .showSnackBar(SnackBar(
                content: Text(S.of(state!.context).updated_food_successfully),
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
        } else
          ScaffoldMessenger.of(scaffoldKey!.currentContext!)
              .showSnackBar(SnackBar(
            content: Text('سعر التخفيض يجب ان يكون اقل من سعر الاصلي للوجبة'),
          ));
      }
    }
  }

  void listenForFood({String? foodId, String? message}) async {
    final Stream<Food> stream = await getFood(foodId!);
    stream.listen((Food _food) {
      setState(() => food = _food);
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      calculateTotal();
      if (message != null) {
        scaffoldKey!.currentState!.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenUpdateFood(Food food) {
    updateFood1(food).then((_food) {
      refreshFoods().then((value) {
        setState(() {});
      });
    });
  }

  void listenForFoods({String? message}) async {
    final Stream<Food> stream = await getFoods();
    foods.clear();
    stream.listen((Food _food) {
      setState(() {
        foods.add(_food);
      });
    });
  }

  void listenForExtras({String? message}) async {
    try {
      loading = true;
      final Stream<Extra> stream = await getExtras();
      extras.clear();
      stream.listen((Extra _ex) {
        setState(() {
          extras.add(_ex);
        });
      });
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  void listenForExtrasByFood(id) async {
    try {
      final Stream<Extra> stream = await getExtrasByFood(id);
      extrasfoods.clear();
      stream.listen((Extra _ex) {
        setState(() {
          extrasfoods.add(_ex);
        });
      });
    } catch (e) {
      print(e);
    } finally {}
  }

  void listenForCategories({String? message}) async {
    final Stream<Category> stream = await getCategories();
    Categories.clear();
    items = [];
    stream.listen((Category category) {
      setState(() {
        Categories.add(category);
      });
    });
  }

  void listenForExtraGroups({String? message}) async {
    final Stream<ExtraGroup> stream = await getExtraGroups();
    ExtraGroups.clear();
    items = [];
    stream.listen((ExtraGroup extraGroup) {
      setState(() {
        ExtraGroups.add(extraGroup);
      });
    });
  }

  onChangeDropdownCategoryItem(Category value) {
    _selectedCategory = value;
  }

  onChangeDropdownExtraGroupItem(ExtraGroup value) {
    _selectedExtraGroup = value;
  }

  void listenForFavorite({String? foodId}) async {
    final Stream<Favorite> stream = await isFavoriteFood(foodId!);
    stream.listen((Favorite _favorite) {
      setState(() => favorite = _favorite);
    }, onError: (a) {
      print(a);
    });
  }

  bool isSameRestaurants(Food food) {
    if (cart != null) {
      return cart!.food!.restaurant?.id == food.restaurant!.id;
    }
    return true;
  }

  Cart isExistInCart(Cart _cart) {
    if (carts.isEmpty) {
      return Cart();
    } else {
      return carts.firstWhere(
        (Cart oldCart) => _cart.isSame(oldCart),
      );
    }
  }

  void addToCart(Food food, {bool reset = false}) async {
    setState(() {
      this.loadCart = true;
    });
    var _newCart = new Cart();
    _newCart.food = food;
    _newCart.extras =
        food.extras!.where((element) => element.checked!).toList();
    _newCart.quantity = this.quantity;
    // if food exist in the cart then increment quantity
    Cart _oldCart = isExistInCart(_newCart);
    if (_oldCart.id != null) {
      _oldCart.quantity = _oldCart.quantity! + this.quantity;
      updateCart(_oldCart).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(S.of(state!.context).this_food_was_added_to_cart),
        ));
        Navigator.of(state!.context).pushNamed('/addOrder');
      });
    } else {
      // the food doesnt exist in the cart add new one
      addCart(_newCart, reset).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        ScaffoldMessenger.of(scaffoldKey!.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(S.of(state!.context).this_food_was_added_to_cart),
        ));
        Navigator.of(state!.context).pushNamed('/addOrder');
      });
    }
  }

  void addToFavorite(Food food) async {
    var _favorite = new Favorite();
    _favorite.food = food;
    _favorite.extras = food.extras!.where((Extra _extra) {
      return _extra.checked!;
    }).toList();
    addFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = value;
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text('This food was added to favorite'),
      ));
    });
  }

  void removeFromFavorite(Favorite _favorite) async {
    removeFavorite(_favorite).then((value) {
      setState(() {
        this.favorite = new Favorite();
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text('This food was removed from favorites'),
      ));
    });
  }

  Future<void> refreshFood() async {
    var _id = food.id;
    food = new Food();
    listenForFavorite(foodId: _id);
    listenForFood(foodId: _id, message: 'Food refreshed successfuly');
  }

  void calculateTotal() {
    total = food.price ?? 0;
    food.extras!.forEach((extra) {
      total = total + (extra.checked! ? extra.price! : 0);
    });
    total *= quantity;
    setState(() {});
  }

  Future<void> refreshFoods() async {
    foods.clear();
    listenForFoods(message: S.of(state!.context).order_refreshed_successfuly);
  }

  Future<void> refreshExtras() async {
    extras.clear();
    listenForExtras(message: S.of(state!.context).extras_refreshed_successfuly);
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
