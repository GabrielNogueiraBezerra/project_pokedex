import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:project/app/modules/home/models/poke_api.dart';
import 'package:project/app/modules/home/repositories/poke_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;
 
abstract class _HomeControllerBase with Store {
  final PokeRepository pokeRepository;

  @observable
  PokeAPI _pokeApi;

  @computed
  PokeAPI get pokeApi => _pokeApi;

  _HomeControllerBase(this.pokeRepository) {
    fetchPokemonList();
  }

  @action
  getPokemon({int index}) {
    return _pokeApi.pokemon[index];
  }

  @action
  Widget getImage({String numero}) {
    return pokeRepository.getImage(numero: numero);
  }

  @action
  fetchPokemonList() {
    _pokeApi = null;

    pokeRepository.loadPokeAPI().then((pokeList) {
      _pokeApi = pokeList;
    });
  }
}
