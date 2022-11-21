
import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
    print(moviesProvider.moviesProvider);
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Películas De Cine"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.search))
        ],
      ),
     body: SingleChildScrollView(
       child: Column(
         children:  [
           CardSwiper( movies: moviesProvider.moviesProvider),
           MovieSlider(
               moviesPopular: moviesProvider.popularMovies,
             title: 'Peliculas Populares!',
             callNextPage: ()=> moviesProvider.getPopularMovies()
           ),
           /*const SizedBox(height: 10),
            MovieSlider(moviesPopular: moviesProvider.popularMovies),
           const SizedBox(height: 10),
            MovieSlider(moviesPopular: moviesProvider.popularMovies),
*/
         ],
       ),
     )
    );
  }
}