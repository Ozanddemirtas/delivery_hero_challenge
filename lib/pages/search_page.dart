import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryherochallenge/core/bindings/base_view.dart';
import 'package:deliveryherochallenge/core/models/movie_model.dart';
import 'package:deliveryherochallenge/core/service/service_helper.dart';
import 'package:deliveryherochallenge/pages/movie_detail_page.dart';
import 'package:deliveryherochallenge/style/color.dart';
import 'package:shimmer/shimmer.dart';

import '../_.dart';
import '../style/decoration.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      builder: (context, c) => Scaffold(
        backgroundColor: KC.black,
        appBar: AppBar(
          backgroundColor: KC.black,
          title: Text("Movies"),
          elevation: 0,
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              children: [
                searchField(c),
                Expanded(
                  child: Obx(() {
                    if (c.moviesLoading.value)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 7, childAspectRatio: 0.6),
                          itemCount: c.movies.length,
                          itemBuilder: (BuildContext context, int index) {
                            MovieModel movie = c.movies[index];
                            return GestureDetector(
                              onTap: () {
                                c.detail(movie.id!);
                                Get.to(MovieDetailPage());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 4,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      contentWidget(movie),
                                      titleWidget(movie),
                                    ],
                                  )),
                                ),
                              ),
                            );
                          });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded contentWidget(MovieModel movie) {
    return Expanded(
        flex: 6,
        child: Stack(
          children: [
            Container(
              child: movie.posterPath != null
                  ? Hero(
                      tag: movie.id!,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: ServiceHelper.getImgUrl(movie.posterPath!),
                        errorWidget: (a, b, c) => Shimmer(
                            child: Text("Loading"),
                            gradient: LinearGradient(colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade900,
                            ])),
                      ),
                    )
                  : Center(
                      child: Shimmer(
                          child: Text("No Image"),
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade300,
                            Colors.grey.shade900,
                          ]))),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  width: 42,
                  color: Colors.white,
                  child: Center(child: Text(movie.voteAverage!.toStringAsFixed(1))),
                ),
              ),
            ),
          ],
        ));
  }

  Expanded titleWidget(MovieModel movie) {
    return Expanded(
        flex: 1,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            // border: borderSide(),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ));
  }

  Padding searchField(AppController c) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            if (value.length > 1) {
              c.search(value);
            }
          },
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: "Search for movie ...",
            labelStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: KRadius.general,
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: KRadius.general,
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
            border: OutlineInputBorder(
              borderRadius: KRadius.general,
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
          ),
        ));
  }
}
