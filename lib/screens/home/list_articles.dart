import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_card_article.dart';
import 'package:rongsokin_user/models/article_models.dart';

class ListArticles extends StatefulWidget {
  const ListArticles({ Key? key }) : super(key: key);

  @override
  _ListArticlesState createState() => _ListArticlesState();
}

class _ListArticlesState extends State<ListArticles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              listArticles.length,
              (index) {
                return DefaultCardArticle(article: listArticles[index], id: index,);
              },
            ),
          ],
        ),
      ),
    );
  }
}