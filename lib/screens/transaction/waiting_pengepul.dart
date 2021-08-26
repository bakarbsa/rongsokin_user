import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/screens/transaction/confirmation.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> _splitName = [];
String namaUser = '';
class WaitingPengepul extends StatelessWidget {
  const WaitingPengepul({ 
    Key? key,
    required this.documentId,
    required this.userId
  }) : super(key: key);

  final String documentId;
  final String userId;

  String? splitUsername(String username) {
    _splitName.addAll(username.split(" "));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        backgroundColor: kPrimaryColor,
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
              // alignment: Alignment.center,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      splitUsername((snapshot.data as dynamic)["username"]);
                      namaUser = (snapshot.data as dynamic)["username"];
                      return Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 5, bottom: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _splitName.length <= 1 ?
                                    _splitName[0] :
                                    _splitName[0] + ' ' + _splitName[1],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _splitName.length <= 1 ? 20 : 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      launch('tel:${(snapshot.data as dynamic)["phoneNumber"]}');
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Flexible(
                                child: Text(
                                  'Pengepul Akan Menuju Ke Tempat Anda Maksimal Pukul 15:00 WIB, silakan menunggu...',
                                  textAlign: TextAlign.center,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  child: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            StreamBuilder(
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
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child:Image.asset('assets/images/waiting_pengepul.png'),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            'Menunggu Pengepul \nMemilih Barang...',
                            style: kHeaderText,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
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
          ]
        )
      ) 
    );
  }
}