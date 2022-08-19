import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/controllers/user_controller.dart';
import '../controllers/food_controller.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/app_config.dart' as config;

class AddUserWidget extends StatefulWidget {
  AddUserWidget({Key? key}) : super(key: key);

  @override
  _AddUserWidgetState createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends StateMVC<AddUserWidget> {
  UserController? _con;

  _AddUserWidgetState() : super(UserController()) {
    _con = controller as UserController?;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title:Text(
          S.of(context).add_New_User,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .merge(TextStyle(color: Theme.of(context).primaryColor)),
        ) ,
        leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.of(context).pop();

            }),
      ),
      key: _con!.scaffoldKey,
     // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
              child:Container(
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
                key: _con!.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con!.user.name = input!.trim(),
                      maxLength: 30,
                      validator: MultiValidator([
                        RequiredValidator(errorText: S.of(context).please_enter_Field),

                      ]),
                      decoration: InputDecoration(
                        labelText: S.of(context).username,
                        labelStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: S.of(context).john_doe,
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.account_circle,
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
                      keyboardType: TextInputType.number,
                      onSaved: (input) => _con!.user.phone = input!.substring(1),
                      maxLength: 10,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Please enter phone number"),
                        MinLengthValidator(10,
                            errorText:
                            S.of(context).should_be_more_than_10_letters),
                        PatternValidator(
                          r'^(09?(9[0-9]{8}))$',
                          errorText: S.of(context).not_a_valid_phone,
                        )
                      ]),
                      decoration: InputDecoration(
                        labelText: S.of(context).phone,
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: S.of(context).phone_ex,
                        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con!.user.password = input,
                      validator: (input) => input!.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                      obscureText: _con!.hidePassword,
                      decoration: InputDecoration(
                        labelText: S.of(context).password,
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: '••••••••••••',
                        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _con!.hidePassword = !_con!.hidePassword;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(_con!.hidePassword ? Icons.visibility : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      ),
                    ),

                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (input) => _con!.user.email = input,
                      validator: (input) => !input!.contains('@') ? S.of(context).should_be_a_valid_email : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'me@gmail.com',
                        hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
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
      _con!.addNewUser();
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
