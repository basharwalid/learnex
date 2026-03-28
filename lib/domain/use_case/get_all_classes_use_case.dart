import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/repo/Repository.dart';

@Injectable()
class GetAllClassesUseCase {
  final Repository _repository;

  GetAllClassesUseCase(this._repository);

  Future<Results<List<Class>>> call(int courseId) async {
    return await _repository.getClasses(courseId);
  }
}