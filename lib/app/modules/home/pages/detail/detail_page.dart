import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/modules/home/models/pokemon.dart';
import 'package:project/app/modules/home/pages/detail/detail_controller.dart';
import 'package:project/app/modules/home/pages/detail/widget/about_page.dart';
import 'package:project/app/modules/home/pages/detail/widget/information_page.dart';
import 'package:project/app/modules/home/pages/detail/widget/pokemon_page.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final List<Pokemon> pokemons;

  const DetailPage({Key key, this.index, this.pokemons}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(this.pokemons, this.index);
}

class _DetailPageState extends ModularState<DetailPage, DetailController> {
  final List<Pokemon> pokemons;
  final int index;

  _DetailPageState(this.pokemons, this.index) {
    controller.setPokemons(pokemons: pokemons);
    controller.setPokemonAtual(proximoPokemon: pokemons[index], index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          InformationPage(),
          SlidingSheet(
            listener: (state) {
              setState(() {
                controller.changeState(progress: state.progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.60, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.12),
                child: AboutPage(),
              );
            },
          ),
          PokemonPage(),
        ],
      ),
    );
  }
}
