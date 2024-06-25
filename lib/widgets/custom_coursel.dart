import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/tv_series_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCarousel extends StatelessWidget {
  final TvSeriesModal data;
  const CustomCarousel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (BuildContext, int index, int realindex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
                child: Column(
                  children: [
                    CachedNetworkImage(imageUrl: "$imageurl$url"),
                    SizedBox(height: 20),
                    Text(data.results[index].name)
                  ],
                ));
          },
          options: CarouselOptions(
              height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
              aspectRatio: 16 / 9,
              autoPlay: true,
              initialPage: 0,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
