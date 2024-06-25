import 'package:flutter/material.dart';
import 'package:netflixx/screens/home_screen.dart';
import 'package:netflixx/screens/more_screen.dart';
import 'package:netflixx/screens/morescreen.dart';
import 'package:netflixx/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: 'New & hot',
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 143, 128, 128)),
        ),
        body:
            TabBarView(children: [HomeScreen(), SearchScreen(), HotandNew()]),
      ),
    );
  }
}
