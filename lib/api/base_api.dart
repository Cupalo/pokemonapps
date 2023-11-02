import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

class BaseApi {
  static Dio dio = Dio();

  static String baseApi = 'https://pokeapi.co/api/v2/pokemon/';
  static String querryLimit = '?limit=30';

  static Future<Response<dynamic>?> handleApi(
      Future<Response<dynamic>> dio) async {
    try {
      var response = await dio;

      if (response.statusCode == 200) {
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
      return null;
    }
  }

  static Future<Response<dynamic>?> getData() async {
    var response = await handleApi(dio.get(baseApi));

    return response;
  }

  static Future<Response<dynamic>?> getDetail(int id) async {
    var response = await handleApi(dio.get('$baseApi$id'));

    return response;
  }
}
