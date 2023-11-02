import 'package:flutter/material.dart';

class Helper {
  static String titleApps = 'Pokedex';
  static String svgUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/';

  String getImage(int index) => '$svgUrl$index.svg';

  List<Color> getListColor({int? length}) {
    var colorBg = const Color(0xFF439047);
    int dynamicColor = 0xFF439047;
    int initial = 0xFF439047;
    var listColor = List.generate(
      length ?? 20,
      (index) {
        if (index != 0 && index % 3 == 0) {
          dynamicColor = initial * index;
          colorBg = Color(dynamicColor);
        }
        return colorBg;
      },
    );
    return listColor;
  }
}
