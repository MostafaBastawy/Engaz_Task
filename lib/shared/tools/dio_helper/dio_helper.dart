import 'package:dio/dio.dart';
import 'package:engaz_task/shared/tools/dio_helper/end_points.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    Map<String, dynamic>? headers,
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio.options.headers = headers;
    return await dio.get(
      endPoint,
      queryParameters: queryParameters,
    );
  }
}
