import 'package:project/app/modules/home/pages/detail/detail_controller.dart';
import 'package:dio/dio.dart';
import 'package:project/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:project/app/modules/home/home_page.dart';
import 'package:project/app/modules/home/pages/detail/detail_page.dart';
import 'package:project/app/modules/home/repositories/poke_repository.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get<PokeRepository>())),
        Bind((i) => DetailController(i.get<PokeRepository>())),
        Bind((i) => PokeRepository(i.get<Dio>())),
        Bind((i) => Dio()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
        Router('/detail/:index',
            child: (_, args) => DetailPage(
                  index: int.parse(args.params['index']),
                  pokemons: args.data,
                ),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
