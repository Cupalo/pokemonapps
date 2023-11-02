import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/ui/widget/text_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class TabMoves extends StatelessWidget {
  const TabMoves({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();
    final pokemon = controller.pokemon.value;
    final color = controller.listColor.value?[controller.selectedId.value - 1];
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      children: (pokemon?.moves ?? []).mapIndexed((e, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color?.withOpacity(0.5),
          ),
          child: TextValue(text: e.capitalized).centered().p8(),
        ).py2();
      }).toList(),
    );
  }

  Widget buildText(String title, String value) {
    return Row(
      children: [
        TextTitle(text: title).expand(),
        TextValue(
          text: value,
        ).expand(flex: 2),
      ],
    ).py4();
  }
}
