import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/api/base_api.dart';
import 'package:pokemonapps/models/items.dart';
import 'package:pokemonapps/models/pokemon.dart';

class DataController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  var listitem = Data(page: 1, results: []).obs;
  var searchLoading = false.obs;
  var pokemon = Rxn<Pokemon>();
  var listPokemon = Rxn<Data>();
  var listColor = Rxn<List<Color>>();
  var selectedId = 1.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  Future<Data?> getData() async {
    var response = await BaseApi.getData();

    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<Pokemon?> getDetail(int id) async {
    debugPrint('test');
    var response = await BaseApi.getDetail(id);
    debugPrint('test 2');

    if (response != null) {
      debugPrint('test 3');
      return response;
    } else {
      debugPrint('test 4');
      return null;
    }
  }
}
