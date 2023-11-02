import 'package:flutter/material.dart';

class Pokemon {
  Pokemon({
    this.name,
    this.types,
    this.id,
    this.abilities,
    this.species,
    this.stats,
    this.moves,
    this.height,
    this.weight,
  });

  final int? id;
  final List<String>? abilities;
  final String? name;
  final String? species;
  final List<String>? types;
  final Stats? stats;
  final List<String>? moves;
  final int? height;
  final int? weight;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    try {
      return Pokemon(
        id: json["id"],
        abilities: json["abilities"] == null
            ? null
            : List.from(json['abilities'])
                .map((e) => e['ability']['name'] as String)
                .toList(),
        name: json["name"],
        species: json['species']['name'],
        types: List.from(json['types'])
            .map((e) => e['type']['name'] as String)
            .toList(),
        stats: json['stats'] == null
            ? null
            : Stats.fromListJson(List.from(json['stats'])),
        moves: json['moves'] == null
            ? null
            : List.from(json['moves'])
                .map((e) => e['move']['name'] as String)
                .toList(),
        height: json['height'],
        weight: json['weight'],
      );
    } catch (e) {
      debugPrint('error pokemon from json : ${e.toString()}');
      throw e.toString();
    }
  }
}

class Stats {
  Stats({
    this.hp,
    this.attack,
    this.defense,
    this.spAtk,
    this.spDef,
    this.speed,
    this.total,
  });

  final num? hp;
  final num? attack;
  final num? defense;
  final num? spAtk;
  final num? spDef;
  final num? speed;
  final num? total;

  factory Stats.fromListJson(List<dynamic> listJson) => Stats(
        hp: listJson[0]["base_stat"],
        attack: listJson[1]["base_stat"],
        defense: listJson[2]['base_stat'],
        spAtk: listJson[3]['base_stat'],
        spDef: listJson[4]['base_stat'],
        speed: listJson[5]['base_stat'],
        total: listJson.fold(
            0,
            (previousValue, element) =>
                (previousValue ?? 0) + ((element['base_stat'] as num))),
      );
}
