import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/ui/widget/text_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class TabAbout extends StatelessWidget {
  const TabAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();
    var pokemon = controller.pokemon.value;
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      children: [
        buildText('Species', pokemon?.species ?? ''),
        buildText('Height', (pokemon?.height ?? 0).toString()),
        buildText('Weight', (pokemon?.weight ?? 0).toString()),
        buildText(
            'Abilities',
            pokemon?.abilities?.fold(
                    '',
                    (previousValue, element) =>
                        (previousValue ?? '') +
                        element.capitalized +
                        (element == pokemon.abilities?.last ? '' : ', ')) ??
                ''),
      ],
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
