import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/actors_response.dart';

class ActorsCards extends StatelessWidget {
  const ActorsCards({Key? key, required this.movieId}) : super(key: key);
  final int movieId;


  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieActors(movieId),
      builder: ( _, AsyncSnapshot  <List<Cast>> snapshot) {

        if( !snapshot.hasData ) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only( bottom: 30 ),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( _, int index) => _ActorsCards(  actor: cast[index], ),
          ),
        );

      },
    );


  }
}

class _ActorsCards extends StatelessWidget {
  const _ActorsCards({Key? key, required this.actor}) : super(key: key);
  final Cast actor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),

          ),
          const SizedBox(height: 5,),
           Text(
              actor.name, maxLines: 2, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}

