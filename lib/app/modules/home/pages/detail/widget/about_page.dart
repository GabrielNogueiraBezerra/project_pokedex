import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:mobx/mobx.dart';
import 'package:project/app/modules/home/pages/detail/detail_controller.dart';
import 'package:project/app/modules/home/pages/detail/widget/aba_evolucao.dart';
import 'package:project/app/modules/home/pages/detail/widget/aba_sobre.dart';
import 'package:project/app/modules/home/pages/detail/widget/aba_status.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  ReactionDisposer _disposer;
  final DetailController controller = Modular.get<DetailController>();

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);

    _disposer = reaction(
        (f) => controller.getPokemonAtual,
        (r) => _pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ));
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: PreferredSize(
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  controller: _tabController,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: controller.corPokemonAtual,
                  unselectedLabelColor: Color(0xff5f6368),
                  isScrollable: true,
                  indicator: MD2Indicator(
                    indicatorHeight: 3,
                    indicatorColor: controller.corPokemonAtual,
                    indicatorSize: MD2IndicatorSize.normal,
                  ),
                  tabs: <Widget>[
                    Tab(
                      text: "Sobre",
                    ),
                    Tab(
                      text: "Evolução",
                    ),
                    Tab(
                      text: "Status",
                    ),
                  ],
                ),
                preferredSize: Size.fromHeight(40),
              ),
            ),
            body: PageView(
              onPageChanged: (index) {
                setState(() {
                  _tabController.animateTo(
                    index,
                    duration: Duration(milliseconds: 300),
                  );
                });
              },
              controller: _pageController,
              children: <Widget>[
                AbaSobre(),
                AbaEvolucao(),
                AbaStatus(),
              ],
            ));
      },
    );
  }
}
