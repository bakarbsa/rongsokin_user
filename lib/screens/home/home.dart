import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                     ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
