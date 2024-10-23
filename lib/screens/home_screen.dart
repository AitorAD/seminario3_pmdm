import 'package:flutter/material.dart';
import 'package:seminario_3/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        elevation: 10,
        actions: [
          Icon(Icons.search_outlined)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            MovieSlider()
          ],
        ),
      )
    );
  }
}
