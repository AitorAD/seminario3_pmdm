import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_3/providers/movies_provider.dart';
import 'package:seminario_3/screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.indigo)),
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home_screen',
      routes: {
        'home_screen': (_) => HomeScreen(),
        'details_screen': (_) => DetailsScreen(),
      },
    );
  }
}
