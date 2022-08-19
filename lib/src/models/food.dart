import '../helpers/custom_trace.dart';
import '../models/category.dart';
import '../models/extra.dart';
import '../models/extra_group.dart';
import '../models/media.dart';
import '../models/nutrition.dart';
import '../models/restaurant.dart';
import '../models/review.dart';

class Food {
  String? id;
  String? categoryId;
  String? name;
  double? price;
  double? discountPrice;
  Media? image;
  String? description;
  String? ingredients;
  String? weight;
  String? unit;
  String? packageItemsCount;
  bool? featured;
  bool? deliverable;
  Restaurant? restaurant;
  Category? category;
  List<Extra>? extras;
  List<ExtraGroup>? extraGroups;
  List<Review>? foodReviews;
  List<Nutrition>? nutritions;
  bool? available;

  Food();

  Food.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      categoryId = jsonMap['category_id'].toString();
      name = jsonMap['name'];
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      discountPrice = jsonMap['discount_price'] != null ? jsonMap['discount_price'].toDouble() : 0.0;
      // price = discountPrice != 0 ? discountPrice : price;
      // discountPrice = discountPrice == 0 ? discountPrice : jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
       description = jsonMap['description'];
      ingredients = jsonMap['ingredients'];
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      unit = jsonMap['unit'] != null ? jsonMap['unit'].toString() : '';
      packageItemsCount = jsonMap['package_items_count'].toString();
      featured = jsonMap['featured'] ?? false;
      available = jsonMap['available'] ?? false;
      deliverable = jsonMap['deliverable'] ?? false;
      restaurant = jsonMap['restaurant'] != null ? Restaurant.fromJSON(jsonMap['restaurant']) : Restaurant.fromJSON({});
      category = jsonMap['category'] != null ? Category.fromJSON(jsonMap['category']) : Category.fromJSON({});
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      extras = jsonMap['extras'] != null && (jsonMap['extras'] as List).length > 0
          ? List.from(jsonMap['extras']).map((element) => Extra.fromJSON(element)).toSet().toList()
          : [];
      extraGroups = jsonMap['extra_groups'] != null && (jsonMap['extra_groups'] as List).length > 0
          ? List.from(jsonMap['extra_groups']).map((element) => ExtraGroup.fromJSON(element)).toSet().toList()
          : [];
      foodReviews = jsonMap['food_reviews'] != null && (jsonMap['food_reviews'] as List).length > 0
          ? List.from(jsonMap['food_reviews']).map((element) => Review.fromJSON(element)).toSet().toList()
          : [];
      nutritions = jsonMap['nutrition'] != null && (jsonMap['nutrition'] as List).length > 0
          ? List.from(jsonMap['nutrition']).map((element) => Nutrition.fromJSON(element)).toSet().toList()
          : [];
    } catch (e) {
      id = '';
      categoryId = '';
      name = '';
      price = 0.0;
      discountPrice = 0.0;
      description = '';
      weight = '';
      ingredients = '';
      unit = '';
      packageItemsCount = '';
      featured = false;
      available = false;
      deliverable = false;
      restaurant = Restaurant.fromJSON({});
      category = Category.fromJSON({});
      image = new Media();
      extras = [];
      extraGroups = [];
      foodReviews = [];
      nutritions = [];
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map<String, dynamic>  toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["discount_price"] = discountPrice;
    map["description"] = description;
    map["ingredients"] = ingredients;
    map["weight"] = weight;
    map["available"] = available;
    map["featured"] = featured;
    map["deliverable"] = deliverable;
    map["category_id"] = categoryId;
    map["extras"] = extras!.map((element) => element.id).toList();
    return map;
  }

  double getRate() {
    double _rate = 0;
    foodReviews!.forEach((e) => _rate += double.parse(e.rate!));
    _rate = _rate > 0 ? (_rate / foodReviews!.length) : 0;
    return _rate;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
