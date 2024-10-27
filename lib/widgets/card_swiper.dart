import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.length == 0) {
      return Container(
          width: double.infinity,
          height: size.height * 0.5,
          child: Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemBuilder: (_, int index) {
          final movie = movies[index];
          movie.uniqueId = '${movie.id}-cards';
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details_screen',
                arguments: movie),
            child: Hero(
              tag: movie.uniqueId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.getfullPosterImg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.6,
      ),
    );
  }
}
