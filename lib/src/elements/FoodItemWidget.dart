import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/route_argument.dart';

import '../helpers/helper.dart';
import '../models/food.dart';

class FoodItemWidget extends StatelessWidget {
  final String? heroTag;
  final Food? food;
  final Function(bool value)? onTap;

  const FoodItemWidget({Key? key, this.food, this.heroTag, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        IconButton(
            icon: new Icon(Icons.edit, color: Theme.of(context).accentColor),
            onPressed: () {
              Navigator.of(context).pushNamed('/EditFood',
                  arguments: RouteArgument(id: '0', param: {'food': food}));
            }),
        Flexible(
          child: SwitchListTile(
            title: Text(food!.name ?? ' '),
            subtitle:food!.discountPrice==0? Helper.getPrice(food!.price, context,
                style: Theme.of(context).textTheme.caption)
                :Helper.getPrice(food!.discountPrice, context,
                style: Theme.of(context).textTheme.caption),
            value: food!.available ?? false,
            onChanged: (value) => onTap!(value),
            secondary: Hero(
              tag: heroTag! + food!.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: food!.image!.url!,
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
          ),
        ),
      ],
    ));
  }
}
