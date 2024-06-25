import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';


class ComeingSoonWidget extends StatelessWidget {
  final String image;
  final String overView;
  final String logo;
  final String month;
  final String day;
  

  const ComeingSoonWidget(
      {super.key,
      required this.image,
      required this.overView,
      required this.logo,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  month,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(day, style:   TextStyle(fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 5)),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: image,
                width: size.width * 0.7,
                alignment: Alignment.topLeft,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.8,
                child: Row(
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.width * 0.1,
                      child: CachedNetworkImage(
                        imageUrl: logo,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 50,
                    // ),
                    const Spacer(),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 24,
                          color: white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Remind me",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(width: 30),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline_rounded,
                            size: 24, color: white),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Info",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Comeing on $month $day",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Text(
                      overView,
                      maxLines: 4,
                      style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.grey,
    overflow: TextOverflow.ellipsis,
  ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}