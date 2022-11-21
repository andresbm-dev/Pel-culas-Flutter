import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';


void main() => runApp(const MoviesProviderWidget());

class MoviesProviderWidget extends StatelessWidget {
  const MoviesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesProvider() ,lazy: false),
      ],
    child: const MyApp(),);
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas app',
      initialRoute: 'home',
      routes: {
        'home' : ( _ ) => const HomeScreen() ,//Map <String, function> => Widget
        'detail' : (_) => const DetailScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
            color: Colors.blue,
          elevation: 0
        )
      ),

    );
  }
}
