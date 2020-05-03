import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/consts/const_app.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import '../detail_controller.dart';

class InformationPage extends StatelessWidget {
  final DetailController controller = Modular.get<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ConstsApp.getColorType(
                  type: controller.getPokemonAtual.type[0],
                ).withOpacity(0.7),
                ConstsApp.getColorType(
                  type: controller.getPokemonAtual.type[0],
                )
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/home/'));
                  },
                ),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ControlledAnimation(
                            playback: Playback.LOOP,
                            duration: controller.animation.duration,
                            tween: controller.animation,
                            builder: (context, animation) {
                              return Transform.rotate(
                                child: Opacity(
                                  opacity: controller.opacityTitle / 4,
                                  child: Hero(
                                    tag: '',
                                    child: Image.asset(
                                      ConstsApp.whitePokeball,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                                angle: animation['rotation'],
                              );
                            }),
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.115) -
                    controller.progress *
                        (MediaQuery.of(context).size.height * 0.058),
                left: 20 +
                    controller.progress *
                        (MediaQuery.of(context).size.height * 0.060),
                child: Text(
                  controller.getPokemonAtual.name,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 38 -
                          controller.progress *
                              (MediaQuery.of(context).size.height * 0.0215),
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height * 0.16),
                child: Opacity(
                  opacity: controller.opacityTitle > 0.9 ? 0 : 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          controller.setTipos(controller.getPokemonAtual.type),
                          Text(
                            '#' + controller.getPokemonAtual.num.toString(),
                            style: TextStyle(
                                fontFamily: 'Google',
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
        );
      },
    );
  }
}
