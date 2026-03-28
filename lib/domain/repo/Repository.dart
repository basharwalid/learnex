import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';

abstract class Repository {
  Future<Results<List<Class>>> getClasses(int courseId);
  Future<Results<List<Course>>> getCourses();
}
