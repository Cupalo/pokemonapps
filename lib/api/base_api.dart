import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
// import 'package:get/get.dart';
import 'package:pokemonapps/models/items.dart';
import 'package:pokemonapps/models/pokemon.dart';

class BaseApi {
  static Dio dio = Dio();

  static String baseApi = 'https://pokeapi.co/api/v2/pokemon/';
  static String querryLimit = '?limit=30';

  static Future<Response<dynamic>?> handleApi(
      Future<Response<dynamic>> dio) async {
    try {
      var response = await dio;

      if (kDebugMode) {
        print('Status Code : ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response);
        }
        var result = response;
        return result;
      } else {
        return null;
      }
    } on DioError {
      Get.snackbar('Get Data', 'Something went wrong');
      return null;
    } catch (e) {
      Get.snackbar('Get Data', e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  static Future<Data?> getData() async {
    var response = await handleApi(
      dio.get(baseApi),
    );

    if (response != null) {
      var list = Data.fromJson(response.data);
      return list;
    } else {
      return null;
    }
  }

  static Future<Pokemon?> getDetail(int id) async {
    var response = await handleApi(dio.get('$baseApi$id'));

    if (response != null) {
      var list = Pokemon.fromJson(response.data);
      return list;
    } else {
      return null;
    }
  }
}
