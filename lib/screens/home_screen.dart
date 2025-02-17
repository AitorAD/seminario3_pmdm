import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_3/providers/movies_provider.dart';
import 'package:seminario_3/search/search_delegate.dart';
import 'package:seminario_3/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          title: Text('Películas en cines'),
          elevation: 10,
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                showSearch(context: context, delegate: MovieSearchDelegate());
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
              )
            ],
          ),
        ));
  }
}
