import 'package:flutter/material.dart';
import 'package:rongsokin_user/components/default_article_page.dart';
import 'package:rongsokin_user/models/article_models.dart';

class DefaultCardArticle extends StatelessWidget {
  const DefaultCardArticle({Key? key, required this.article, required this.id})
      : super(key: key);

  final Article article;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return DefaultArticlePage(
                article: article,
                id: id,
              );
            }));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            height: 180,
            child: Card(
              clipBehavior: Clip.none,
              elevation: 0,
              child: Container(
                width: double.maxFinite,
                height: 220 * 0.60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: id.toString(),
                        child: Image.asset(
                          article.photoArticle,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 15, right: 10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            article.titleArticle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
