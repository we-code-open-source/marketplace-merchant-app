import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/repository/firebase_notification.dart';
import '../models/confirm_reset_code.dart';
import '../models/reset_password.dart';
import '../models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  ConfirmResetCode confirmResetCode= new ConfirmResetCode();
  ResetPassword resetPass= new ResetPassword();
  final codeController = TextEditingController();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
 // FirebaseMessaging? _firebaseMessaging;
  OverlayEntry? loader;

  int counter = 60;
  Timer? _timer;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (counter == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            counter--;
          });
        }
      },
    );
  }
  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    //_firebaseMessaging = FirebaseMessaging.instance;
    PushNotificationService.instance.getDeviceToken().then((String? _deviceToken) {
      user.device_token = _deviceToken;
    }).catchError((e) {
      print('Notification not configured');
    });
  }
  void addNewUser() async {
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();
      if (loginFormKey!.currentState!.validate()) {
        loginFormKey!.currentState!.save();
          Overlay.of(state!.context)!.insert(loader!);
          await repository.addUser(user).then((value) {
            if (value.id!=null) {
              Navigator.of(scaffoldKey!.currentContext!).pushReplacementNamed(
                  '/Pages', arguments: 1);
              ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(
                  SnackBar(
                    content: Text(S
                        .of(state!.context)
                        .new_User_added_successfully),
                  ));
            }
          }
          ).catchError((e) {
            loader!.remove();
            ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(
                SnackBar(
                  content: Text(e),
                ));
          }).whenComplete(() {
            Helper.hideLoader(loader!);
          });

      }
  }

  void login() async {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      repository.login(user).then((value) {
        if(repository.statusCode.value==401){
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text('لم يتم تفعيل الحساب الرجاء الانتظار الي حين تفعيله'),
          ));
        }else if(repository.statusCode.value==403){
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text("لقد تم اقاف حسابك"),
          ));
        }
        else if (repository.statusCode.value==200) {
          Navigator.of(scaffoldKey!.currentContext!).pushReplacementNamed('/Pages', arguments: 0);
        } else  if (repository.statusCode.value==422) {
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text(S.of(state!.context).wrong_phone_or_password),
          ));
        }
      }).catchError((e) {
        loader!.remove();
        ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text(S.of(state!.context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });
    }
  }

  void reSendCode(phone) {
    print(repository.numOfReq.value);
    counter = 60;
    if(repository.numOfReq.value<3){
      loader = Helper.overlayLoader(state!.context);
      FocusScope.of(state!.context).unfocus();

      Overlay.of(state!.context)!.insert(loader!);
      repository.checkPhoneRegister(phone).then((value) {
        if (value != null && value == true) {
          startTimer();
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text('تم ارسال الرسالة بنجاح'),
          ));
        } else {
          loader!.remove();
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text("هنالك مشكلة في الشبكة"),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });

    }else ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
      content: Text("حاول في وقت أخر"),
    ));
  }

  void checkPhoneRegister() {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      repository.checkPhoneRegister(user.phone!).then((value) {
        if (value != null && value == true) {
          Navigator.of(state!.context).pushNamed('/code',arguments: RouteArgument(
              id: '0',
              param: {
                'title':S.of(state!.context).verification_code ,
                'type': 'register',
                'phone':user.phone
              }));
        } else {
          loader!.remove();
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text(S.of(state!.context).phone_number_not_found),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });
    }
  }
  void confirmRegister() {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    confirmResetCode.code=codeController.text;
    Overlay.of(state!.context)!.insert(loader!);
    repository.ConfirmRegister(confirmResetCode).then((value) {
      if (value != null ) {
        Navigator.of(state!.context).pushReplacementNamed('/SignUp',arguments: RouteArgument(
            id: '0',
            param: {
              'token':value,
              'phone':confirmResetCode.phone_number
            }));
      } else {
        loader!.remove();
        ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text("code not sending"),
        ));
      }
    }).whenComplete(() {
      Helper.hideLoader(loader!);
    });
  }
  void register() async {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      repository.register(user).then((value) async {
        if (repository.statusCode.value==200) {
          Navigator.of(scaffoldKey!.currentContext!).pushReplacementNamed('/Login');
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text("لقد تم استلام بياناتك سيتم اخبارك فور قبولك"),
          ));
        } else {
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text("للاسف هنالك خطأ!"),
          ));
        }
      }).catchError((e) {
        loader!.remove();
        ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text(S.of(state!.context).this_phone_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });
    }
  }
  void checkPhoneResetPassword() {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      repository.checkPhoneResetPassword(user.phone!).then((value) async {
        if (value != null && value) {
          Navigator.of(state!.context).pushNamed('/code',arguments: RouteArgument(
              id: '0',
              param: {
                'title':S.of(state!.context).verification_code ,
                'type': 'pass',
                'phone':user.phone
              }));
        }
      }).catchError((e) {
        loader!.remove();
        ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text(S.of(state!.context).phone_number_not_found),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });
    }
  }
  void confirmReset() {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    confirmResetCode.code=codeController.text;
    Overlay.of(state!.context)!.insert(loader!);
    repository.ConfirmResetVerificationCode(confirmResetCode).then((value) {
      if (value != null ) {
        Navigator.of(state!.context).pushReplacementNamed('/ResetPassword',arguments: RouteArgument(
            id: '0',
            param: {
              'token':value
            }));
      } else {
        loader!.remove();
        ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
          content: Text("code not sending"),
        ));
      }
    }).whenComplete(() {
      Helper.hideLoader(loader!);
    });

  }
  void resetPassword() {
    loader = Helper.overlayLoader(state!.context);
    FocusScope.of(state!.context).unfocus();
    if (loginFormKey!.currentState!.validate()) {
      loginFormKey!.currentState!.save();
      Overlay.of(state!.context)!.insert(loader!);
      repository.resetPassword(resetPass).then((value) {
        if (value != null && value) {

          Navigator.of(state!.context).pushReplacementNamed('/Login');
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text(S.of(state!.context).reset_password_success),
          ));
        } else {
          loader!.remove();
          ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
            content: Text("Error"),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader!);
      });
    }
  }
}
