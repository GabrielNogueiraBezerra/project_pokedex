import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/modules/home/pages/detail/detail_controller.dart';

class AbaEvolucao extends StatefulWidget {
  @override
  _AbaEvolucaoState createState() => _AbaEvolucaoState();
}

class _AbaEvolucaoState extends State<AbaEvolucao> {
  DetailController controller = Modular.get<DetailController>();

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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: controller.getEvolucao(controller.getPokemonAtual),
            ),
          );
        }),
      ),
    );
  }
}
