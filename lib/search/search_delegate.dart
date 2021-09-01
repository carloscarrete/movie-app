
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: ()=> query='', 
        icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){close(context, null);}, 
      icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    //return Text('buildResults');
    return _empyContainer();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return _empyContainer();
    }

    final movieProvier = Provider.of<MoviesProvider>(context,listen: false);
    movieProvier.getSuggestionByQuery(query);
    return StreamBuilder(
      stream: movieProvier.suggestStream,
      builder: (_,AsyncSnapshot<List<Movie>> snapshot){
        if(!snapshot.hasData) return _empyContainer();
        final movie = snapshot.data!;
        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (_,int index)=>_MovieItem(movie: movie[index],)

          );
      });
  }
  Widget _empyContainer(){
  return Container(
      child: Center(
        child: Icon(Icons.movie_creation_outlined,size: 150, color: Colors.black38,),
      ),
    );
}

}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return Column(
      children: [
        ListTile(
        title: Text(movie.title),
        leading: Hero(
          tag: movie.heroId!,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/no-image.jpg', 
            image: movie.getImages,
            width: 50,
            fit: BoxFit.cover),
        ),
        subtitle: Text(movie.originalTitle),
        onTap: ()=>Navigator.pushNamed(context, 'details',arguments: movie),
      ),
      Divider(thickness: 1.0,)
      ],
    );
  }
}
