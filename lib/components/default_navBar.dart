import 'package:flutter/material.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/screens/profile/profile.dart';
import 'package:rongsokin_user/screens/transaction/select_item_screen.dart';

class DefaultNavBar extends StatelessWidget {
  const DefaultNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    : inActiveIconColor,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return Home();
                }));
              },
            ),
            IconButton(
              icon: Icon(Icons.receipt_long,
                  color: MenuState.transaction == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return SelectItemScreen();
                }));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: MenuState.profile == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Profile();
                }));
              },
            ),
          ],
        )
      ),
    );
  }
}
