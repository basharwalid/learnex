import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/data/model/class_dto.dart';
import 'package:learnex/data/model/course_dto.dart';
import 'package:learnex/domain/data_source/online_remote_data_source.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:learnex/domain/repo/Repository.dart';

@Injectable(as: Repository)
class RepositoryImplementation implements Repository {
  final OnlineRemoteDataSource _onlineRemoteDataSource;

  RepositoryImplementation(this._onlineRemoteDataSource);

  @override
  Future<Results<List<Class>>> getClasses(int courseId) async {
    var response = await _onlineRemoteDataSource.getClasses(courseId);
    switch (response) {
      case Success<List<ClassDto>>():
        return Success(data: response.data!.map((e) => e.toDomain()).toList());
      case Failure<List<ClassDto>>():
        return Failure(message: response.message);
    }
  }

  @override
  Future<Results<List<Course>>> getCourses() async {
    var response = await _onlineRemoteDataSource.getCourses();
    switch (response) {
      case Success<List<CourseDto>>():
        return Success(data: response.data!.map((e) => e.toDomain()).toList());
      case Failure<List<CourseDto>>():
        return Failure(message: response.message);
    }
  }
}
