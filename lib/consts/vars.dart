import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SortByEnum { relevancy, popularity, publishedAt }

TextStyle smallText = GoogleFonts.montserrat(fontSize: 15);

List<String> searchItems = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
];

extension SortByExtension on SortByEnum {
  String get label {
    switch (this) {
      case SortByEnum.relevancy:
        return 'Relevancy';
      case SortByEnum.popularity:
        return 'Popularity';
      case SortByEnum.publishedAt:
        return 'Published At';
    }
  }
}
