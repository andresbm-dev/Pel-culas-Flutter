import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key,
        required this.moviesPopular,
        this.title,
        required this.callNextPage}
      );

  final List<Movies> moviesPopular;
  final String? title;
  final Function callNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();

}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent-500){
        widget.callNextPage();
      }
    });

  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(widget.title!=null)
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
          )
          ,
          Expanded(
            //permite ajustar el tamaño disponible
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.moviesPopular.length,
                itemBuilder: (_, index) {
                  final popularMovies = widget.moviesPopular[index];
                  return _MovieCard(movie: popularMovies,);
                }
                ),
          )
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({super.key, required this.movie});
  final Movies movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 320,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children:  [
          GestureDetector(
            onTap: ()=> Navigator.pushNamed(context, 'detail', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.moviePoster),
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
           Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
