import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_pi/models/pokemon.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  var pokemons = <PokemonInList>[];

  final dio = Dio();

  Future<void> fetchPokemons() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
          "https://pokeapi.co/api/v2/pokemon?limit=2");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.toString());
        setState(() {
          for (final result in jsonData['results']) {
            pokemons.add(PokemonInList(result['name'], result['url']));
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
    return const Placeholder();
  }
}
