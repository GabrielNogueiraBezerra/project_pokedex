import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:project/app/consts/const_app.dart';
import 'package:project/app/modules/home/models/poke_api_v2.dart';
import 'package:project/app/modules/home/models/pokemon.dart';
import 'package:project/app/modules/home/models/specie.dart';
import 'package:project/app/modules/home/repositories/poke_repository.dart';
import 'package:simple_animations/simple_animations.dart';

part 'detail_controller.g.dart';

class DetailController = _DetailControllerBase with _$DetailController;

abstract class _DetailControllerBase with Store {
  final PokeRepository pokeRepository;

  _DetailControllerBase(this.pokeRepository) {
    _animation = MultiTrackTween([
      Track('rotation').add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);

    _progress = 0;
    _multiple = 1;
    _opacityTitle = 0;
    _opacity = 1;
  }

  @observable
  PokeApiV2 _pokeApiv2;

  @action
  getInfoPokemon(String nome) async {
    _pokeApiv2 = null;

    await pokeRepository.getInfoPokemon(nome).then((pokeResult) {
      _pokeApiv2 = pokeResult;
    });
  }

  @action
  Widget componentValor(String value) {
    return new Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @observable
  List<Widget> _listaStatus;

  @observable
  List<Widget> _listaBarStatus;

  @computed
  List<Widget> get listaStatus => _listaStatus;

  @computed
  List<Widget> get listaBarStatus => _listaBarStatus;

  @action
  getStatusPokemon() {
    _listaStatus = new List(7);
    _listaBarStatus = new List(7);
    _listaStatus[0] = Container();
    _listaStatus[1] = Container();
    _listaStatus[2] = Container();
    _listaStatus[3] = Container();
    _listaStatus[4] = Container();
    _listaStatus[5] = Container();
    _listaStatus[6] = Container();
    _listaBarStatus[0] = Container();
    _listaBarStatus[1] = Container();
    _listaBarStatus[2] = Container();
    _listaBarStatus[3] = Container();
    _listaBarStatus[4] = Container();
    _listaBarStatus[5] = Container();
    _listaBarStatus[6] = Container();

    int total = 0;
    pokeApiv2.stats.forEach((f) {
      total += f.baseStat;
      switch (f.stat.name) {
        case 'speed':
          _listaStatus[0] = componentValor(f.baseStat.toString());
          _listaBarStatus[0] = componentStatusBar(f.baseStat / 160, 1);
          break;
        case 'special-defense':
          _listaStatus[1] = componentValor(f.baseStat.toString());
          _listaBarStatus[1] = componentStatusBar(f.baseStat / 160, 1);
          break;
        case 'special-attack':
          _listaStatus[2] = componentValor(f.baseStat.toString());
          _listaBarStatus[2] = componentStatusBar(f.baseStat / 160, 1);
          break;
        case 'defense':
          _listaStatus[3] = componentValor(f.baseStat.toString());
          _listaBarStatus[3] = componentStatusBar(f.baseStat / 160, 1);
          break;
        case 'attack':
          _listaStatus[4] = componentValor(f.baseStat.toString());
          _listaBarStatus[4] = componentStatusBar(f.baseStat / 160, 1);
          break;
        case 'hp':
          _listaStatus[5] = componentValor(f.baseStat.toString());
          _listaBarStatus[5] = componentStatusBar(f.baseStat / 160, 1);
          break;
      }
    });

    _listaStatus[6] = componentValor(total.toString());
    _listaBarStatus[6] = componentStatusBar(total / 600, 1);
  }

  @computed
  PokeApiV2 get pokeApiv2 => _pokeApiv2;

  @observable
  Specie _specie;

  @action
  getSpeciePokemon(int num) {
    _specie = null;

    pokeRepository.getSpeciePokemon(num).then((pokeResult) {
      _specie = pokeResult;
    });
  }

  @computed
  Specie get specie => _specie;

  @observable
  MultiTrackTween _animation;

  @observable
  double _progress;

  @observable
  double _multiple;

  @observable
  double _opacity;

  @observable
  double _opacityTitle;

  @observable
  Pokemon _pokemonAtual;

  @observable
  dynamic _corPokemonAtual;

  @observable
  int posicaoAtual;

  @observable
  List<Pokemon> _pokemons;

  @computed
  List<Pokemon> get pokemons => _pokemons;

  @computed
  Pokemon get getPokemonAtual => _pokemonAtual;

  @computed
  MultiTrackTween get animation => _animation;

  @computed
  double get progress => _progress;

  @computed
  double get multiple => _multiple;

  @computed
  double get opacity => _opacity;

  @computed
  double get opacityTitle => _opacityTitle;

  @computed
  dynamic get corPokemonAtual => _corPokemonAtual;

  @action
  setProgress({double progress}) {
    _progress = progress;
  }

  @action
  setMultiple({double multiple}) {
    _multiple = multiple;
  }

  @action
  setPokemons({List<Pokemon> pokemons}) {
    _pokemons = pokemons;
  }

  @action
  setOpacity({double opacity}) {
    _opacity = opacity;
  }

  @action
  setOpacityTitle({double opacityTitle}) {
    _opacityTitle = opacityTitle;
  }

  @action
  changeState({double progress}) {
    _progress = progress;
    _multiple = 1 - interval(0.0, 0.87, _progress);
    _opacity = _multiple;
    _opacityTitle = _multiple = interval(0.55, 0.87, _progress);
  }

  @action
  setPokemonAtual({Pokemon proximoPokemon, int index}) async {
    _pokemonAtual = proximoPokemon;
    _corPokemonAtual = ConstsApp.getColorType(type: _pokemonAtual.type[0]);
    posicaoAtual = index;

    getSpeciePokemon(int.parse(_pokemonAtual.num));
    await getInfoPokemon(_pokemonAtual.name.toLowerCase());

    getStatusPokemon();
  }

  @action
  double interval(double lower, double upper, double progress) {
    assert(lower < upper);
    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((_progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @action
  Widget componentStatusBar(double widthF, double heightF) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 20, bottom: 17),
      child: Container(
        height: 4,
        alignment: Alignment.centerLeft,
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          color: Colors.grey,
        ),
        child: FractionallySizedBox(
          widthFactor: widthF,
          heightFactor: heightF,
          child: Container(
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: widthF > 0.5 ? Colors.teal : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  @action
  Widget setTipos(List<String> types) {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @action
  Widget sizedBoxPokemon(Widget widget) {
    return SizedBox(height: 80, width: 80, child: widget);
  }

  @action
  List<Widget> getEvolucao(Pokemon _pokemon) {
    List<Widget> _list = [];
    if (_pokemon.prevEvolution != null) {
      _pokemon.prevEvolution.forEach((f) {
        _list.add(sizedBoxPokemon(getImagemPokemon(f.num)));
        _list.add(SizedBox());
        _list.add(Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            f.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
        _list.add(Icon(Icons.keyboard_arrow_down));
      });
    }

    _list.add(sizedBoxPokemon(getImagemPokemon(_pokemon.num)));
    _list.add(Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        _pokemon.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

    if (_pokemon.nextEvolution != null) {
      _pokemon.nextEvolution.forEach((f) {
        _list.add(Icon(Icons.keyboard_arrow_down));
        _list.add(sizedBoxPokemon(getImagemPokemon(f.num)));
        _list.add(Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            f.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      });
    }

    return _list;
  }

  @action
  Widget getImagemPokemon(String numero) {
    return CachedNetworkImage(
      placeholder: (context, url) => new CircularProgressIndicator(
        backgroundColor: Colors.red,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/' +
              numero +
              '.png',
    );
  }
}
