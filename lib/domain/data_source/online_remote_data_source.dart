import 'package:learnex/core/network/results.dart';
import 'package:learnex/data/model/classes_response_dto.dart';

abstract class OnlineRemoteDataSource {
  Future<Results<List<ClassesResponseDto>>> getClasses(
      String courseName
  );
}
