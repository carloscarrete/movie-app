import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/anime_provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

class CardSwiper extends StatelessWidget {

  //final List<Movie> movies;
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(movies.length==0){
      return Container(
        width: double.infinity,
        height: size.height*.4,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: size.height*.50,
      width: double.infinity,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
        itemHeight: size.height*.48,
        itemWidth: size.width*.5,
        itemBuilder: (_,int index){
          final imageMovie = movies[index];
          imageMovie.heroId = 'swiper-${imageMovie.id}';
          return GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details',arguments: movies[index]),
            child: Hero(
              tag: imageMovie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/no-image.jpg', 
                  image: imageMovie.getImages),
              ),
            ),
          );
        },),
    );
/*     final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*.5,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemHeight: size.height*.4,
        itemWidth: size.width*.6,
        itemBuilder: (_,int index){
          return GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details',arguments: 'movie-data'),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage.assetNetwork(
                placeholder: 'assets/no-image.jpg', 
                image: 'https://via.placeholder.com/300x400',
                fit: BoxFit.cover,),
            ),
          );
        },),
    ); */
  }
}