import 'package:flutter/material.dart';
import 'package:peliculas/providers/anime_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    final animeProvider = Provider.of<AnimeProvider>(context);
     return Scaffold(
      appBar: AppBar(
        title: Text('TuApp Movie'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: ()=>showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: movieProvider.onDisplayMovies,),
            MovieSlider(
              movies: movieProvider.popularMovies, 
              title: 'Películas Populares', 
              onNextPage: ()=>movieProvider.getPopularMovies(),),
            SizedBox(height: 10.0,),
            MovieSlider(
              movies: movieProvider.topRatedMovies, 
              title: 'Top Rated Movies', 
              onNextPage: ()=>movieProvider.getTopRatedMovies()),
            SizedBox(height: 10.0,),
            MovieSlider(
              movies: movieProvider.upComingMovies, 
              title: 'Upcoming Movies', 
              onNextPage: ()=>movieProvider.getUpComingMovies()),
          ],
        ),
      )
    );
  }
}
