import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_navBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';

class DefaultContentPage extends StatelessWidget {
  const DefaultContentPage(
      {Key? key, required this.content, required this.title})
      : super(key: key);

  final Widget content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(title),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: content,
        ),
      ),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.home),
    );
  }
}
