import 'package:news_app/models/category_model.dart';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  categories.add(
    CategoriesModel(name: "business", image: "images/business.png"),
  );
  categories.add(
    CategoriesModel(name: "entertainment", image: "images/entertainment.png"),
  );
  categories.add(CategoriesModel(name: "general", image: "images/general.png"));
  categories.add(CategoriesModel(name: "health", image: "images/health.png"));
  categories.add(CategoriesModel(name: "science", image: "images/science.png"));
  categories.add(CategoriesModel(name: "sports", image: "images/sports.png"));

  return categories;
}
