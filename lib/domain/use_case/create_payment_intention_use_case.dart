import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/payment/payment_intention.dart';
import 'package:learnex/domain/repo/Repository.dart';

@injectable
class CreatePaymentIntentionUseCase {
  final Repository repository;

  CreatePaymentIntentionUseCase({required this.repository});

  Future<Results<PaymentIntention>> call(Map<String, dynamic> body) async {
    final result = await repository.createPaymentIntention(body);
    return result;
  }
}