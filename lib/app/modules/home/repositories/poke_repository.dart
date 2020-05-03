import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project/app/consts/const_app.dart';
import 'package:project/app/modules/home/models/poke_api.dart';
import 'package:project/app/modules/home/models/poke_api_v2.dart';
import 'package:project/app/modules/home/models/specie.dart';

class PokeRepository {
  final Dio dio;

  PokeRepository(this.dio);

  Future<PokeAPI> loadPokeAPI() async {
    var decodeJson;
    try {
      Response response = await this.dio.get(
          "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
      decodeJson = jsonDecode(response.data.toString());
    } catch (e) {
      final String jJSON = await rootBundle.loadString('assets/my_text.txt');
      decodeJson = jsonDecode(jJSON);
    }

    return PokeAPI.fromJson(decodeJson);
  }

  Future<PokeApiV2> getInfoPokemon(String nome) async {
    Response response = await this.dio.get(ConstsApp.baseURLPokeInfo + nome);
    return PokeApiV2.fromJson(response.data);
  }

  Future<Specie> getSpeciePokemon(int num) async {
    Response response =
        await dio.get(ConstsApp.baseUrlPokeSpecies + num.toString());

    return Specie.fromJson(response.data);
  }

  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }
}
