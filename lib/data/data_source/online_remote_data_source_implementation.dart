import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/core/network/safe_call.dart';
import 'package:learnex/data/api/api_client.dart';
import 'package:learnex/data/model/classes_response_dto.dart';
import 'package:learnex/domain/data_source/online_remote_data_source.dart';

@Injectable(as: OnlineRemoteDataSource)
class OnlineRemoteDataSourceImplementation implements OnlineRemoteDataSource {
  final ApiClient _apiClient;

  OnlineRemoteDataSourceImplementation(this._apiClient);

  @override
  Future<Results<List<ClassesResponseDto>>> getClasses(String courseName) {
    return safeCall(() async {
      var response = await _apiClient.getClasses(
          courseName);
      if (response is Failure) {
        return Failure();
      }
      return Success();
    });
  }
}
