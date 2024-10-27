import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_3/models/models.dart';
import 'package:seminario_3/providers/movies_provider.dart';

class ActorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cast actor = ModalRoute.of(context)!.settings.arguments as Cast;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(actor: actor),
          SliverList(
            delegate: SliverChildListDelegate([
              _ProfileAndName(actor: actor),
              _MoviesList(idActor: actor.id),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Cast actor;

  const _CustomAppBar({
    super.key,
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.teal,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            actor.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(actor.getfullProfilePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProfileAndName extends StatelessWidget {
  final Cast actor;

  const _ProfileAndName({
    super.key,
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Hero(
            tag: actor.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(actor.getfullProfilePath),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actor.name,
                  style: textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Nombre original: ${actor.originalName}',
                  style: textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'Género: ${actor.gender == 1 ? 'Femenino' : 'Masculino'}',
                  style: textTheme.bodyMedium,
                ),
                Text(
                  'Popularidad: ${actor.popularity.toString()}',
                  style: textTheme.bodyMedium,
                ),
                // Nueva sección para el personaje
                if (actor.character != null)
                  Text(
                    'Personaje: ${actor.character}',
                    style: textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviesList extends StatelessWidget {
  final int idActor;

  const _MoviesList({
    super.key,
    required this.idActor,
  });

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMoviesByActor(idActor),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 150,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Movie> movies = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 190,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _MovieCard(movie: movies[index]);
            },
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.uniqueId = '${movie.id}-actor';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId!,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details_screen', arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.getfullPosterImg),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
