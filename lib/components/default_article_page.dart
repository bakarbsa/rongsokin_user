import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/article_models.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ArticleImage(article: article, id: id),
          ],
        ),
      )
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

  @override
  _ArticleImageState createState() => _ArticleImageState();
}

class _ArticleImageState extends State<ArticleImage> {
  @override
  Widget build(BuildContext context) {
    // final eventEndDate = DateTime.fromMicrosecondsSinceEpoch(widget.event.data['eventEndDate'].microsecondsSinceEpoch);
    // String formattedDate = DateFormat('dd-MM-yyyy').format(eventEndDate);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 20,
                  child: Image.asset(
                    "assets/images/back_icon.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Text('Artikel Hari Ini', style: kHeaderText,)
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Stack(
              children: [
                Hero(
                  tag: widget.id.toString(),
                  child: Image.asset(widget.article.photoArticle),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter, 
                        colors: <Color>[
                          Colors.black.withOpacity(0.35),
                          Colors.transparent,
                        ], // red to yellow
                        tileMode: TileMode.repeated,
                      )
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
        SizedBox(height: 10,),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.article.titleArticle, 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19
            ),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Penulis : ' + widget.article.writerArticle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey
              ),
            ),
            Text(
              widget.article.dateArticle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey
              ),
            )
          ],
        ),
        SizedBox(height: 10,),
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              wordSpacing: 6,
              fontSize: 16
            ),
            text: widget.article.contentArticle
          ) 
        ),
        SizedBox(height: 10,),
        InkWell(
          onTap: () {
            launch(widget.article.linkArticle);
          },
          child: Text(
            'Baca Selengkapnya : ' + widget.article.linkArticle,
            style: TextStyle(
              color: Colors.blue
            ),
          )
        )
      ],
    );
  }
}