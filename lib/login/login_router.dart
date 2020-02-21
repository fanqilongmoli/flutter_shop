import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/login/page/login_page.dart';
import 'package:flutter_shop/login/page/register_page.dart';
import 'package:flutter_shop/routers/router_init.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';

  @override
  void initRouter(Router router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (context, parameters) => LoginPage()));
    router.define(registerPage,
        handler: Handler(handlerFunc: (context, parameters) => RegisterPage()));
  }
}
