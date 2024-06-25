import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/movie_detailed_modal.dart';
import 'package:netflixx/modals/movie_recomondation.dart';
import 'package:netflixx/services/apiservices.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailModal> moviedetail;
  late Future<MovieRecomondationModal> movieRecomondations;

  @override
  void initState() {
    fetchIntialialData();
    super.initState();
  }

  fetchIntialialData() {
    moviedetail = apiServices.getMovieDetail(widget.movieId);
    movieRecomondations = apiServices.getMovieRecomondation(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("hey iam here${widget.movieId}");
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: moviedetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
                String genereText =
                    movie!.genres.map((Genre) => Genre.name).join(',');

                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "$imageurl${movie.backdropPath}")),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: TextStyle(color: Colors.green),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              genereText,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    FutureBuilder(
                        future: movieRecomondations,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final movie = snapshot.data;
                            return movie!.results.isEmpty
                                ? SizedBox()
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'More like this',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: white),
                                      ),
                                      SizedBox(height: 20),
                                      GridView.builder(
                                        itemCount: movie.results.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 5,
                                                  childAspectRatio: 1 / 2),
                                          itemBuilder: (context, index) {
                                           return CachedNetworkImage(
                                                imageUrl:
                                                    "${imageurl}${movie.results[index].posterPath}");
                                            
                                          })
                                    ],
                                  );
                          }
                          return const Text("Something went wrong");
                        })
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
