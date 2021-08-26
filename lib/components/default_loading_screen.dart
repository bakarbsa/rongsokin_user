import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/screens/transaction/loading.dart';

class DefaultLoading extends StatefulWidget {
  const DefaultLoading({ 
    Key? key,
    required this.documentId
  }) : super(key: key);

  final String documentId;

  @override
  State<DefaultLoading> createState() => _DefaultLoadingState();
}

class _DefaultLoadingState extends State<DefaultLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: Image.asset('assets/images/upload_berkas.png'),
            ),
            SizedBox(height: 20,),
            Text(
              'Data Barangmu\nsedang di upload ya!',
              textAlign: TextAlign.center,
              style: kHeaderText,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                .collection('requests')
                .doc(widget.documentId)
                .snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  if((snapshot.data as dynamic)['uploadFotoSelesai'] == true) {
                    WidgetsBinding.instance!.addPostFrameCallback(
                      (_) => Navigator.pushReplacement(context,
                        MaterialPageRoute(
                          builder: (context) => Loading(documentId: widget.documentId)
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                  // for (var i = 0; i < (snapshot.data as dynamic)["listBarang"].length; i++) {
                  //   uploadGambarSelesai.add(false);
                  // }
                  // for (var i = 0; i < (snapshot.data as dynamic)["listBarang"].length; i++) {
                  //   if((snapshot.data as dynamic)["listBarang"][i] != '') {
                  //     WidgetsBinding.instance!.addPostFrameCallback(
                  //       (_) => setState(() {
                  //         uploadGambarSelesai[i] = true;
                  //       })
                  //     );
                  //   } 
                  // }

                  // if(uploadGambarSelesai.contains(false)) {
                  //   return Container();
                  // } else {
                  //   WidgetsBinding.instance!.addPostFrameCallback(
                  //     (_) => Navigator.pushReplacement(context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Loading(documentId: widget.documentId)
                  //       ),
                  //     ),
                  //   );
                  // }
                }
                return Container();
              } 
            ),
          ],
        ),
      ),
    );
  }
}