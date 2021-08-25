import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/screens/transaction/confirmation.dart';

class WaitingPengepul extends StatelessWidget {
  const WaitingPengepul({ 
    Key? key,
    required this.documentId
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('requests')
          .doc(documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if((snapshot.data as dynamic)['status'] == 'dikonfirmasi pengepul') {
              WidgetsBinding.instance!.addPostFrameCallback(
                (_) => Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) => Confirmation(
                      documentId: documentId,
                      userPengepulId: (snapshot.data as dynamic)["userPengepulId"],
                    )
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Menunggu Pengepul Memilih Barang...')
                ],
              ),
            );
          }
          return Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }
      ),
    );
  }
}