import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:learnex/data/api/api_client.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get dio {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.mainRoute));
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (o) => print(o.toString()),
      ),
    );
    return dio;
  }

  @singleton
  ApiClient apiClient(Dio dio) => ApiClient(dio);
}
