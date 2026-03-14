import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/core/network/safe_call.dart';
import 'package:learnex/data/model/classes_response_dto.dart';
import 'package:learnex/domain/data_source/online_remote_data_source.dart';
import 'package:learnex/domain/model/classes_response.dart';
import 'package:learnex/domain/repo/Repository.dart';

@Injectable(as: Repository)
class RepositoryImplementation implements Repository {
  final OnlineRemoteDataSource _onlineRemoteDataSource;

  RepositoryImplementation(this._onlineRemoteDataSource);

  @override
  Future<Results<List<ClassesResponse>>> getClasses(
      String courseName,
  ) async {
    var response = await _onlineRemoteDataSource.getClasses(
     courseName
    );
    switch (response) {
      case Success<List<ClassesResponseDto>>():
        safeCall<void>(() async {
          return Success(data: null);
        });
        return Success();
      case Failure<List<ClassesResponseDto>>():
        return Failure();
    }
  }
}
