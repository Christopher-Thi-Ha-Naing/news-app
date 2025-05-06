import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Toptrending extends StatelessWidget {
  const Toptrending({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ArticleModel articleModelProvider = Provider.of<ArticleModel>(
      context,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: FancyShimmerImage(
                imageUrl: articleModelProvider.urlToImage.toString(),
                boxFit: BoxFit.fill,
                width: double.infinity,
                height: size.height * 0.3,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                articleModelProvider.title.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: NewsdetailScreen(
                            url: articleModelProvider.url.toString(),
                          ),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    },
                    icon: const Icon(Icons.link),
                  ),
                  Text(articleModelProvider.publishedAt.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
