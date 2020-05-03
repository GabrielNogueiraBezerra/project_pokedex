import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/consts/const_app.dart';
import 'package:project/app/modules/home/models/pokemon.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import '../detail_controller.dart';

class PokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailController controller = Modular.get<DetailController>();

    return Opacity(
      child: Padding(
        child: SizedBox(
          height: 150,
          child: PageView.builder(
              onPageChanged: (index) {
                controller.setPokemonAtual(
                    proximoPokemon: controller.pokemons[index], index: index);
              },
              controller: PageController(
                  initialPage: controller.posicaoAtual, viewportFraction: 0.5),
              itemCount: controller.pokemons.length,
              itemBuilder: (BuildContext context, int indexList) {
                Pokemon _pokeitem = controller.pokemons[indexList];
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ControlledAnimation(
                      playback: Playback.LOOP,
                      duration: controller.animation.duration,
                      tween: controller.animation,
                      builder: (context, animation) {
                        return Transform.rotate(
                          child: Hero(
                            child: Opacity(
                              child: Image.asset(
                                ConstsApp.whitePokeball,
                                height: 270,
                                width: 270,
                              ),
                              opacity: (controller.posicaoAtual == indexList)
                                  ? 0.2
                                  : 0.0,
                            ),
                            tag: indexList.toString(),
                          ),
                          angle: animation['rotation'],
                        );
                      },
                    ),
                    IgnorePointer(
                      child: Observer(
                        builder: (BuildContext context) {
                          return AnimatedPadding(
                            child: CachedNetworkImage(
                              height: 160,
                              width: 160,
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(
                                backgroundColor: Colors.red,
                              ),
                              color: indexList == controller.posicaoAtual
                                  ? null
                                  : Colors.black.withOpacity(0.5),
                              imageUrl:
                                  'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
                            ),
                            duration: Duration(milliseconds: 400),
                            curve: Curves.bounceInOut,
                            padding: EdgeInsets.only(
                              top:
                                  indexList == controller.posicaoAtual ? 0 : 60,
                              bottom:
                                  indexList == controller.posicaoAtual ? 0 : 60,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
        padding: EdgeInsets.only(
            top: (controller.opacityTitle > 0.9)
                ? 1000
                : (MediaQuery.of(context).size.height * 0.25) -
                    (controller.progress * 50)),
      ),
      opacity: controller.opacity,
    );
  }
}
