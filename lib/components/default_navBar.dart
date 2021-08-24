import 'package:flutter/material.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/screens/history/history_list.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/screens/profile/profile.dart';
// import 'package:rongsokin_user/screens/transaction/select_item_screen.dart';

class DefaultNavBar extends StatelessWidget {
  const DefaultNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveColor = Color(0xFF757575);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 8,
              blurRadius: 10,
              offset: Offset(0, 5)),
        ],
      ),
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: MenuState.home == selectedMenu
                  ? kPrimaryColor
                  : inActiveColor,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) {
                return Home();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.receipt_long,
                color: MenuState.transaction == selectedMenu
                    ? kPrimaryColor
                    : inActiveColor),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HistoryList();
              }));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: MenuState.profile == selectedMenu
                  ? kPrimaryColor
                  : inActiveColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
          ),
        ],
      )),
    );
  }
}
