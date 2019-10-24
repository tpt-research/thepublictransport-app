import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';

class SuperchargedHTTP {
  static Future<dynamic> request({@required String URL,
    @required int timeout}) async {

    BaseOptions options = BaseOptions(
      connectTimeout: timeout,
      responseType: ResponseType.json
    );

    Dio handler = Dio(options);
    handler.transformer = FlutterTransformer();
    handler.interceptors.add(
        DioCacheManager(
            CacheConfig(
              defaultMaxAge: Duration(seconds: 30)
            )
        ).interceptor
    );

    Response<dynamic> response;

    try {
      response = await handler.get(
          URL
      );
    } on DioError catch(e) {
      if(e.response != null) {
        print("Did not result to 200");
        return null;
      } else {
        print("Request failed");
        return null;
      }
    }

    return response.data;
  }

  static Future<dynamic> requestAdvanced({@required String URL,
    @required int timeout, @required Map<String, dynamic> headers}) async {

    BaseOptions options = BaseOptions(
        connectTimeout: timeout,
        responseType: ResponseType.json,
        headers: headers
    );

    Dio handler = Dio(options);
    handler.transformer = FlutterTransformer();
    handler.interceptors.add(
        DioCacheManager(
            CacheConfig(
                defaultMaxAge: Duration(seconds: 30)
            )
        ).interceptor
    );

    Response<dynamic> response;

    try {
      response = await handler.get(
          URL
      );
    } on DioError catch(e) {
      if(e.response != null) {
        print("Did not result to 200");
        return null;
      } else {
        print("Request failed");
        return null;
      }
    }

    return response.data;
  }
}