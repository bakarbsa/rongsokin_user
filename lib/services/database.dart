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

  //tambah transaction
  Future createTransaction(List<Map<String, dynamic>> listBarang) async{
    // documentReference = db.collection('newTransaction').doc('detailNewTransaction');    
    for (var i = 0; i < listBarang.length; i++) {
      await addTransactionPhoto(listBarang[i]["fotoBarang"], i, listBarang);
    }
    
    // for (var i = 0; i < listBarang.length; i++) {
    //   print(downloadUrl[i]);
    // }
    await db.collection('newTransaction').doc('detailNewTransaction').set({
      'userId' : uid,
      'userPengepulId' : null,
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'harga' : listBarang[i]["harga"],
          'berat' : listBarang[i]["berat"],
          'fotoBarang' : null,
        }
      ],
    });
    // db.collection("newTransaction").doc('detailNewTransaction').set({
    //   'userId' : uid,
    //   'userPengepulId' : null,
    //   'diambil' : false,
    //   'listBarang' : listBarang,
    // });
  }

  //tambah foto transaction
  Future addTransactionPhoto(File imageFile, int index, List<Map<String, dynamic>> listBarang) async {
    //ambil nama file dari path file
    // String fileName = basename(imageFile.path);
    // //tentukan path file di firebase storage
    // FirebaseStorage storage = FirebaseStorage.instance;
    // Reference ref = storage.ref().child(fileName + DateTime.now().toString());
    // //upload ke firebase storage
    // UploadTask uploadTask = ref.putFile(imageFile);
    // // dapatkan gambar yang sudah diupload
    // String? downloadUrl;
    // uploadTask.then((res) async{
    //   downloadUrl = await res.ref.getDownloadURL();
    // });
    // return downloadUrl!;
    // dapatkan gambar yang sudah diupload
    
    // uploadTask.then((res) async{
    //   return await res.ref.getDownloadURL();
    // });
    String fileName = basename(imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(imageFile);
    uploadTask.whenComplete(() async{
      downloadUrl.add(await ref.getDownloadURL());
      updateUrlPhoto(await ref.getDownloadURL(), index, listBarang);
    }).catchError((onError) {
      print(onError);
    });
    // return downloadUrl[index];

  }

  Future updateUrlPhoto(String url, int index, List<Map<String, dynamic>> listBarang) async{
    await db.collection('newTransaction').doc('detailNewTransaction').update({
      'userId' : uid,
      'userPengepulId' : null,
      'listBarang' : [
        for (var i = 0; i < listBarang.length; i++) {
          'kategori' : listBarang[i]["kategori"],
          'namaBarang' : listBarang[i]["namaBarang"],
          'deskripsi' : listBarang[i]["deskripsi"],
          'harga' : listBarang[i]["harga"],
          'berat' : listBarang[i]["berat"],
          'fotoBarang' : url,
        }
      ],
    });
  }
}