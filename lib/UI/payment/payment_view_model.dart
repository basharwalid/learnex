import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:learnex/domain/model/payment/payment_intention.dart';
import 'package:learnex/domain/use_case/create_payment_intention_use_case.dart';

@injectable
class PaymentViewModel extends ChangeNotifier {
  final CreatePaymentIntentionUseCase createPaymentIntentionUseCase;

  PaymentViewModel({required this.createPaymentIntentionUseCase});

  bool isLoading = false;
  String? errorMessage;
  PaymentIntention? paymentIntention;

  Future<PaymentIntention?> createPaymentIntention({
    required int amount,
    required List<int> paymentMethods,
    required Course selectedCourse,
    required String orderId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    if (isLoading) return null;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await createPaymentIntentionUseCase.call({
        'amount': amount,
        'currency': 'EGP',
        'payment_methods': paymentMethods,
        'items': [
          {
            'name': selectedCourse.name,
            'amount': amount,
            'description': 'Seat Reservation',
            'quantity': 1,
          },
        ],
        'billing_data': {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone,
          'apartment': 'NA',
          'floor': 'NA',
          'street': 'NA',
          'building': 'NA',
          'city': 'NA',
          'country': 'NA',
          'state': 'NA',
        },
        'special_reference': orderId,
        'expiration': 3600,
      });

      switch (result) {
        case Success<PaymentIntention>():
          paymentIntention = result.data;
          return paymentIntention;
        case Failure<PaymentIntention>():
          errorMessage = result.message;
          return null;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}