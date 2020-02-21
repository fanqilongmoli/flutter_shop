import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/util/utils.dart';
import 'package:flutter_shop/widgets/app_bar.dart';
import 'package:flutter_shop/widgets/my_button.dart';
import 'package:flutter_shop/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
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

  _register() {
    Toast.show('点击注册');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          key: Key('register'),
          isBack: true,
          title: '注册',
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? KeyboardActions(
                config: Utils.getKeyboardActionsConfig(
                    context, [_nodeText1, _nodeText2, _nodeText3]),
                child: _buildBody(),
              )
            : SingleChildScrollView(
                child: _buildBody(),
              ));
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text('请开启你的账号', style: TextStyles.textBold26),
          ),
          Gaps.vGap16,
          MyTextField(
            key: Key('phone'),
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: '请输入手机号',
            focusNode: _nodeText1,
          ),
          Gaps.vGap8,
          MyTextField(
            key: Key('vcode'),
            controller: _vCodeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: '请输入验证码',
            focusNode: _nodeText2,
            getVCode: () async {
              if (_nameController.text.length == 11) {
                Toast.show('请求验证码成功');
                return true;
              } else {
                Toast.show('请输入正确的手机号');
                return false;
              }
            },
          ),
          Gaps.vGap8,
          MyTextField(
              key: Key('password'),
              controller: _passwordController,
              maxLength: 6,
              keyboardType: TextInputType.visiblePassword,
              hintText: '请输入密码',
              focusNode: _nodeText3,
              isInputPwd: true),
          Gaps.vGap8,
          Gaps.vGap8,
          MyButton(
            onPressed: _isClick ? _register : null,
            text: '注册',
          )
        ],
      ),
    );
  }
}
