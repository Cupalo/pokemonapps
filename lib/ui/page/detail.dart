import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/default/helper.dart';
import 'package:pokemonapps/default/theme.dart';
import 'package:pokemonapps/models/pokemon.dart';
import 'package:pokemonapps/ui/widget/circle_background.dart';
import 'package:pokemonapps/ui/widget/tab_detail/tab_about.dart';
import 'package:pokemonapps/ui/widget/tab_detail/tab_base_stats.dart';
import 'package:pokemonapps/ui/widget/tab_detail/tab_evolution.dart';
import 'package:pokemonapps/ui/widget/tab_detail/tab_moves.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailPage extends StatelessWidget {
  DetailPage({
    super.key,
    required this.id,
  });
  final int id;

  final controller = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    final color = controller.listColor.value?[controller.selectedId.value - 1];
    return Scaffold(
      backgroundColor: color,
      body: FutureBuilder<Pokemon?>(
          future: controller.getDetail(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return BaseTheme.loading().centered();
            }
            if (!snapshot.hasData) return Container();
            if (snapshot.data == null) return Container();
            controller.pokemon.value = snapshot.data;
            var pokemon = controller.pokemon.value;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.keyboard_backspace,
                    ).onTap(() {
                      Get.back();
                    }),
                    trailing: const Icon(
                      Icons.favorite_outline,
                    ).px12(),
                    iconColor: Colors.white,
                  ).pOnly(top: 30),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (pokemon?.name ?? '').capitalized,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: BaseTheme.fontSizeHuge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            spacing: 8,
                            children: (pokemon?.types ?? []).map((e) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Text(
                                  (e).capitalized,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: BaseTheme.fontSizeNormal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).py8().px16(),
                              );
                            }).toList(),
                          ).py8(),
                        ],
                      ).pOnly(left: 20),
                      const CircleBackground(
                        height: 300,
                        width: 300,
                      ).positioned(
                        right: -20,
                        left: 60,
                        top: 100,
                      ),
                      Obx(() {
                        return Container(
                          height: 400,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              TabBar(
                                controller: controller.tabController,
                                indicatorColor: Colors.black,
                                padding: EdgeInsets.zero,
                                tabs: [
                                  Tab(
                                    child: tabItem(
                                      'About',
                                      controller.tabIndex.value,
                                      0,
                                    ),
                                  ),
                                  Tab(
                                    child: tabItem(
                                      'Base Stats',
                                      controller.tabIndex.value,
                                      1,
                                    ),
                                  ),
                                  Tab(
                                    child: tabItem(
                                      'Evolution',
                                      controller.tabIndex.value,
                                      2,
                                    ),
                                  ),
                                  Tab(
                                    child: tabItem(
                                      'Moves',
                                      controller.tabIndex.value,
                                      3,
                                    ),
                                  ),
                                ],
                              ).pOnly(top: 30).px12(),
                              TabBarView(
                                controller: controller.tabController,
                                children: const [
                                  TabAbout(),
                                  TabBaseStats(),
                                  TabEvolution(),
                                  TabMoves(),
                                ],
                              ).expand(),
                            ],
                          ),
                        ).pOnly(top: 320);
                      }),
                      StreamBuilder<bool>(
                        initialData: true,
                        stream: Stream.periodic(const Duration(seconds: 1),
                            (computationCount) {
                          return computationCount % 2 == 0 ||
                              computationCount == 0;
                        }),
                        builder: (context, snapshot) {
                          return AnimatedPositioned(
                            duration: const Duration(seconds: 1),
                            top: snapshot.data ?? true ? 100 : 110,
                            left: 0,
                            right: 0,
                            child: SvgPicture.network(
                              Helper().getImage(id),
                              height: 250,
                              width: 250,
                            ),
                            onEnd: () {},
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget tabItem(String text, int value, int index) {
    return Tab(
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: value == index ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
