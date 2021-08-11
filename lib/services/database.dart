// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //initialize firestore
  var db = FirebaseFirestore.instance;
  final username = '';

  Future createUserData(String username, String address, Timestamp birthDate, String phoneNumber) async {
    db.collection("users").doc(uid).set({
      'username' : username,
      'address' : address,
      'birthDate' : birthDate,
      'phoneNumber' : phoneNumber,
      'totalTransaction' : 0,
      'poin' : 0
    });
  }

  Future<DocumentSnapshot> getUsers(String id) async {
    return await db.collection("users").doc(id).get();
  }

  Future createTransaction() async{
    db.collection("transactions").doc().collection("detailBarang").doc("elektronik").set({
      'listBarang' : [
        {
          'namaBarang' : 'Handphone Bekas'
        },
        {
          'namaBarang' : 'Monitor Bekas'
        }
      ]
    });
    // db.collection("transactions").doc().set(
    //   {
    //     'userId' : uid,
    //     'userPengepulId' : null,
    //     'diambil' : false,
    //     'elektronik' : [
    //       for (var entry in eventTask.entries) {          
    //         'id' : entry.key,
    //         'value' : entry.value
    //       }
    //     ],
    //     // 'elektronik' : [
    //     //   {
    //     //     'handphoneBekas' : true,
    //     //     'berat' : 2
    //     //   },
    //     //   {
    //     //     'monitorBekas' : true,
    //     //     'berat' : 2
    //     //   }
    //     // ],
    //     // 'plastik' : [
    //     //   {
    //     //     'botolMineral' : true,
    //     //     'berat' : 1
    //     //   }
    //     // ],
    //     // 'kertas' : '',
    //     // 'kaca' : '',
    //     // 'logam' : '',
    //     // 'kain' : ''
    //   }
    // );
  }
}