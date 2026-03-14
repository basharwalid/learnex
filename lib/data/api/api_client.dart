import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:learnex/data/model/classes_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.mainRoute)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(ApiConstants.classesRoute)
  Future<ClassesResponseDto> getClasses(
      @Path(ApiConstants.classesRoute) String courseName,
  );
}
