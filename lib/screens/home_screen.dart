import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/tv_series_modal.dart';
import 'package:netflixx/modals/upcomming_modal.dart';
import 'package:netflixx/screens/movie_detail_screen.dart';
import 'package:netflixx/screens/search_screen.dart';
import 'package:netflixx/services/apiservices.dart';
import 'package:netflixx/widgets/custom_coursel.dart';
import 'package:netflixx/widgets/movie_car_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<TvSeriesModal> topratedtvseries;
  late Future<List<UpcommingModal>> upcomingFuture;
  // late Future<UpcommingModal> nowPlayingFuture;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovies();
    // nowPlayingFuture = apiServices.getNowPlayingMovies();
    topratedtvseries = apiServices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
              height: 50,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 190),
                child: Image.asset('assets/logo.png'),
              ))),
          backgroundColor: kbackgroundcolor,
          actions: [
            InkWell(
                onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen()));},
                child: const Icon(
                  Icons.search,
                  color: white,
                )),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: topratedtvseries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCarousel(data: snapshot.data!);
                      
                    }
                    else{
                      return SizedBox.shrink();
                    }
                    
                  }),
              SizedBox(
                  height: 220,
                  child: InkWell(
                    // onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieDetailScreen(movieId: )));},
                    child: MovieCardWidget(
                        future: upcomingFuture,
                        headLineText: "Upcomming Movies"),
                  )),
              SizedBox(
                  height: 220,
                  child: MovieCardWidget(
                      future: upcomingFuture,
                      headLineText: "Now Playing Movies"))
            ],
          ),
        ));
  }
}
