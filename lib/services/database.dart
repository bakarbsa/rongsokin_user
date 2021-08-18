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
    String newDocumentId = '';
    await db.collection('requests').doc('0latestDocumentId').get().then((value) {
      if(value.data()!.length > 0) {
        latestDocumentId = value.data()!["documentId"];
        newDocumentId = (latestDocumentId+1).toString();
        iteratePhoto(listBarang, newDocumentId, lokasi, total);
      } else {
        print('document id not found');
      }
    });

    await db.collection('requests').doc('0latestDocumentId').update({
      'documentId' : latestDocumentId+1
    });

    await db.collection('requests').doc(newDocumentId).set({
      'documentId' : newDocumentId,
      'userId' : uid,
      'userPengepulId' : null,
      'diambil' : false,
      'selesai' : false,
      'total' : total,
      'lokasi' : lokasi,
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

  //finish request
  Future finishRequest(String documentId) async{
    await db.collection('requests').doc(documentId).update({
      'selesai' : true
    });
  }
}