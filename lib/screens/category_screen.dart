import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/services/API_Handler.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryname;
  const CategoryScreen({super.key, required this.categoryname});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'News Related to Category',
          style: GoogleFonts.lobster(
            textStyle: TextStyle(
              fontSize: 22,
              letterSpacing: 0.6,
              color: color,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiHandler.getCategory(widget.categoryname),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const ArticleWidget(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
