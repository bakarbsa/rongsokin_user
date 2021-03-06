import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/components/default_navBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/screens/history/detail_history.dart';
import 'package:rongsokin_user/screens/transaction/confirmation.dart';
import 'package:rongsokin_user/screens/transaction/waiting_pengepul.dart';

var currency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class HistoryList extends StatelessWidget {
  const HistoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get data from firebase
    final user = FirebaseAuth.instance.currentUser != null
        ? FirebaseAuth.instance.currentUser
        : null;

    return Scaffold(
      appBar: DefaultAppBar(),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.transaction),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'RIWAYAT',
                style: TextStyle(
                  color: Color(0xFF1D438A),
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection("requests")
                  .where("userId", isEqualTo: user!.uid)
                  .where("dibatalkan", isEqualTo: false)
                  .orderBy('documentId', descending: true)
                  .snapshots(),
                builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data!.docs.length == 0) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 100,),
                            Icon(Icons.warning_amber_outlined, size: 60, color: Colors.yellow,),
                            SizedBox(height: 50,),
                            Text(
                              'Tidak Ada Riwayat',
                              style: kHeaderText,
                              textAlign: TextAlign.center,
                            ),   
                            SizedBox(height: 200,),
                          ],
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docSnapshot = snapshot.data!.docs[index]; 
                          return InkWell(
                            onTap: () {
                              if(docSnapshot["status"] == 'selesai') {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return DetailHistory(
                                    documentId: docSnapshot["documentId"],
                                    userPengepulId: docSnapshot["userPengepulId"] == null ? 'tidak ada pengepul' : docSnapshot["userPengepulId"],
                                    total: docSnapshot["total"]
                                  );
                                }));
                              } else if(docSnapshot["status"] == 'diproses pengepul') {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return WaitingPengepul(
                                    documentId: docSnapshot["documentId"],
                                    userId: docSnapshot["userId"],
                                  );
                                }));
                              } else if(docSnapshot["status"] == 'dikonfirmasi pengepul') {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return Confirmation(
                                    documentId: docSnapshot["documentId"],
                                    userPengepulId: docSnapshot["userPengepulId"],
                                  );
                                }));
                              }
                            },
                            child: HistoryContent(
                              name: docSnapshot["namaUserPengepul"], 
                              address: docSnapshot["lokasi"], 
                              price: '${currency.format(docSnapshot["total"])}', 
                              date: docSnapshot["tanggal"],
                              status : docSnapshot["status"]
                            )
                          );
                        },
                      );
                    }
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryContent extends StatelessWidget {
  final String name;
  final String address;
  final String price;
  final Timestamp date;
  final String status;

  HistoryContent({
    required this.name,
    required this.address,
    required this.price,
    required this.date,
    required this.status,
  });

  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name == '' ? Text(
                    'Belum Menemukan Pengepul',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  ) : Text(
                    name,
                    style: TextStyle(
                      color: Color(0xFF163570),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    formattedDate(date),
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 3),
                  status == 'selesai' ? Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.green
                    ),
                  ) : Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}