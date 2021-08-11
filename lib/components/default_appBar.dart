import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final backgroundColor;
  const DefaultAppBar({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);
  
  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: backgroundColor == null ? Colors.white : backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/logo_image.png'),
            width: 42,
          ),
          SizedBox(width: 10),
          Image(
            image: backgroundColor == null 
              ? AssetImage('assets/images/logo_name_black.png') 
              : AssetImage('assets/images/logo_name_white.png')
          ),
        ],
      ),
    );
  }
}
