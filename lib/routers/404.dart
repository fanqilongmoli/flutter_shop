import 'package:flutter/material.dart';

//import 'package:flutter_deer/widgets/app_bar.dart';
//import 'package:flutter_deer/widgets/state_layout.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('页面存在'),
      ),
      body: Center(
        child: Text('404页面'),
      ),
    );
  }
}
