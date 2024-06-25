import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/movie_recomondation.dart';

import 'package:netflixx/modals/searchmodal.dart';
import 'package:netflixx/screens/movie_detail_screen.dart';
import 'package:netflixx/services/apiservices.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModal? searchModal;
  late Future<MovieRecomondationModal> popularMovies;

  void search(String query) {
    apiServices.getSearchMovie(query).then((results) {
      setState(() {
        searchModal = results;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getpopularmovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(57)),
                  prefixIcon: Icon(Icons.search,
                      color: Color.fromARGB(255, 138, 132, 132)),
                  suffixIcon: Icon(Icons.cancel,
                      color: const Color.fromARGB(255, 107, 104, 104)),
                  hintStyle: TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                  filled: true,
                  fillColor: Color.fromARGB(163, 59, 40, 17),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      searchModal = null;
                    });
                  } else {
                    search(searchController.text);
                  }
                },
              ),
            ),
            SizedBox(height: 30),
            searchController.text.isEmpty
                ? FutureBuilder<MovieRecomondationModal>(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.results.isEmpty) {
                        return Text('No popular movies found');
                      }

                      var data = snapshot.data!.results;
                      return Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Top Search",
                            style: TextStyle(fontWeight: FontWeight.bold,color: white),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailScreen(movieId: data[index].id,)));
                                },
                                child: Container(
                                  height: 150,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Image.network(
                                          "${imageurl}${data[index].posterPath}"),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 260,
                                        child: Text(
                                          data[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  )
                : searchModal == null
                    ? SizedBox.shrink()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchModal?.results.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1 / 2),
                        itemBuilder: (context, index) {
                          return InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailScreen(movieId: searchModal!.results[index].id)));},
                            child: Column(
                              children: [
                                // ignore: unnecessary_null_comparison
                                searchModal!.results[index].backdropPath == null
                                    ? Image.asset('assets/netflix.png',
                                        height: 160)
                                    : CachedNetworkImage(
                                        imageUrl:
                                            "${imageurl}${searchModal!.results[index].backdropPath}",
                                        height: 170,
                                      ),
                                SizedBox(
                                  child: Text(
                                    "${searchModal!.results[index].originalTitle}",
                                    style: TextStyle(fontSize: 14, color: white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
