import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_3/providers/movies_provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (!query.isEmpty) {
      final moviesProvider =
          Provider.of<MoviesProvider>(context, listen: false);
      moviesProvider.getSuggestionsBtQuery(query);
      return StreamBuilder(
          stream: moviesProvider.suggestionStream,
          builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              final movies = snapshot.data!;
              return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: ((context, index) =>
                      _MovieItem(movie: movies[index])));
            } else {
              return _emptyContainer();
            }
          });
    } else {
      return _emptyContainer();
    }
  }

  Container _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.uniqueId = '${movie.id}-search';

    return SizedBox(
      height: 70,
      width: 100,
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        leading: Hero(
          tag: movie.uniqueId!,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.getfullPosterImg),
            width: 50,
            fit: BoxFit.contain,
          ),
        ),
        onTap: () =>
            Navigator.pushNamed(context, 'details_screen', arguments: movie),
      ),
    );
  }
}
