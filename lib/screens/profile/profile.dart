import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_user/components/default_alert_dialog.dart';
import 'package:rongsokin_user/components/default_navBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/screens/sign_in/sign_in.dart';
import 'package:rongsokin_user/services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //get data from firebase
    final user = FirebaseAuth.instance.currentUser!;
    var db = FirebaseFirestore.instance;
    final dataProfileUser = db.collection("users").doc(user.uid).snapshots();

    //format tanggal lahir
    String? formattedDate(dataBirthDate) {
      dynamic lala = dataBirthDate;
      final birthDate =
          DateTime.fromMicrosecondsSinceEpoch(lala.microsecondsSinceEpoch);
      String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
      return formattedDate;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: dataProfileUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Container(
                  height: 130,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        color: kPrimaryColor,
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: profilePic(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    leading: Text(
                      (snapshot.data as dynamic)["username"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      user.email!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: profileInfo(Icons.location_on_outlined,
                      (snapshot.data as dynamic)["address"]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: profileInfo(Icons.date_range_outlined,
                      formattedDate((snapshot.data as dynamic)["birthDate"])),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: profileInfo(
                      Icons.phone, (snapshot.data as dynamic)["phoneNumber"]),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)))),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShowAlertDialog(
                                    context: context,
                                    alertMessage: "Yakin ingin keluar ?",
                                    press: () async {
                                      await _auth.signOut();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => SignIn()),
                                          (Route<dynamic> route) => false);
                                    });
                              });
                        },
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: Text("loading..."),
          );
        },
      ),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.profile),
    );
  }

  Container profileInfo(leadingIcon, infoText) {
    return Container(
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              leadingIcon,
              color: kPrimaryColor,
            ),
            onPressed: () => {},
          ),
          Padding(padding: EdgeInsets.only(left: 20.0)),
          Text(
            infoText,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    ]));
  }

  SizedBox profilePic() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/profile_image.png')),
        ],
      ),
    );
  }
}
