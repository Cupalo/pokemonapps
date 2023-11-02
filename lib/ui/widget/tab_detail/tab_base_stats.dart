import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/ui/widget/text_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class TabBaseStats extends StatelessWidget {
  const TabBaseStats({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();
    final pokemon = controller.pokemon.value;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      children: [
        buildText('HP', pokemon?.stats?.hp ?? 0),
        buildText('Attack', pokemon?.stats?.attack ?? 0),
        buildText('Defense', pokemon?.stats?.defense ?? 0),
        buildText('Sp. Atk', pokemon?.stats?.spAtk ?? 0),
        buildText('Sp. Def', pokemon?.stats?.spDef ?? 0),
        buildText('Speed', pokemon?.stats?.speed ?? 0),
        buildText('Total', pokemon?.stats?.total ?? 0, isTotal: true),
        const TextCategory(text: 'Type Defense').pOnly(top: 16, bottom: 8),
        TextTitle(
            text:
                'The effectiveness of each type on ${(pokemon?.name ?? '').capitalize}')
      ],
    );
  }

  Widget buildText(String title, num value, {bool isTotal = false}) {
    var valueProgres = value;
    var max = (isTotal ? 600 : 100);
    var half = isTotal ? 300 : 50;
    return Row(
      children: [
        TextTitle(text: title).expand(),
        Row(
          children: [
            TextValue(
              text: value.toString(),
            ).expand(),
            LinearProgressIndicator(
              value: valueProgres / max,
              color: Colors.grey,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(
                valueProgres > half ? Colors.green : Colors.red,
              ),
            ).px12().expand(flex: 6),
          ],
        ).expand(flex: 2),
      ],
    ).py4();
  }
}
