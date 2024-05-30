import 'package:dio/dio.dart';
import 'package:your_project_name/core/constants/api_constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,

    ));
  }

  static Future<Response> getData({
    required endPoint,
    required Map<String, dynamic> query,
    String? token,
  }) async {
    return await dio.get(endPoint, queryParameters: query);
  }
}
