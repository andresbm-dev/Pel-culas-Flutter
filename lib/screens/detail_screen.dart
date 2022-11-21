import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';


class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movies movie =
        ModalRoute.of(context)?.settings.arguments! as Movies ;
    return Scaffold(
      body: CustomScrollView(
        slivers: [   //wigets que tengan slivers un texto no es un sliver
          _CustomAppBar(movie: movie),
          SliverList( //sliverList me permite tener listas de sliver
              delegate: SliverChildListDelegate([ //con SliverChildList puedo tener ahora si cualquier widget Text
                _PosterAndTitle(movie: movie,),
                 _OverView(movie: movie,),
                _OverView(movie: movie,),
                 ActorsCards(movieId: movie.id,),

              ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key, required this.movie});

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace:FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),  //le quita una margen que existia
        title:Container(
            width: double.infinity,
            height: 240,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
                movie.title,
              style: const TextStyle(fontSize: 16),
            )
        ),
        background: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.movieBackdropPath),
          fit: BoxFit.cover,
        ),
      ) ,
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);
  final Movies movie;

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.moviePoster),
                fit: BoxFit.cover,
              height: 150,
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis,maxLines: 2),
              Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
              Row(
                children: [
                  const Icon(Icons.star_border_outlined, color:Colors.grey),
                  const SizedBox(width: 5,),
                  Text('${movie.voteAverage}', style: textTheme.caption,)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView ({Key? key, required this.movie}) : super(key: key);
  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child:
         Text(movie.overview,
        textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ),
    );
  }
}

