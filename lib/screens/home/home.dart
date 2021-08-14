import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_appBar.dart';
import 'package:rongsokin_user/components/default_content_page.dart';
import 'package:rongsokin_user/components/default_navBar.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/enums.dart';
import 'package:rongsokin_user/screens/home/list_articles.dart';
import 'package:rongsokin_user/screens/transaction/select_item_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get data from firebase
    final user = FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : null;
    var db = FirebaseFirestore.instance;
    final dataProfileUser =
        db.collection("users").doc(user?.uid ?? null).snapshots();
        
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: kPrimaryColor),
      bottomNavigationBar: DefaultNavBar(selectedMenu: MenuState.home),
      body: SingleChildScrollView(
        child: Column(
          children: [
            user == null ? Container() : StreamBuilder(
              stream: dataProfileUser,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Selamat Datang, \n ' + (snapshot.data as dynamic)["username"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                elevation: 10,
                                child: Container(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width - 70,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.black,
                                              size: 70,
                                            ),
                                            SizedBox(width: 5),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Rongsok Poinmu',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.account_balance_wallet,
                                                      color: kPrimaryColor,
                                                      size: 28,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      (snapshot.data as dynamic)["poin"].toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 3),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                                'assets/images/withdraw.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Center(
                  child: Text('Loading...'),
                );
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                children: [
                  // Rongsokin Barang Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectItemScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        height: 110,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Rongsokin\nBarang',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image(
                                image:
                                    AssetImage('assets/images/icon_barrow.png'),
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Comunity Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        launch('http://rongsok-in.com/');
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 5),
                        height: 110,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Komunitas\nKami',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.groups,
                                color: Colors.white,
                                size: 60,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Kenali kami Lebih Dekat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFCA311),
                          Color(0xFFFFBA48),
                          Color(0xFFFFD082),
                          Color(0xFFFFDDA6),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ListImage(
                      assetImage: 'assets/images/cara_penggunaan_aplikasi.png',
                      content: kenaliLebihDekat()
                    ),
                    SizedBox(width: 10),
                    ListImage(
                      assetImage: 'assets/images/cerita_kami.png',
                      content: Container(
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: Image.asset('assets/images/cerita_kami.png'),
                            ),
                            Text('Do ad est laborum commodo.Eu dolor et pariatur aliqua.')
                          ],
                        ),
                      ),  
                    ),
                    SizedBox(width: 10),
                    ListImage(
                      assetImage: 'assets/images/jenis_sampah.png',
                      content: Container(
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: Image.asset('assets/images/jenis_sampah.png'),
                            ),
                            Text('Do ad est laborum commodo.Eu dolor et pariatur aliqua.')
                          ],
                        ),
                      ),  
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Artikel hari ini',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFCA311),
                          Color(0xFFFFBA48),
                          Color(0xFFFFD082),
                          Color(0xFFFFDDA6),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ListArticles()
            )
          ],
        ),
      ),
    );
  }

  Container kenaliLebihDekat() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: ExactAssetImage('assets/images/muhammad_adib_afkari.png'),
              radius: 80,    
            ),
            Column(
              children: [
                Text('Muhammad adib Afkari', style: kSubHeaderText,),
                Text('Chief Executife Officer', style: kParagraphText,),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/annisyah_amelia.png'),
                      radius: 70,
                    ),
                    Text('Annisyah Amelia F.', style: kSubHeaderText,),
                    Text('Art and Design Director', style: kParagraphText,)
                  ],
                ),    
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/cellerina_yollanda.png'),
                      radius: 70,
                    ),
                    Text('Cellerina Yolanda E.', style: kSubHeaderText,),
                    Text('Marketing and Finance\nDirector', style: kParagraphText,textAlign: TextAlign.center,)
                  ],
                )            
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/shafira_cahyasakti.png'),
                      radius: 70,
                    ),
                    Text('Shafira Cahyasakti', style: kSubHeaderText,),
                    Text('Research and development\ndirector', style: kParagraphText,textAlign: TextAlign.center,),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/images/farid_cenreng.png'),
                      radius: 70,
                    ),
                    Text('Farid Cenreng', style: kSubHeaderText,),
                    Text('Technical and\nMaintenance Director', style: kParagraphText,textAlign: TextAlign.center,),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    Key? key,
    required this.assetImage,
    required this.content
  }) : super(key: key);

  final String assetImage;
  final Container content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return DefaultContentPage(content: content);
        }));
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetImage)
          ),
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
