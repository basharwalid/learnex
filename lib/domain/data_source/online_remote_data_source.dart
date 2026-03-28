import 'package:learnex/core/network/results.dart';
import 'package:learnex/data/model/class_dto.dart';

import 'package:learnex/data/model/course_dto.dart';

abstract class OnlineRemoteDataSource {
  Future<Results<List<ClassDto>>> getClasses(int courseId);
  Future<Results<List<CourseDto>>> getCourses();
}