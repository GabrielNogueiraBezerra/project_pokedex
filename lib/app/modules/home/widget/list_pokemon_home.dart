import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/modules/home/home_controller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project/app/modules/home/models/pokemon.dart';
import 'package:project/app/modules/home/widget/item_list_pokemon.dart';

class ListPokemonHome extends StatelessWidget {
  final HomeController controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(child: Observer(
        builder: (BuildContext context) {
          return (controller.pokeApi != null)
              ? AnimationLimiter(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(12),
                    addAutomaticKeepAlives: true,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: controller.pokeApi.pokemon.length,
                    itemBuilder: (context, index) {
                      Pokemon pokemon = controller.getPokemon(index: index);

                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: GestureDetector(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ItemListPokemon(
                                  types: pokemon.type,
                                  index: index,
                                  name: pokemon.name,
                                  num: pokemon.num,
                                )),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/home/detail/' + index.toString(),
                                  arguments: controller.pokeApi.pokemon);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(child: CircularProgressIndicator()),
              );
        },
      )),
    );
  }
}
