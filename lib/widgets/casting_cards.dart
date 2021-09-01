import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: movieProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> asyncSnapshot) {

        if(!asyncSnapshot.hasData){
          return Container(
            height: 190,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = asyncSnapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          height: 190,
          width: double.infinity,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(actor: cast[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/no-image.jpg',
              image: actor.getProfilePath,
              height: 145,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
