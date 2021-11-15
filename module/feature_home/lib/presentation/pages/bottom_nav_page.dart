import 'package:core/core.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_event.dart';
import 'package:feature_home/presentation/pages/watch_list_page.dart';
import 'package:feature_movie/presentation/pages/about_page.dart';
import 'package:feature_movie/presentation/pages/home_movie_page.dart';
import 'package:feature_tv/presentation/pages/home_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, int>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              index: context.read<BottomNavBloc>().state,
              children: const [
                HomeMoviePage(),
                HomeTVShowPage(),
                WatchListPage(),
                AboutPage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedItemColor: kWhite,
              unselectedItemColor: kDavysGrey,
              onTap: (value){
                context.read<BottomNavBloc>().add(ChangeTabEvent(state: value));
              },
              currentIndex: context.read<BottomNavBloc>().state,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: "Movies",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tv),
                  label: "Tv Shows",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.save_alt),
                  label: "Watchlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: "About",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
