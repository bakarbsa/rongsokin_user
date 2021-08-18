import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/screens/home/home.dart';
import 'package:rongsokin_user/services/database.dart';

var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');
class Confirmation extends StatefulWidget {
  const Confirmation({
    Key? key,
    required this.documentId,
    required this.userPengepulId,
    required this.total,
  }) : super(key: key);

  final String documentId;
  final String userPengepulId;
  final num total;

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Konfirmasi Akhir'),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async{
          final user = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : null;
          await DatabaseService(uid: user?.uid ?? null).finishRequest(widget.documentId);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return Home();
          }));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total :',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${currency.format(widget.total)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Detail User Text
            Text(
              'DETAIL PENGEPUL',
              style: TextStyle(
                color: Color(0xFF163570),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            //Detail User Container
            Stack(
              alignment: Alignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                    .collection('usersPengepul')
                    .doc(widget.userPengepulId)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (snapshot.data as dynamic)["username"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        (snapshot.data as dynamic)["phoneNumber"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              Flexible(
                                child: Text(
                                  'Menunggu Pengepul Memproses...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Text('Loading...'),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'DETAIL BARANG',
              style: TextStyle(
                color: Color(0xFF163570),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('requests')
                  .doc(widget.documentId)
                  .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: (snapshot.data as dynamic)["listBarang"].length,
                      itemBuilder: (context, index) {
                        return ItemListCard(
                          index : index,
                          kategori : (snapshot.data as dynamic)["listBarang"][index]["kategori"],
                          namaBarang: (snapshot.data as dynamic)["listBarang"][index]["namaBarang"],
                          deskripsi: (snapshot.data as dynamic)["listBarang"][index]["deskripsi"],
                          harga: (snapshot.data as dynamic)["listBarang"][index]["harga"],
                          berat: (snapshot.data as dynamic)["listBarang"][index]["berat"],
                          fotoBarang : (snapshot.data as dynamic)["listBarang"][index]["fotoBarang"],
                          total: (snapshot.data as dynamic)["total"]
                        );
                      },
                    );
                  }
                  return Center(
                    child: Text('Loading...'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemListCard extends StatefulWidget {
  const ItemListCard({
    Key? key,
    required this.index,
    required this.kategori,
    required this.namaBarang,
    required this.deskripsi,
    required this.berat,
    required this.harga,
    required this.fotoBarang,
    required this.total
  }) : super(key: key);

  final int index;
  final String kategori;
  final String namaBarang;
  final String deskripsi;
  final int berat;
  final int harga;
  final String fotoBarang;
  final num total;

  @override
  _ItemListCardState createState() => _ItemListCardState();
}

class _ItemListCardState extends State<ItemListCard> {
  var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.fotoBarang,),
                        fit: BoxFit.cover, 
                      )
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.namaBarang,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.deskripsi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Berat : ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.berat.toString() + ' Kg',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Text(
                    '${currency.format(widget.harga)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
