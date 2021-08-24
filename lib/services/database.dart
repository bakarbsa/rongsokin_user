import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //initialize firestore
  var db = FirebaseFirestore.instance;
  final username = '';

  DocumentReference? documentReference;

  List<String> downloadUrl = [];

  //tambah user
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

  //tambah request
  Future createRequest(List<Map<String, dynamic>> listBarang, String lokasi, num total) async{
    int latestDocumentId = 0;  
    int checkDocumentId = 0;  
    String newDocumentId = '';
    await db.collection('requests').doc('0latestDocumentId').get().then((value) {
      if(value.data()!.length > 0) {
        latestDocumentId = value.data()!["documentId"];
        checkDocumentId = latestDocumentId~/10;
        if(checkDocumentId < 1) {
          newDocumentId = 'r0000000' + (latestDocumentId+1).toString();
        }
        if(checkDocumentId > 1 && checkDocumentId < 10) {
          newDocumentId = 'r000000' + (latestDocumentId+1).toString();
        }
        if(checkDocumentId > 10 && checkDocumentId < 100) {
          newDocumentId = 'r00000' + (latestDocumentId+1).toString();
        }
        print(newDocumentId);
        iteratePhoto(listBarang, newDocumentId, lokasi, total);
      } else {
        print('document id not found');
      }
    });

    await db.collection('requests').doc('0latestDocumentId').update({
      'documentId' : latestDocumentId+1
    });
    
    DocumentSnapshot documentUser = await db.collection("users").doc(uid).get();
    dynamic jsonUser = documentUser.data();

    await db.collection('requests').doc(newDocumentId).set({
      'documentId' : newDocumentId,
      'userId' : uid,
      'namaUser' : jsonUser["username"],
      'userPengepulId' : null,
      'namaUserPengepul' : '',
      'diambil' : false,
      'selesai' : false,
      'total' : total,
      'lokasi' : lokasi,
      'dibatalkan' : false,
      'tanggal' : DateTime.now(),
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'check' : false,
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'harga' : listBarang[i]["harga"],
          'hargaPerItem' : listBarang[i]["hargaPerItem"],
          'berat' : listBarang[i]["berat"],
          'fotoBarang' : null,
        }
      ],
    });

    return newDocumentId;
  }

  //iterate semua foto request 
  Future iteratePhoto(List<Map<String, dynamic>> listBarang, String newDocumentId, String lokasi, num total) async{
    print(listBarang);
    for (var i = 0; i < listBarang.length; i++) {
      await addRequestPhoto(listBarang[i]["fotoBarang"], i, listBarang, newDocumentId, lokasi, total);
    }
  }

  //tambah foto request
  Future addRequestPhoto(File imageFile, int index, List<Map<String, dynamic>> listBarang, String newDocumentId, String lokasi, num total) async {
    String fileName = basename(imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(imageFile);
    uploadTask.whenComplete(() async{
      downloadUrl.add(await ref.getDownloadURL());
      updateUrlPhoto(await ref.getDownloadURL(), index, listBarang, newDocumentId, lokasi, total);
    }).catchError((onError) {
      print(onError);
    });
  }

  //tambah link photo ke document firestore
  Future updateUrlPhoto(String url, int index, List<Map<String, dynamic>> listBarang,  String newDocumentId, String lokasi, num total) async{
    await db.collection('requests').doc(newDocumentId).update({
      'documentId' : newDocumentId,
      'userId' : uid,
      'userPengepulId' : null,
      'selesai' : false,
      'total' : total,
      'lokasi' : lokasi,
      'dibatalkan' : false,
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'harga' : listBarang[i]["harga"],
          'hargaPerItem' : listBarang[i]["hargaPerItem"],
          'berat' : listBarang[i]["berat"],
          'fotoBarang' : url,
        }
      ],
    });
  }

  //batalkan request
  Future cancelRequest(String documentId) async {
    await db.collection('requests').doc(documentId).update({
      'dibatalkan' : true
    });
    return 'dibatalkan berhasil';
  }

  //finish request dan tambah point
  Future finishRequest(String documentId, num total) async{
    //finsih request
    await db.collection('requests').doc(documentId).update({
      'selesai' : true
    });

    //ambil data poin user
    DocumentSnapshot documentUser = await FirebaseFirestore.instance.collection('users').doc(uid).get(); 
    dynamic jsonUser = documentUser.data();

    //tambah poin
    await db.collection('users').doc(uid).update({
      'poin' : jsonUser["poin"]+(total~/10) 
    });
  }

  //kasih rating
  Future giveRating(String userPengepulId, num rating) async{
    num ratingResult;
    //ambil data user pengepul
    DocumentSnapshot documentUserPengepul = await FirebaseFirestore.instance.collection('usersPengepul').doc(userPengepulId).get(); 
    dynamic jsonUserPengepul = documentUserPengepul.data();
    //cek banyaknya transaksi 
    num jumlahTransactions = jsonUserPengepul["historyTransactions"].length;
    //hitung rating
    ratingResult = 
    ((jsonUserPengepul["rating"]*(jumlahTransactions == 1 ? jumlahTransactions : jumlahTransactions-1))+rating)/jumlahTransactions;
    //update rating di database  
    await db.collection('usersPengepul').doc(userPengepulId).update({
      'rating' : ratingResult
    });
  }
}