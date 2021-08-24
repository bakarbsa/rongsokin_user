import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/screens/transaction/confirmation.dart';
import 'package:rongsokin_user/services/database.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () async {
            final user = FirebaseAuth.instance.currentUser;
            dynamic result = await DatabaseService(uid: user?.uid).cancelRequest(documentId);
            if(result == 'dibatalkan berhasil') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                return Home();
              }));
            }
          },
          child: Container(
            height: 60,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xFFEA5252),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Batalkan Transaksi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection("requests")
          .doc(documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if((snapshot.data as dynamic)["diambil"]) {
              WidgetsBinding.instance!.addPostFrameCallback(
                (_) => Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) => Confirmation(
                      documentId: documentId,
                      userPengepulId: (snapshot.data as dynamic)["userPengepulId"],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/loading_pengepul.png'),
                      SizedBox(height: 10),
                      Text(
                        'Mencari Pengepul...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Center(
            child: Text('loading...'),
          );
        }
      ),
    );
  }
}
