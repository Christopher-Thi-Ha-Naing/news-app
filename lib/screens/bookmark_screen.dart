import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/empty_screen.dart';
import 'package:news_app/services/utils.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Book Mark',
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
      body: const EmptyNewsWidget(
        text: "You haven't added anything to BookMark!",
        imagePath: "images/bookmark.png",
      ),
    );
  }
}
