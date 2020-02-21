import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/res/resources.dart';
import 'package:flutter_shop/util/theme_utils.dart';
import 'package:flutter_shop/util/toast.dart';
import 'package:flutter_shop/widgets/app_bar.dart';
import 'package:flutter_shop/widgets/select_image.dart';
import 'package:flutter_shop/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

///店铺审核页面
class StoreAuditPage extends StatefulWidget {
  @override
  _StoreAuditPageState createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {
  File _imageFile;
  FocusNode _nodeText1 = FocusNode();
  FocusNode _nodeText2 = FocusNode();
  FocusNode _nodeText3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '店铺审核资料',
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? KeyboardActions(
                        tapOutsideToDismiss: true, //键盘外部按下将其关闭
                        config: _buildConfig(context),
                        child: _buildBody(),
                      )
                    : SingleChildScrollView(
                        child: _buildBody(),
                      ))
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      setState(() {});
    } catch (e) {
      Toast.show('没有权限，无法打开相机');
    }
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        children: <Widget>[
          Gaps.vGap5,
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              '店铺资料',
              style: TextStyles.textBold18,
            ),
          ),
          Gaps.vGap16,
          Center(
            child: SelectedImage(
              image: _imageFile,
              onTap: _getImage,
            ),
          ),
          Gaps.vGap5,
          Center(
            child: Text(
              '店主手持身份证或营业执照',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(title: '店铺名称',hintText: '填写店铺名称',focusNode: _nodeText1)
        ],
      ),
    );
  }

  _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
        nextFocus: true,
        actions: [
          KeyboardAction(focusNode: _nodeText1, displayDoneButton: false),
          KeyboardAction(focusNode: _nodeText2, displayDoneButton: false),
          KeyboardAction(focusNode: _nodeText3, toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text('关闭'),
                ),
              );
            }
          ])
        ]);
  }
}
