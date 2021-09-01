import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
/*     final movie = ModalRoute.of(context)?.settings.arguments.toString() ?? '';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
        ],
      ),
    ); */
    //final movie = ModalRoute.of(context)?.settings.toString() ?? '';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie,),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie: movie,),
                _OverView(movie: movie,),
                CastingCards(movie.id),
              ]
            ))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.deepPurpleAccent,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: 5),
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            width: double.infinity,
            child: Text(movie.title,style: TextStyle(fontSize: 16),),
          ),
          background: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif', 
            image: movie.getBackPath,
            fit: BoxFit.cover,),
        ),
    );  
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:5),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif', 
                image: movie.getImages,
                height: 150,),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle,style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1,),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, ),
                    SizedBox(width: 5,),
                    Text(movie.voteAverage.toString(),style: Theme.of(context).textTheme.caption,)
                  ],
                )
              ],),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Text(movie.overview,textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}