import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/models/category.dart';
import '../controllers/food_controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/app_config.dart' as config;

class AddFoodWidget extends StatefulWidget {
  AddFoodWidget({Key? key}) : super(key: key);

  @override
  _AddFoodWidgetState createState() => _AddFoodWidgetState();
}

class _AddFoodWidgetState extends StateMVC<AddFoodWidget> {
  late FoodController _con;

  _AddFoodWidgetState() : super(FoodController()) {
    _con = controller as FoodController;
  }

  @override
  void initState() {
    _con.listenForExtras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          S.of(context).add_New_Food,
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
      key: _con.scaffoldKey,
      // resizeToAvoidBottomInset: false,
      body: _con.loading
          ? CircularLoadingWidget(
              height: 500,
            )
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(88),
                child: Form(
                  key: _con.foodFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 130,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                _con.image != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(300)),
                                        child: Image.file(
                                          _con.image!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(300)),
                                        child: CachedNetworkImage(
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              'http://localhost:2222/images/image_default.png',
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                            height: 120,
                                            width: 120,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      onPressed: () => _showPicker(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.food.name = input!.trim(),
                        maxLength: 30,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: S.of(context).please_enter_Field),
                        ]),
                        decoration: InputDecoration(
                          labelText: S.of(context).food_name,
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).food_name,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.fastfood,
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            _con.food.description = input!.trim(),
                        maxLength: 60,
                        decoration: InputDecoration(
                          labelText: S.of(context).description,
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: S.of(context).description,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.description,
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
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
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
                        value: _con.selectedCategory,
                        items: _con.Categories.map(
                          (item) {
                            return DropdownMenuItem(
                              value: item,
                              child: new Text(item.name!),
                            );
                          },
                        ).toList(),
                        isExpanded: true,
                        validator: (value) =>
                            value == null ? '???????????? ???????????? ??????????' : null,
                        hint: Text('???????????? ???????????? ??????????'),
                        onChanged: (Category? value) {
                          _con.food.categoryId = value!.id;
                          _con.onChangeDropdownCategoryItem(value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            _con.food.price = double.tryParse(input!.trim()),
                        maxLength: 5,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: S.of(context).please_enter_Field),
                        ]),
                        decoration: InputDecoration(
                          labelText: S.of(context).price,
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: "10.5",
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: '0',
                        onSaved: (input) => _con.food.discountPrice =
                            double.tryParse(input!.trim()),
                        maxLength: 5,
                        decoration: InputDecoration(
                          labelText: S.of(context).discountPrice,
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '8.25',
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
                      Row(
                        children: [
                          Checkbox(
                            value: _con.isDefault,
                            onChanged: (value) => _con.defaultAddress(),
                            activeColor: Theme.of(context).accentColor,
                          ),
                          Text(
                            S.of(context).featuredFoods,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _con.extras.isEmpty
                          ? SizedBox()
                          : Text(
                              S.of(context).extras,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .merge(TextStyle(color: Colors.black)),
                            ),
                      SizedBox(height: 20),
                      _con.extras.isEmpty
                          ? SizedBox()
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.extras.length,
                              itemBuilder: (context, index) {
                                var _extra = _con.extras.elementAt(index);

                                return Row(
                                  children: [
                                    Checkbox(
                                      value:
                                          _con.extras.elementAt(index).checked,
                                      onChanged: (value) => setState(() {
                                        _con.extras.elementAt(index).checked =
                                            !_con.extras
                                                .elementAt(index)
                                                .checked!;
                                      }),
                                      activeColor:
                                          Theme.of(context).accentColor,
                                    ),
                                    Text(
                                      _extra.name!,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 5);
                              },
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
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 4, left: 4, top: 8, bottom: 8),
                            child: Text(
                              S.of(context).save,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          onPressed: () {
                            _con.addNewFood();
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(
                        S.of(context).Gallery,
                      ),
                      onTap: () {
                        _con.imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                      S.of(context).Camera,
                    ),
                    onTap: () {
                      _con.imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
