import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/helpers/helper.dart';
import 'package:food_delivery_owner/src/models/extra_group.dart';
import 'package:food_delivery_owner/src/models/food.dart';
import 'package:food_delivery_owner/src/models/route_argument.dart';
import '../controllers/food_controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class EditExtraWidget extends StatefulWidget {
  final RouteArgument?  routeArgument;

  EditExtraWidget({Key? key, this.routeArgument}) : super(key: key);

  @override
  _EditExtraWidgetState createState() => _EditExtraWidgetState();
}

class _EditExtraWidgetState extends StateMVC<EditExtraWidget> {
  FoodController? _con;

  _EditExtraWidgetState() : super(FoodController()) {
    _con = controller as FoodController?;
  }

  @override
  void initState() {

    _con!.extra = widget.routeArgument!.param['extra'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          S.of(context).update_Extra,
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
          width: config.App(context).appWidth(88),
          child: Form(
            key: _con!.extraFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 10),
                TextFormField(
                  initialValue: _con!.extra.name,
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con!.extra.name = input!.trim(),
                  maxLength: 30,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: S.of(context).please_enter_Field),
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).extras,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).hint_extra,
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.add_circle,
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
                  initialValue: _con!.extra.description,
                  keyboardType: TextInputType.text,
                  onSaved: (input) =>
                      _con!.extra.description = input!.substring(1),
                  maxLength: 60,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: S.of(context).please_enter_Field),
                  ]),
                  decoration: InputDecoration(
                    labelText: S.of(context).description,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: S.of(context).hint_description_extra,
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
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    // labelText: labelText,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0XFF5CAA95).withOpacity(.38))),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0XFF5CAA95).withOpacity(.38))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0XFF5CAA95).withOpacity(.38))),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0XFF5CAA95).withOpacity(.38))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0XFF5CAA95).withOpacity(.38))),
                  ),
                  value: _con!.selectedExtraGroup,
                  items: _con!.ExtraGroups.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: new Text(item.name!),
                      );
                    },
                  ).toList(),
                  isExpanded: true,
                  hint: _con!.extra.extraGroup!.name != null
                      ?Text( _con!.extra.extraGroup!.name!)
                      : Text('الرجاء اختيار المجموعة الذي تنتمي اليها الاضافة'),
                  onChanged: (ExtraGroup? value) {
                    _con!.extra.extraGroupId = value!.id;
                    _con!.onChangeDropdownExtraGroupItem(value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _con!.extra.price.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con!.extra.price = double.tryParse(input!),
                  decoration: InputDecoration(
                    labelText: S.of(context).price,
                    labelStyle: TextStyle(color: Theme.of(context).accentColor),
                    contentPadding: EdgeInsets.all(12),
                    hintText: '1.0',
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.7)),
                    prefixIcon:
                        Icon(Icons.money, color: Theme.of(context).accentColor),
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
                      _con!.updateExtraFood();
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


}
