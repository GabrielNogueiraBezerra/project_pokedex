import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/modules/home/pages/detail/detail_controller.dart';
import 'package:project/app/modules/home/pages/detail/widget/circular_progress_poke.dart';

class AbaStatus extends StatelessWidget {
  final DetailController controller = Modular.get<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
        child: Observer(builder: (context) {
          return (controller.pokeApiv2 != null)
              ? Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        componentText('Velocidade'),
                        componentText('Sp. Def'),
                        componentText('Sp. Atc'),
                        componentText('Defesa'),
                        componentText('Ataque'),
                        componentText('HP'),
                        componentText('Total'),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: controller.listaStatus,
                    ),
                    Expanded(
                      child: Column(
                        children: controller.listaBarStatus,
                      ),
                    ),
                  ],
                )
              : CircularProgressPoke(color: controller.corPokemonAtual);
        }),
      ),
    );
  }

  Widget componentText(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
