import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/data/api/api_client.dart';
import 'package:learnex/data/model/class_dto.dart';
import 'package:learnex/data/model/course_dto.dart';
import 'package:learnex/domain/data_source/online_remote_data_source.dart';

@LazySingleton(as: OnlineRemoteDataSource)
class OnlineRemoteDataSourceImpl implements OnlineRemoteDataSource {
  final ApiClient _apiClient;

  OnlineRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Results<List<ClassDto>>> getClasses(int courseId) async {
    try {
      var result = await _apiClient.getClasses(courseId);
      return Success(data: result);
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<Results<List<CourseDto>>> getCourses() async {
    try {
      final result = await _apiClient.getCourses();
      return Success(data: result);
    } catch (e) {
      return Failure(message: e.toString());
    }
  }
}
