import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/topRated.dart';
import 'package:netflixx/modals/upcomming_modal.dart';
import 'package:netflixx/services/apiservices.dart';
import 'package:netflixx/widgets/commingsoon.dart';


class HotandNew extends StatefulWidget {
  const HotandNew({super.key});

  @override
  State<HotandNew> createState() => _HotandNewState();
}

class _HotandNewState extends State<HotandNew> {
  late Future<TrendingMovieModel> trending;
  late Future<List<UpcommingModal>> upcomingFuture;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    trending = apiServices.getTrending('day');
   upcomingFuture = apiServices.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "New & Hot",
              style: TextStyle(color: white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: white,
              ),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                  text: "  🔥 Coming Soon  ",
                ),
                Tab(
                  text: "  🍿 Everyone's Watching  ",
                ),
              ],
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: white,
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: white),
            ),
          ),
          body: TabBarView(
            children: [
              _buildFutureBuilder1(),
              _buildFutureBuilder2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFutureBuilder1() {
    return FutureBuilder<List<UpcommingModal>>(
      future: upcomingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image: '$imageurl${data[index].backdropPath}',
                overView: data[index].overview,
                logo: '$imageurl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildFutureBuilder2() {
    return FutureBuilder<TrendingMovieModel>(
      future: trending,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!.results;
          log(data.length.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ComeingSoonWidget(
                image: '$imageurl${data[index].backdropPath}',
                overView: data[index].overview,
                logo: '$imageurl${data[index].posterPath}',
                month: data[index].releaseDate.month.toString(),
                day: data[index].releaseDate.day.toString(),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}