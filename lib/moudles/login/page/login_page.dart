import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/common/common.dart';
import 'package:flutter_shop/moudles/login/login_router.dart';
import 'package:flutter_shop/moudles/store/store_router.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/routers/fluro_navigator.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/util/utils.dart';
import 'package:flutter_shop/widgets/app_bar.dart';
import 'package:flutter_shop/widgets/my_button.dart';
import 'package:flutter_shop/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isClick = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
  }

  // 校验
  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            isBack: false,
            actionName: '验证码登录',
            onPressed: () {
              Toast.show("点击验证码登录");
            }),
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? KeyboardActions(
                config: Utils.getKeyboardActionsConfig(
                    context, [_nodeText1, _nodeText2]),
                child: _buildBody())
            : SingleChildScrollView(child: _buildBody()));
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('密码登录', style: TextStyles.textBold26),
          Gaps.vGap16,
          MyTextField(
            key: Key('phone'),
            controller: _nameController,
            focusNode: _nodeText1,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: '请输入账号',
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            isInputPwd: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: '请输入密码',
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: Key('login'),
            onPressed: _isClick ? _login : null,
            text: '登陆',
          ),
          Container(
            height: 40,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () {
                Toast.show('忘记密码');
              },
            ),
          ),
          Gaps.vGap16,
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: Text(
                '还没有账号？快去注册',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                NavigatorUtils.push(context, LoginRouter.registerPage);
              },
            ),
          )
        ],
      ),
    );
  }

  void _login() {
    FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
    NavigatorUtils.push(context, StoreRouter.auditPage);
  }
}
