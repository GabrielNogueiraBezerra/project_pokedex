// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<PokeAPI> _$pokeApiComputed;

  @override
  PokeAPI get pokeApi =>
      (_$pokeApiComputed ??= Computed<PokeAPI>(() => super.pokeApi)).value;

  final _$_pokeApiAtom = Atom(name: '_HomeControllerBase._pokeApi');

  @override
  PokeAPI get _pokeApi {
    _$_pokeApiAtom.context.enforceReadPolicy(_$_pokeApiAtom);
    _$_pokeApiAtom.reportObserved();
    return super._pokeApi;
  }

  @override
  set _pokeApi(PokeAPI value) {
    _$_pokeApiAtom.context.conditionallyRunInAction(() {
      super._pokeApi = value;
      _$_pokeApiAtom.reportChanged();
    }, _$_pokeApiAtom, name: '${_$_pokeApiAtom.name}_set');
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic getPokemon({int index}) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.getPokemon(index: index);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String numero}) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.getImage(numero: numero);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction();
    try {
      return super.fetchPokemonList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'pokeApi: ${pokeApi.toString()}';
    return '{$string}';
  }
}
