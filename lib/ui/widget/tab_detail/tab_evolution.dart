import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/default/helper.dart';
import 'package:pokemonapps/default/theme.dart';
import 'package:pokemonapps/ui/widget/circle_background.dart';
import 'package:velocity_x/velocity_x.dart';

class TabEvolution extends GetView<DataController> {
  const TabEvolution({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final listPokemon = controller.listPokemon.value?.results;
    final id = controller.selectedId.value;
    var evo = 0;
    if (id % 3 == 1) evo = 0;
    if (id % 3 == 2) evo = 1;
    if (id % 3 == 0) evo = 2;
    var evo1 = id - evo;
    var evo2 = id - evo + 1;
    var evo3 = id - evo + 2;

    bool isEnable(int id) {
      return id < (listPokemon?.length ?? 0);
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 22,
        horizontal: 20,
      ),
      children: [
        if (isEnable(evo1 - 1)) buildItem((listPokemon?[evo1 - 1].name), evo1),
        if (isEnable(evo2 - 1))
          buildItem((listPokemon?[evo2 - 1].name), evo2, isReverse: true),
        if (isEnable(evo3 - 1)) buildItem((listPokemon?[evo3 - 1].name), evo3),
      ],
    );
  }

  Widget buildItem(String? title, int value, {bool isReverse = false}) {
    final color = controller.listColor.value?[controller.selectedId.value - 1];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color?.withOpacity(0.5),
      ),
      child: Row(
        textDirection: isReverse ? TextDirection.rtl : null,
        children: [
          Text(
            (title ?? '').capitalized,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: BaseTheme.fontSizeLarge,
            ),
            textAlign: TextAlign.center,
          ).expand(),
          Stack(
            textDirection: isReverse ? TextDirection.rtl : null,
            alignment: Alignment.center,
            children: [
              const CircleBackground(
                height: 140,
                width: 140,
              ).positioned(
                right: 0,
                left: 0,
                top: 40,
              ),
              SvgPicture.network(
                Helper().getImage(value),
                height: 120,
                width: 120,
              ).p4(),
            ],
          ).expand(),
        ],
      ),
    ).py4();
  }
}
