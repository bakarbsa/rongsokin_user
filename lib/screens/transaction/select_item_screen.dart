import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';

class SelectItemScreen extends StatelessWidget {
  const SelectItemScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
    );
  }
}