import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/services/API_Handler.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:news_app/widgets/tab_widget.dart';
import 'package:news_app/widgets/top_trending.dart';
import 'package:news_app/widgets/top_trending_loading.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsType = "all news";
  int currentpageindex = 0;
  String sortBy = SortByEnum.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).getColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Daily News',
          style: GoogleFonts.aladin(
            textStyle: TextStyle(
              fontSize: 22,
              letterSpacing: 0.6,
              color: color,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const SearchScreen(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            icon: const Icon(IconlyLight.search),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                TabWidget(
                  color:
                      newsType == "all news"
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                  text: "All news",
                  fontsize: newsType == "all news" ? 22 : 18,
                  function: () {
                    setState(() {
                      newsType = "all news";
                    });
                  },
                ),
                SizedBox(width: 25),
                TabWidget(
                  color:
                      newsType == "top trending"
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                  text: "Top Trending",
                  fontsize: newsType == "top trending" ? 22 : 18,
                  function: () {
                    setState(() {
                      newsType = "top trending";
                    });
                  },
                ),
              ],
            ),
          ),
          newsType == "all news"
              ? SizedBox(
                height: kBottomNavigationBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PaginationButtons(
                      text: "Pre",
                      function: () {
                        if (currentpageindex == 0) {
                          return;
                        }
                        setState(() {
                          currentpageindex--;
                        });
                      },
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: ((context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color:
                                    currentpageindex == index
                                        ? Colors.blue
                                        : Theme.of(context).cardColor,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentpageindex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('${index + 1}'),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    PaginationButtons(
                      text: "Next",
                      function: () {
                        if (currentpageindex == 4) {
                          return;
                        }
                        setState(() {
                          currentpageindex++;
                        });
                      },
                    ),
                  ],
                ),
              )
              : Container(),
          const SizedBox(height: 16),
          newsType == "top trending"
              ? Container()
              : Align(
                alignment: Alignment.centerRight,
                child: Material(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    child: DropdownButton(
                      value: sortBy,
                      items: dropdownItems,
                      onChanged: (String? value) {},
                    ),
                  ),
                ),
              ),
              newsType == "top trending" ?
          FutureBuilder(
            future: ApiHandler.getTopTrending(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Toptrendingloading();
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              }
              return SizedBox(
                height: size.height * 0.5,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
                  layout: SwiperLayout.STACK,
                  itemWidth: size.width * 0.9,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: snapshot.data![index],

                      child: const Toptrending(),
                    );
                  },
                ),
              );
            },
          )
          :Expanded(
                child: FutureBuilder(
                  future: ApiHandler.getData(limit: "10"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
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
                    // return ListView.builder(
                    //     itemCount: snapshot.data!.length,
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //           padding: const EdgeInsets.all(8),
                    //           child: ChangeNotifierProvider.value(
                    //               value: snapshot.data![index],
                    //               child: const ArticleWidget()));
                    //     });
                  },
                ),
              ),
        ],
      ),
    );
  }
}

class PaginationButtons extends StatelessWidget {
  final String text;
  final Function function;
  const PaginationButtons({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      child: Text(text),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  return SortByEnum.values.map((sortBy) {
    return DropdownMenuItem(value: sortBy.name, child: Text(sortBy.label));
  }).toList();
}
