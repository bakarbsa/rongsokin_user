import 'package:flutter/material.dart';
import 'package:rongsokin_user/models/article_models.dart';

class DefaultArticlePage extends StatelessWidget {
  const DefaultArticlePage({ 
    Key? key,
    required this.article,
    required this.id
  }) : super(key: key);

  final Article article;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(420.0),
        child: ListView(
          children: [
            ArticleImage(article: article, id: id),
          ],
        )
      ),
      body: ArticleContent(article: article),
    );
  }
}

class ArticleImage extends StatefulWidget {
  const ArticleImage({
    Key? key,
    required this.article,
    required this.id,
  }) : super(key: key);

  final Article article;
  final int id;
  // final Event event;

  @override
  _ArticleImageState createState() => _ArticleImageState();
}

class _ArticleImageState extends State<ArticleImage> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    // final eventEndDate = DateTime.fromMicrosecondsSinceEpoch(widget.event.data['eventEndDate'].microsecondsSinceEpoch);
    // String formattedDate = DateFormat('dd-MM-yyyy').format(eventEndDate);
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Stack(
              children: [
                // Hero(
                //   tag: widget.id.toString(),
                //   child: Image.asset(widget.article.photoArticle),
                // ),
                Row(
                  children: [
                    SizedBox(
                      height: 70,
                      width: 50,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(right: 20,top: 30),
                      child: Column(
                        children: [
                          Image.asset('assets/icons/share_outline.png'),
                          SizedBox(height: 15,),
                          Image.asset('assets/icons/bookmarks.png'),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter, // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Colors.orange.withOpacity(0.35),
                          Colors.transparent,
                        ], // red to yellow
                        tileMode: TileMode.repeated,
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 75,
                  left: 15,
                  child: Container(
                    width: 120,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 15,
                  child: Text(
                    widget.article.titleArticle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800
                    ),
                  )
                ),
                Positioned(
                  bottom: 20,
                  left: 15,
                  child: Text(
                    'Kesehatan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ),
              ],
            )
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(widget.event.images.length,
        //         (index) => buildSmallProductPreview(index)),
        //   ],
        // )
      ],
    );
  }
}

class ArticleContent extends StatelessWidget {
  const ArticleContent({ 
    Key? key,
    required this.article 
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    // event.whereArrayContains("regions", "west_coast");
    // final eventStartDate = DateTime.fromMicrosecondsSinceEpoch(event.data['eventStartDate'].microsecondsSinceEpoch);
    // final eventEndDate = DateTime.fromMicrosecondsSinceEpoch(event.data['eventEndDate'].microsecondsSinceEpoch);
    // String formattedStartDate = DateFormat('dd MMMM').format(eventStartDate);
    // String formattedEndDate = DateFormat('dd MMMM').format(eventEndDate);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 40.0),
            child: Material(
              color: Colors.white,
              child: TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: 18),
                indicatorWeight: 5,
                indicatorColor: Colors.orange,
                tabs: [
                  Tab(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Pengaju',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                //Detail
                ListView(
                  padding: EdgeInsets.all(18),
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.orange),
                        SizedBox(width: 10),
                        // Text(
                        //   event.data['eventLocation'],
                        //   style: TextStyle(fontSize: 14),
                        // )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.orange),
                        SizedBox(width: 10),
                        // Text(
                        //   formattedStartDate+' - '+formattedEndDate,
                        //   style: TextStyle(fontSize: 14),
                        // )
                      ],
                    ),
                    SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       "assets/icons/Tag.svg",
                    //       height: 20,
                    //       width: 20,
                    //     ),
                    //     SizedBox(width: 10),
                    //     Text(
                    //       event.data['eventPurpose'],
                    //       style: TextStyle(fontSize: 14),
                    //     )
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     RaisedButton(
                    //       child: Text('lalal'),
                    //       onPressed: () async {    
                    //         List names = List.from(event.data['coba']);
                    //         if(names != null) {
                    //           print(names);
                    //         } else {
                    //           print('error');
                    //         }
                    //         // CollectionReference applicationsRef = Firestore.instance.collection("events");
                    //         // DocumentReference applicationIdRef = applicationsRef.document('U26D9MUGQQ3DFWJzZO7u');
                    //         // applicationIdRef.get().then((value) {
                    //         //   if(value.exists) {
                    //         //     print(value.data['eventTask'].toString());
                    //         //   } else {
                    //         //     print('error');
                    //         //   }
                    //         // });
                    //         // List<String> names = List.from(event.data['eventTask'] as Iterable<dynamic>);
                    //         // print(event.data['eventTask'][0]["value"]);
                    //         // List<Map> task = List.from(event.data['eventTask']); 
                    //         // var querySnapshot= await Firestore.instance.collection("events").getDocuments();
                    //         // List<Map<String, dynamic>> list = 
                    //         //   querySnapshot.documents.map((DocumentSnapshot doc){
                    //         //   return doc.data;
                    //         // }).toList();

                    //         // Map<String, dynamic> task = event.data['eventTask'];
                    //         // querySnapshot.forEach((doc) => {
                    //         //     console.log(`${doc.id} => ${doc.data()}`);
                    //         // });
                    //         // CollectionReference citiesRef = Firestore.instance.collection("events");
                    //         // citiesRef.where("eventTask");
                    //         // List<Map> task = [];
                    //         // task = event.data['eventTask'];
                    //         // print(citiesRef.where("eventTask",));
                    //         // Map<String, Object> eventTask = Map<String, Object>();
                            
                    //         // CollectionReference applicationsRef = Firestore.instance.collection("events");
                    //         // DocumentReference applicationIdRef = applicationsRef.document(applicationId);
                    //         // applicationIdRef.get().addOnCompleteListener(task -> {
                    //         //   if (task.isSuccessful()) {
                    //         //     DocumentSnapshot document = task.getResult();
                    //         //     if (document.exists()) {
                    //         //       List<Map<String, Object>> users = List<Map<String, Object>> event.data["eventTask"];   
                    //         //     }
                    //         //   }
                    //         // });
                    //       },
                    //     )
                    //     // Icon(Icons.check_box, color: Colors.orange),
                    //     // SizedBox(width: 10),
                    //     // Text(
                    //     //   event.data['eventTask'].toString(),
                    //     //   // 'Mencatat Kondisi Kesehatan \nMengecek Tekanan Darah',
                    //     //   style: TextStyle(fontSize: 14),
                    //     // )
                    //   ],
                    // ),
                  ],
                ),

                //Pengaju
                ListView(
                  padding: EdgeInsets.all(18),
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/profile_image_1.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Davis Vaccaro',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.orange),
                        SizedBox(width: 10),
                        Text(
                          'Gelora Sepuluh Nopember',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.flag, color: Colors.orange),
                        SizedBox(width: 10),
                        Text(
                          '2 Kegiatan Diajukan \n0 Partisipasi',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}