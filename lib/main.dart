import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        pageTitle: "Page Title",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Pokemon {
  final String name;
  final String url;

  Pokemon(this.name, this.url);
}

class _MyHomePageState extends State<MyHomePage> {
  var pokemons = <Pokemon>[];

  final dio = Dio();

  Future<void> fetchPokemons() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
          "https://pokeapi.co/api/v2/pokemon?limit=2");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.toString());
        setState(() {
          for (final result in jsonData['results']) {
            pokemons.add(Pokemon(result['name'], result['url']));
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load pokemons")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load pokemons")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text(widget.pageTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("Add button pressed");
            },
          ),
          OutlinedButton(
            onPressed: () {
              print("press");
            },
            onLongPress: () => print("long press"),
            child: Text("outline"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 250, 214, 105),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final pokemon in pokemons)
                  ListTile(
                    title: Text(pokemon.name),
                  ),
                RatingBar(
                  initialRating: 2,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.abc),
                    half: Icon(Icons.abc_outlined),
                    empty: Icon(Icons.ac_unit),
                  ),
                  onRatingUpdate: (value) => print(value),
                ),
                RatingBar.builder(
                  maxRating: 3,
                  initialRating: 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Icon(
                        Icons.star,
                        color: Colors.red,
                      );
                    }
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (value) => print(value),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("press");
        },
      ),
    );
  }
}
