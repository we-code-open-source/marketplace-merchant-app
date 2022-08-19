// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();

  static S? current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current!;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Food name`
  String get food_name {
    return Intl.message(
      'Food name',
      name: 'food_name',
      desc: '',
      args: [],
    );
  }

  /// `Add New Food`
  String get add_New_Food {
    return Intl.message(
      'Add New Food',
      name: 'add_New_Food',
      desc: '',
      args: [],
    );
  }

  /// `Add New User`
  String get add_New_User {
    return Intl.message(
      'Add New User',
      name: 'add_New_User',
      desc: '',
      args: [],
    );
  }

  /// `Add New Extra`
  String get add_New_Extra {
    return Intl.message(
      'Add New Extra',
      name: 'add_New_Extra',
      desc: '',
      args: [],
    );
  }

  /// `update  Food`
  String get update_Food {
    return Intl.message(
      'Update Food',
      name: 'update_Food',
      desc: '',
      args: [],
    );
  }

  /// `update  Extra`
  String get update_Extra {
    return Intl.message(
      'Update Extra',
      name: 'update_Extra',
      desc: '',
      args: [],
    );
  }

  /// `update  restaurant`
  String get update_restaurant {
    return Intl.message(
      'Update Restaurant',
      name: 'update_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred languages`
  String get select_your_preferred_languages {
    return Intl.message(
      'Select your preferred languages',
      name: 'select_your_preferred_languages',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get order_id {
    return Intl.message(
      'Order Id',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Payment Mode`
  String get payment_mode {
    return Intl.message(
      'Payment Mode',
      name: 'payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Foods`
  String get favorite_foods {
    return Intl.message(
      'Favorite Foods',
      name: 'favorite_foods',
      desc: '',
      args: [],
    );
  }

  /// `Extras`
  String get extras {
    return Intl.message(
      'Extras',
      name: 'extras',
      desc: '',
      args: [],
    );
  }

  /// `Faq`
  String get faq {
    return Intl.message(
      'Faq',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Help & Supports`
  String get help_supports {
    return Intl.message(
      'Help & Supports',
      name: 'help_supports',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get app_language {
    return Intl.message(
      'App Language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `I forgot password ?`
  String get i_forgot_password {
    return Intl.message(
      'I forgot password ?',
      name: 'i_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `I don't have an account?`
  String get i_dont_have_an_account {
    return Intl.message(
      'I don\'t have an account?',
      name: 'i_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `TAX`
  String get tax {
    return Intl.message(
      'TAX',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash_on_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Recent Orders`
  String get recent_orders {
    return Intl.message(
      'Recent Orders',
      name: 'recent_orders',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile Settings`
  String get profile_settings {
    return Intl.message(
      'Profile Settings',
      name: 'profile_settings',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `processingTime`
  String get processing_time {
    return Intl.message(
      'Processing Time',
      name: 'processing_time',
      desc: '',
      args: [],
    );
  }

  /// `processingTimeEX`
  String get processing_time_ex {
    return Intl.message(
      '10 min',
      name: 'processing_time_ex',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `ReasonEX`
  String get reason_ex {
    return Intl.message(
      'No food available',
      name: 'reason_ex',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone_1 {
    return Intl.message(
      'Phone 1',
      name: 'phone_1',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone_2 {
    return Intl.message(
      'Phone 2',
      name: 'phone_2',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get app_settings {
    return Intl.message(
      'App Settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with register!`
  String get lets_start_with_register {
    return Intl.message(
      'Let\'s Start with register!',
      name: 'lets_start_with_register',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 letters`
  String get should_be_more_than_3_letters {
    return Intl.message(
      'Should be more than 3 letters',
      name: 'should_be_more_than_3_letters',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get john_doe {
    return Intl.message(
      'John Doe',
      name: 'john_doe',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Should be a valid email`
  String get should_be_a_valid_email {
    return Intl.message(
      'Should be a valid email',
      name: 'should_be_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 6 letters`
  String get should_be_more_than_6_letters {
    return Intl.message(
      'Should be more than 6 letters',
      name: 'should_be_more_than_6_letters',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `I have account? Back to login`
  String get i_have_account_back_to_login {
    return Intl.message(
      'I have account? Back to login',
      name: 'i_have_account_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Order`
  String get tracking_order {
    return Intl.message(
      'Tracking Order',
      name: 'tracking_order',
      desc: '',
      args: [],
    );
  }

  /// `Discover & Explorer`
  String get discover__explorer {
    return Intl.message(
      'Discover & Explorer',
      name: 'discover__explorer',
      desc: '',
      args: [],
    );
  }

  /// `Reset Cart?`
  String get reset_cart {
    return Intl.message(
      'Reset Cart?',
      name: 'reset_cart',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Verify your quantity and click checkout`
  String get verify_your_quantity_and_click_checkout {
    return Intl.message(
      'Verify your quantity and click checkout',
      name: 'verify_your_quantity_and_click_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with Login!`
  String get lets_start_with_login {
    return Intl.message(
      'Let\'s Start with Login!',
      name: 'lets_start_with_login',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 characters`
  String get should_be_more_than_3_characters {
    return Intl.message(
      'Should be more than 3 characters',
      name: 'should_be_more_than_3_characters',
      desc: '',
      args: [],
    );
  }

  /// `You must add foods of the same restaurants choose one restaurants only!`
  String get you_must_add_foods_of_the_same_restaurants_choose_one {
    return Intl.message(
      'You must add foods of the same restaurants choose one restaurants only!',
      name: 'you_must_add_foods_of_the_same_restaurants_choose_one',
      desc: '',
      args: [],
    );
  }

  /// `Reset your cart and order meals form this restaurant`
  String get reset_your_cart_and_order_meals_form_this_restaurant {
    return Intl.message(
      'Reset your cart and order meals form this restaurant',
      name: 'reset_your_cart_and_order_meals_form_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Keep your old meals of this restaurant`
  String get keep_your_old_meals_of_this_restaurant {
    return Intl.message(
      'Keep your old meals of this restaurant',
      name: 'keep_your_old_meals_of_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `Application Preferences`
  String get application_preferences {
    return Intl.message(
      'Application Preferences',
      name: 'application_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help__support {
    return Intl.message(
      'Help & Support',
      name: 'help__support',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `D'ont have any item in your cart`
  String get dont_have_any_item_in_your_cart {
    return Intl.message(
      'D\'ont have any item in your cart',
      name: 'dont_have_any_item_in_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `Start Exploring`
  String get start_exploring {
    return Intl.message(
      'Start Exploring',
      name: 'start_exploring',
      desc: '',
      args: [],
    );
  }

  /// `D'ont have any item in the notification list`
  String get dont_have_any_item_in_the_notification_list {
    return Intl.message(
      'D\'ont have any item in the notification list',
      name: 'dont_have_any_item_in_the_notification_list',
      desc: '',
      args: [],
    );
  }

  /// `Payment Settings`
  String get payment_settings {
    return Intl.message(
      'Payment Settings',
      name: 'payment_settings',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid number`
  String get not_a_valid_number {
    return Intl.message(
      'Not a valid number',
      name: 'not_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid date`
  String get not_a_valid_date {
    return Intl.message(
      'Not a valid date',
      name: 'not_a_valid_date',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid CVC`
  String get not_a_valid_cvc {
    return Intl.message(
      'Not a valid CVC',
      name: 'not_a_valid_cvc',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid full name`
  String get not_a_valid_full_name {
    return Intl.message(
      'Not a valid full name',
      name: 'not_a_valid_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid email`
  String get not_a_valid_email {
    return Intl.message(
      'Not a valid email',
      name: 'not_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid phone`
  String get not_a_valid_phone {
    return Intl.message(
      'Not a valid phone',
      name: 'not_a_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Order`
  String get confirm_order {
    return Intl.message(
      'Confirm Order',
      name: 'confirm_order',
      desc: '',
      args: [],
    );
  }

  /// `Customer details`
  String get customer_details {
    return Intl.message(
      'Customer details',
      name: 'customer_details',
      desc: '',
      args: [],
    );
  }

  /// `Detect location`
  String get detect_location {
    return Intl.message(
      'Detect location',
      name: 'detect_location',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid address`
  String get not_a_valid_address {
    return Intl.message(
      'Not a valid address',
      name: 'not_a_valid_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid biography`
  String get not_a_valid_biography {
    return Intl.message(
      'Not a valid biography',
      name: 'not_a_valid_biography',
      desc: '',
      args: [],
    );
  }

  /// `Your biography`
  String get your_biography {
    return Intl.message(
      'Your biography',
      name: 'your_biography',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get your_address {
    return Intl.message(
      'Your Address',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Recents Search`
  String get recents_search {
    return Intl.message(
      'Recents Search',
      name: 'recents_search',
      desc: '',
      args: [],
    );
  }

  /// `Verify your internet connection`
  String get verify_your_internet_connection {
    return Intl.message(
      'Verify your internet connection',
      name: 'verify_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Carts refreshed successfully`
  String get carts_refreshed_successfuly {
    return Intl.message(
      'Carts refreshed successfully',
      name: 'carts_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successfully submitted!`
  String get your_order_has_been_successfully_submitted {
    return Intl.message(
      'Your order has been successfully submitted!',
      name: 'your_order_has_been_successfully_submitted',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message(
      'My Orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `The {foodname} was removed from your cart`
  String the_food_was_removed_from_your_cart(Object foodname) {
    return Intl.message(
      'The $foodname was removed from your cart',
      name: 'the_food_was_removed_from_your_cart',
      desc: '',
      args: [foodname],
    );
  }

  /// `Category refreshed successfully`
  String get category_refreshed_successfuly {
    return Intl.message(
      'Category refreshed successfully',
      name: 'category_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Notifications refreshed successfully`
  String get notifications_refreshed_successfuly {
    return Intl.message(
      'Notifications refreshed successfully',
      name: 'notifications_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Order refreshed successfully`
  String get order_refreshed_successfuly {
    return Intl.message(
      'Order refreshed successfully',
      name: 'order_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Extras refreshed successfully`
  String get extras_refreshed_successfuly {
    return Intl.message(
      'Extras refreshed successfully',
      name: 'extras_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Orders refreshed successfully`
  String get orders_refreshed_successfuly {
    return Intl.message(
      'Orders refreshed successfully',
      name: 'orders_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant refreshed successfully`
  String get restaurant_refreshed_successfuly {
    return Intl.message(
      'Restaurant refreshed successfully',
      name: 'restaurant_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings updated successfully`
  String get profile_settings_updated_successfully {
    return Intl.message(
      'Profile settings updated successfully',
      name: 'profile_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment settings updated successfully`
  String get payment_settings_updated_successfully {
    return Intl.message(
      'Payment settings updated successfully',
      name: 'payment_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Tracking refreshed successfully`
  String get tracking_refreshed_successfuly {
    return Intl.message(
      'Tracking refreshed successfully',
      name: 'tracking_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get wrong_email_or_password {
    return Intl.message(
      'Wrong email or password',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Addresses refreshed successfuly`
  String get addresses_refreshed_successfuly {
    return Intl.message(
      'Addresses refreshed successfuly',
      name: 'addresses_refreshed_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Addresses`
  String get delivery_addresses {
    return Intl.message(
      'Delivery Addresses',
      name: 'delivery_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Discount Price`
  String get discountPrice {
    return Intl.message(
      'Discount Price',
      name: 'discountPrice',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImage {
    return Intl.message(
      'Upload Image',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone_ex {
    return Intl.message(
      '09XXXXXXXX',
      name: 'phone_ex',
      desc: '',
      args: [],
    );
  }

  /// `Garlic sauce with lemon`
  String get hint_description_extra {
    return Intl.message(
      'Garlic sauce with lemon',
      name: 'hint_description_extra',
      desc: '',
      args: [],
    );
  }

  /// `Garlic sauce`
  String get hint_extra {
    return Intl.message(
      'Garlic sauce',
      name: 'hint_extra',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 10 letters`
  String get should_be_more_than_10_letters {
    return Intl.message(
      'Should be more than 10 letters',
      name: 'should_be_more_than_10_letters',
      desc: '',
      args: [],
    );
  }

  /// `Phone to reset password`
  String get phone_to_reset_password {
    return Intl.message(
      'Phone to reset password',
      name: 'phone_to_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Wrong phone or password`
  String get wrong_phone_or_password {
    return Intl.message(
      'Wrong phone or password',
      name: 'wrong_phone_or_password',
      desc: '',
      args: [],
    );
  }

  /// `This account not exist`
  String get this_account_not_exist {
    return Intl.message(
      'This account not exist',
      name: 'this_account_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verification_code {
    return Intl.message(
      'Verification code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `This phone account exists`
  String get this_phone_account_exists {
    return Intl.message(
      'This phone account exists',
      name: 'this_phone_account_exists',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password Success`
  String get reset_password_success {
    return Intl.message(
      'Reset Password Success',
      name: 'reset_password_success',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not found`
  String get phone_number_not_found {
    return Intl.message(
      'Phone number not found',
      name: 'phone_number_not_found',
      desc: '',
      args: [],
    );
  }

  /// `please_enter_phone_number`
  String get please_enter_phone_number {
    return Intl.message(
      'Please enter phone number',
      name: 'please_enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `please_enter_name`
  String get please_enter_name {
    return Intl.message(
      'Please enter customer name',
      name: 'please_enter_name',
      desc: '',
      args: [],
    );
  }

  /// `please_enter_address`
  String get please_enter_address {
    return Intl.message(
      'Please enter address',
      name: 'please_enter_address',
      desc: '',
      args: [],
    );
  }

  /// `please_enter_delivery_fee`
  String get please_enter_delivery_fee {
    return Intl.message(
      'Please enter delivery fee',
      name: 'please_enter_delivery_fee',
      desc: '',
      args: [],
    );
  }

  /// `send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Phone to reset password`
  String get reset_new_password {
    return Intl.message(
      'Reset new password',
      name: 'reset_new_password',
      desc: '',
      args: [],
    );
  }

  /// `No Food`
  String get no_foods {
    return Intl.message(
      'No Food',
      name: 'no_foods',
      desc: '',
      args: [],
    );
  }

  /// `No Extra`
  String get no_extras {
    return Intl.message(
      'No Extra',
      name: 'no_extras',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get foods {
    return Intl.message(
      'Food',
      name: 'foods',
      desc: '',
      args: [],
    );
  }

  /// `please_enter_new_password`
  String get please_enter_new_password {
    return Intl.message(
      'Please enter new password',
      name: 'please_enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Field`
  String get please_enter_Field {
    return Intl.message(
      'Please enter Field',
      name: 'please_enter_Field',
      desc: '',
      args: [],
    );
  }

  /// `New Address added successfully`
  String get new_address_added_successfully {
    return Intl.message(
      'New Address added successfully',
      name: 'new_address_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `New Food added successfully`
  String get new_Food_added_successfully {
    return Intl.message(
      'New Food added successfully',
      name: 'new_Food_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `New User added successfully`
  String get new_User_added_successfully {
    return Intl.message(
      'New User added successfully',
      name: 'new_User_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `New Extra added successfully`
  String get new_Extra_added_successfully {
    return Intl.message(
      'New Extra added successfully',
      name: 'new_Extra_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  String get change_password_successfully {
    return Intl.message(
      'Change password successfully',
      name: 'change_password_successfully',
      desc: '',
      args: [],
    );
  }

  String get the_current_password_error {
    return Intl.message(
      'The current password error',
      name: 'the_current_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Updated food successfully`
  String get updated_food_successfully {
    return Intl.message(
      'Updated food successfully',
      name: 'updated_food_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Updated Restaurant successfully`
  String get updated_restaurant_successfully {
    return Intl.message(
      'Updated Restaurant successfully',
      name: 'updated_restaurant_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your image`
  String get please_enter_your_image {
    return Intl.message(
      'Please enter your image',
      name: 'please_enter_your_image',
      desc: '',
      args: [],
    );
  }

  /// `The address updated successfully`
  String get the_address_updated_successfully {
    return Intl.message(
      'The address updated successfully',
      name: 'the_address_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Long press to edit item, swipe item to delete it`
  String get long_press_to_edit_item_swipe_item_to_delete_it {
    return Intl.message(
      'Long press to edit item, swipe item to delete it',
      name: 'long_press_to_edit_item_swipe_item_to_delete_it',
      desc: '',
      args: [],
    );
  }

  /// `Add Delivery Address`
  String get add_delivery_address {
    return Intl.message(
      'Add Delivery Address',
      name: 'add_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get home_address {
    return Intl.message(
      'Home Address',
      name: 'home_address',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `12 Street, City 21663, Country`
  String get hint_full_address {
    return Intl.message(
      '12 Street, City 21663, Country',
      name: 'hint_full_address',
      desc: '',
      args: [],
    );
  }

  /// `Full Address`
  String get full_address {
    return Intl.message(
      'Full Address',
      name: 'full_address',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  String get restaurant {
    return Intl.message(
      'Restaurant',
      name: 'restaurant',
      desc: '',
      args: [],
    );
  }

  String get restaurant_name {
    return Intl.message(
      'Restaurant Name',
      name: 'restaurant_name',
      desc: '',
      args: [],
    );
  }

  String get restaurantAddress {
    return Intl.message(
      'Restaurant Address',
      name: 'restaurantAddress',
      desc: '',
      args: [],
    );
  }

  String get Acceptance {
    return Intl.message(
      'Acceptance',
      name: 'Acceptance',
      desc: '',
      args: [],
    );
  }

  String get reject {
    return Intl.message(
      'reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Would you please confirm if you have delivered all meals to client`
  String get would_you_please_confirm_if_you_have_delivered_all_meals {
    return Intl.message(
      'Would you please confirm if you have delivered all meals to client',
      name: 'would_you_please_confirm_if_you_have_delivered_all_meals',
      desc: '',
      args: [],
    );
  }

  /// `Would you please confirm if you want to save changes`
  String get Would_you_please_confirm_if_you_want_to_save_changes {
    return Intl.message(
      'Would you please confirm if you want to save changes',
      name: 'Would_you_please_confirm_if_you_want_to_save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Confirmation`
  String get delivery_confirmation {
    return Intl.message(
      'Delivery Confirmation',
      name: 'delivery_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Foods Ordered`
  String get foods_ordered {
    return Intl.message(
      'Foods Ordered',
      name: 'foods_ordered',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Address not provided please call the client`
  String get address_not_provided_please_call_the_client {
    return Intl.message(
      'Address not provided please call the client',
      name: 'address_not_provided_please_call_the_client',
      desc: '',
      args: [],
    );
  }

  /// `Address not provided contact client`
  String get address_not_provided_contact_client {
    return Intl.message(
      'Address not provided contact client',
      name: 'address_not_provided_contact_client',
      desc: '',
      args: [],
    );
  }

  /// `Orders History`
  String get orders_history {
    return Intl.message(
      'Orders History',
      name: 'orders_history',
      desc: '',
      args: [],
    );
  }

  /// `Email to reset password`
  String get email_to_reset_password {
    return Intl.message(
      'Email to reset password',
      name: 'email_to_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Send link`
  String get send_password_reset_link {
    return Intl.message(
      'Send link',
      name: 'send_password_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `I remember my password return to login`
  String get i_remember_my_password_return_to_login {
    return Intl.message(
      'I remember my password return to login',
      name: 'i_remember_my_password_return_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Your reset link has been sent to your email`
  String get your_reset_link_has_been_sent_to_your_email {
    return Intl.message(
      'Your reset link has been sent to your email',
      name: 'your_reset_link_has_been_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Error! Verify email settings`
  String get error_verify_email_settings {
    return Intl.message(
      'Error! Verify email settings',
      name: 'error_verify_email_settings',
      desc: '',
      args: [],
    );
  }

  /// `Order status changed`
  String get order_satatus_changed {
    return Intl.message(
      'Order status changed',
      name: 'order_satatus_changed',
      desc: '',
      args: [],
    );
  }

  /// `New Order from costumer`
  String get new_order_from_costumer {
    return Intl.message(
      'New Order from costumer',
      name: 'new_order_from_costumer',
      desc: '',
      args: [],
    );
  }

  /// `Your have an order assigned to you`
  String get your_have_an_order_assigned_to_you {
    return Intl.message(
      'Your have an order assigned to you',
      name: 'your_have_an_order_assigned_to_you',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Ordered Foods`
  String get ordered_foods {
    return Intl.message(
      'Ordered Foods',
      name: 'ordered_foods',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get delivery_fee {
    return Intl.message(
      'Delivery Fee',
      name: 'delivery_fee',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any order assigned to you!`
  String get you_dont_have_any_order_assigned_to_you {
    return Intl.message(
      'You don\'t have any order assigned to you!',
      name: 'you_dont_have_any_order_assigned_to_you',
      desc: '',
      args: [],
    );
  }

  /// `Swipe left the notification to delete or read / unread it`
  String get swip_left_the_notification_to_delete_or_read__unread {
    return Intl.message(
      'Swipe left the notification to delete or read / unread it',
      name: 'swip_left_the_notification_to_delete_or_read__unread',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get km {
    return Intl.message(
      'Km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `mi`
  String get mi {
    return Intl.message(
      'mi',
      name: 'mi',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `This account not exist`
  String get thisAccountNotExist {
    return Intl.message(
      'This account not exist',
      name: 'thisAccountNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Tap back again to leave`
  String get tapBackAgainToLeave {
    return Intl.message(
      'Tap back again to leave',
      name: 'tapBackAgainToLeave',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Total Earnings`
  String get totalEarning {
    return Intl.message(
      'Total Earnings',
      name: 'totalEarning',
      desc: '',
      args: [],
    );
  }

  /// `Total Orders`
  String get totalOrders {
    return Intl.message(
      'Total Orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Total Restaurants`
  String get totalRestaurants {
    return Intl.message(
      'Total Restaurants',
      name: 'totalRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Company ratio`
  String get company_ratio {
    return Intl.message(
      'Company ratio',
      name: 'company_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Total Foods`
  String get totalFoods {
    return Intl.message(
      'Total Foods',
      name: 'totalFoods',
      desc: '',
      args: [],
    );
  }

  /// `My Restaurants`
  String get myRestaurants {
    return Intl.message(
      'My Restaurants',
      name: 'myRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Featured Foods`
  String get featuredFoods {
    return Intl.message(
      'Featured Foods',
      name: 'featuredFoods',
      desc: '',
      args: [],
    );
  }

  /// `Featured `
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  String get Gallery {
    return Intl.message(
      'Gallery',
      name: 'Gallery',
      desc: '',
      args: [],
    );
  }

  String get Camera {
    return Intl.message(
      'Camera',
      name: 'Camera',
      desc: '',
      args: [],
    );
  }

  /// `What They Say ?`
  String get whatTheySay {
    return Intl.message(
      'What They Say ?',
      name: 'whatTheySay',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order of customer ?`
  String get areYouSureYouWantToCancelThisOrderOf {
    return Intl.message(
      'Are you sure you want to cancel this order of customer ?',
      name: 'areYouSureYouWantToCancelThisOrderOf',
      desc: '',
      args: [],
    );
  }

  /// `Edit Order`
  String get editOrder {
    return Intl.message(
      'Edit Order',
      name: 'editOrder',
      desc: '',
      args: [],
    );
  }

  /// `Add Order`
  String get addOrder {
    return Intl.message(
      'Add Order',
      name: 'addOrder',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addUser {
    return Intl.message(
      'Add User',
      name: 'addUser',
      desc: '',
      args: [],
    );
  }

  /// `Click on the food to get more details about it`
  String get clickOnTheFoodToGetMoreDetailsAboutIt {
    return Intl.message(
      'Click on the food to get more details about it',
      name: 'clickOnTheFoodToGetMoreDetailsAboutIt',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Select extras to add them on the food`
  String get select_extras_to_add_them_on_the_food {
    return Intl.message(
      'Select extras to add them on the food',
      name: 'select_extras_to_add_them_on_the_food',
      desc: '',
      args: [],
    );
  }

  /// `Deliverable`
  String get deliverable {
    return Intl.message(
      'Deliverable',
      name: 'deliverable',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message(
      'Nutrition',
      name: 'nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `This food was added to cart`
  String get this_food_was_added_to_cart {
    return Intl.message(
      'This food was added to cart',
      name: 'this_food_was_added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `This order updated successfully`
  String get thisOrderUpdatedSuccessfully {
    return Intl.message(
      'This order updated successfully',
      name: 'thisOrderUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Assign Delivery Boy`
  String get assignDeliveryBoy {
    return Intl.message(
      'Assign Delivery Boy',
      name: 'assignDeliveryBoy',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get generalInformation {
    return Intl.message(
      'General Information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Hint`
  String get hint {
    return Intl.message(
      'Hint',
      name: 'hint',
      desc: '',
      args: [],
    );
  }

  /// `Insert an additional information for this order`
  String get insertAnAdditionalInformationForThisOrder {
    return Intl.message(
      'Insert an additional information for this order',
      name: 'insertAnAdditionalInformationForThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order: #{id} has been canceled`
  String orderIdHasBeenCanceled(Object id) {
    return Intl.message(
      'Order: #$id has been canceled',
      name: 'orderIdHasBeenCanceled',
      desc: '',
      args: [id],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any conversations`
  String get youDontHaveAnyConversations {
    return Intl.message(
      'You don\'t have any conversations',
      name: 'youDontHaveAnyConversations',
      desc: '',
      args: [],
    );
  }

  /// `New message from`
  String get newMessageFrom {
    return Intl.message(
      'New message from',
      name: 'newMessageFrom',
      desc: '',
      args: [],
    );
  }

  /// `Type to start chat`
  String get typeToStartChat {
    return Intl.message(
      'Type to start chat',
      name: 'typeToStartChat',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as read`
  String get thisNotificationHasMarkedAsRead {
    return Intl.message(
      'This notification has marked as read',
      name: 'thisNotificationHasMarkedAsRead',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as un read`
  String get thisNotificationHasMarkedAsUnRead {
    return Intl.message(
      'This notification has marked as un read',
      name: 'thisNotificationHasMarkedAsUnRead',
      desc: '',
      args: [],
    );
  }

  /// `Notification was removed`
  String get notificationWasRemoved {
    return Intl.message(
      'Notification was removed',
      name: 'notificationWasRemoved',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
