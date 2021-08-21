import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rongsokin_user/constant.dart';
import 'package:rongsokin_user/models/article_models.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultArticlePage extends StatelessWidget {
  const DefaultArticlePage({Key? key, required this.article, required this.id})
      : super(key: key);

  final Article article;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: ListView(
        children: [
          ArticleImage(article: article, id: id),
        ],
      ),
    ));
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
                  child: Icon(Icons.arrow_back),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Artikel Hari Ini',
                style: kHeaderText,
              )
            ],
          ),
        ),
        SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: widget.id.toString(),
                        child: Image.asset(
                          widget.article.photoArticle,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.article.titleArticle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Penulis : ' + widget.article.writerArticle,
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.grey[600]),
            ),
            Text(
              widget.article.dateArticle,
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.grey[600]),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                style: TextStyle(
                    color: Colors.black, wordSpacing: 6, fontSize: 16),
                text: widget.article.contentArticle)),
        SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              launch(widget.article.linkArticle);
            },
            child: Text(
              'Baca Selengkapnya : ' + widget.article.linkArticle,
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );
  }
}
