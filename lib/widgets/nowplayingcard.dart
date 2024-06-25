import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/upcomming_modal.dart';

class NowPlayingCard extends StatelessWidget {
  final Future<List<UpcommingModal>> future;
  final String headLineText;
  const NowPlayingCard({required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
            var data = snapshot.data!;
          return Column(
            children: [
              Text(
                headLineText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //length
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network("${imageurl}${data[index].posterPath}"),
                      );
                    }),
              )
            ],
          );
            
          }
          else{
            return SizedBox.shrink();


          }
          
        }
    
        );
  }
}
