import 'package:flutter/material.dart';
import 'package:peliculas/providers/anime_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:provider/provider.dart';

class StateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>MoviesProvider(),lazy:false),
        ChangeNotifierProvider(create: (_)=>AnimeProvider(),lazy:false),
      ],
      child: MyApp(),);
  }
}

void main() => runApp(StateApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home' : (_) => HomeScreen(),
        'details' : (_) => DetailScreen()
      },
       theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.deepPurpleAccent
        )
      ) 
    );
    
  }
}