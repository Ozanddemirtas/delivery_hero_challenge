import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryherochallenge/_.dart';
import 'package:deliveryherochallenge/core/bindings/base_view.dart';
import 'package:deliveryherochallenge/style/color.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../core/service/service_helper.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView(builder: (context, c) {
      return Obx(() {
        if (c.movieLoading.value)
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        else
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: KC.black,
              title: Text(c.movie.value.title!),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Hero(
                    tag: c.movie.value.id!,
                    child: bgHeroImage(context, c),
                  ),
                  detailContent(context, c),
                ],
              ),
            ),
          );
      });
    });
  }

  Padding detailContent(BuildContext context, AppController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
      child: Card(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(color: Colors.black45),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              infoRow("Popularity Score", c.movie.value.popularity!.toStringAsFixed(1)),
              infoRow("Original Title", c.movie.value.originalTitle!),
              infoRow("Original Language", c.movie.value.originalLanguage!),
              infoRow("Release Date", c.movie.value.releaseDate!),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview :\n",
                    maxLines: 10,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      c.movie.value.overview!,
                      maxLines: 10,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title : ",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            data,
            maxLines: 10,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage bgHeroImage(BuildContext context, AppController c) {
    return CachedNetworkImage(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      imageUrl: ServiceHelper.getImgUrl(c.movie.value.posterPath!),
      fit: BoxFit.cover,
    );
  }
}
