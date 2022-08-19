import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_owner/generated/l10n.dart';
import 'package:food_delivery_owner/src/controllers/restaurant_controller.dart';
import 'package:food_delivery_owner/src/elements/CircularLoadingWidget.dart';
import 'package:food_delivery_owner/src/models/route_argument.dart';
import 'package:food_delivery_owner/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/helper.dart';
import '../models/food.dart';

class FoodItem extends StatelessWidget {
  final String? heroTag;
  final Food? food;

  const FoodItem({Key? key, this.food, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return food!.available!
        ? InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Food',
            arguments: RouteArgument(id: food!.id, heroTag: this.heroTag));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag! + food!.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: food!.image!.thumb!,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          food!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Row(
                          children: Helper.getStarsList(food!.getRate()),
                        ),
                        Text(
                          food!.extras!
                              .map((e) => e.name)
                              .toList()
                              .join(', '),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Helper.getPrice(
                        food!.price,
                        context,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      food!.discountPrice! > 0
                          ? Helper.getPrice(food!.discountPrice, context,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .merge(TextStyle(
                              decoration:
                              TextDecoration.lineThrough)))
                          : SizedBox(height: 0),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )
        : Container();
  }
}
