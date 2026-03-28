import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:learnex/data/model/class_dto.dart';
import 'package:learnex/data/model/course_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.mainRoute)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(ApiConstants.coursesRoute)
  Future<List<CourseDto>> getCourses();

  @GET(ApiConstants.classesFromCourses)
  Future<List<ClassDto>> getClasses(@Path('course_id') int courseId);
}
