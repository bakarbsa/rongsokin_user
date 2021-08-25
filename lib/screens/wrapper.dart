import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_loading_screen.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/screens/sign_in/sign_in.dart';
import 'package:rongsokin_user/screens/transaction/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went error'),
            );
          } else if (snapshot.hasData) {
            return Home();
            // return DefaultLoading();
            // return Loading(documentId: 'r00000037');
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
