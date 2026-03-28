import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:learnex/domain/repo/Repository.dart';


@injectable
class GetAllCoursesUseCase {
  final Repository _repository;

  GetAllCoursesUseCase(this._repository);

  Future<Results<List<Course>>> call() async {
    return await _repository.getCourses();
  }
}