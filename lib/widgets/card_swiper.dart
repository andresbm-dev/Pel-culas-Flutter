import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class CardSwiper extends StatelessWidget{
  const CardSwiper({super.key, required this.movies});

  final List<Movies> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height*0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.6,
        itemHeight: size.height*0.4,
        itemBuilder:(context, index) {
          return  GestureDetector(  //permite hacer onTap sobre el contenido}
            onTap: () => Navigator.pushNamed(context, 'detail', arguments: movies[index]),
            child: ClipRRect(
                borderRadius:BorderRadius.circular(20),  //aplica border al fadeImage con el widget   ClipRRect
              child:  FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movies[index].moviePoster),
                fit: BoxFit.cover,  //ajusta la imagen al contenido para ver el borde
              ),
            ),
          );
        },
      ),
    );
  }

}