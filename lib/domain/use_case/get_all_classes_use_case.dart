import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/classes_response.dart';
import 'package:learnex/domain/repo/Repository.dart';

@Injectable()
class GetAllClassesUseCase {
  Repository _repository;

  GetAllClassesUseCase(this._repository);

  Future<Results<List<ClassesResponse>>> getClasses(
      String courseName,
  ) async {
    var response = await _repository.getClasses(courseName);
    switch (response) {
      case Success<List<ClassesResponse>>():
        return Success();
      case Failure<List<ClassesResponse>>():
        return Failure();
    }
  }
}
