import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:rongsokin_user/services/auth.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  // final AuthService _auth = AuthService();
  List<Map<String, String>> listBarang = [];
  // final listBarang = Map<String,String>();
  // Map<String, String> map = new HashMap<String, String>();
  // map.put("key1", "value1");
  // map.put("key2", "value2");
  // map.put("key3", "value3");

  // System.out.println("using entrySet and toString");
  // for (Entry<String, String> entry : map.entrySet()) {
  //     System.out.println(entry);
  // }
  // System.out.println();
  // List<Map>? elektronik;
  @override
  Widget build(BuildContext context) {
    // Map<String, String> map = {
    //   'a': 'lala',
    //   'b': 'lala',
    // };

    // map['c'] = 'lala';  // {a: 1, b: 2, c: 3}
    // List<Map<String, String>> map2 = [
    //   map,
    //   map
    // ];
    listBarang.add(
      {'kategori': 'elektronik', 'namaBarang': 'handphone bekas'},
    );

    listBarang.add(
      {'kategori': 'elektronik', 'namaBarang': 'Monitor Bekas'},
    );

    listBarang.add(
      {'kategori': 'plastik', 'namaBarang': 'botol mineral'},
    );
    // listBarang[0] = {
    //   'kategori': 'elektronik',
    //   'namaBarang' : 'handphone bekas'
    // };
    // listBarang[1] = {
    //   'kategori': 'elektronik',
    //   'namaBarang' : 'monitor bekas'
    // };

    // listBarang[2] = {
    //   'kategori': 'plastik',
    //   'namaBarang' : 'botol mineral'
    // };
    // listBarang = [{'kategori': 'elektronik'}];
    // listBarang['kategori'] = 'elektronik';
    // listBarang['namaBarang'] = 'HandPhone Bekas';
    final _transactionsStream = FirebaseFirestore.instance
        .collection('transactions')
        .doc('Npic1KRK5MhMi8g1L26G')
        .snapshots();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            child: Text('upload'),
            onPressed: () async {
              // await _auth.createTransaction(listBarang);
            },
          ),
        ),
        StreamBuilder(
            stream: _transactionsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: (snapshot.data as dynamic)["listBarang"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Text((snapshot.data as dynamic)["listBarang"][index]["namaBarang"]),
                        ],
                      );
                    },
                  ),
                );
                // final dataArray = (snapshot.data as dynamic)["listBarang"];
                // for (var key in dataArray) {
                //   print(dataArray[key][["namaBarang"]]);
                // }
                // for(var i = 0; i < (snapshot.data as dynamic)["listBarang"].length; i++) {
                //   // print((snapshot.data as dynamic)["listBarang"][i]["namaBarang"]);
                //   // print(listBarang);
                // }
                // return Column(
                //   children: [
                //     Text((snapshot.data as dynamic)["userPengepulId"]),
                //     Text((snapshot.data as dynamic)["listBarang"][0]["namaBarang"]),
                //   ],
                // );
              }
              return Text('loading...');
            })
      ],
    );
  }
}
