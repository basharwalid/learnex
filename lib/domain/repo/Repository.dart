import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/classes_response.dart';

abstract class Repository{
  Future<Results<List<ClassesResponse>>> getClasses(String courseName);
}