
import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/repo/Repository.dart';

@Injectable()
class ReserveSeatUseCase{
  final Repository repository;

  ReserveSeatUseCase({required this.repository});

  Future<Results<String?>> call(Map<String, dynamic> body) async {
    final result = await repository.reserveSeat(body);
    return result;
  }
}