import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/use_case/reserve_seat_use_case.dart';

@injectable
class SeatReservationViewModel extends ChangeNotifier {
  final ReserveSeatUseCase reserveSeatUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? errorMessage;
  String? orderId; // returned from /reserve API

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String get firstName => nameController.text.trim().split(' ').first;

  String get lastName => nameController.text.trim().split(' ').length > 1
      ? nameController.text.trim().split(' ').last
      : 'NA'; // fallback if only one name entered
  SeatReservationViewModel({required this.reserveSeatUseCase});

  /// Returns the order_id on success, null on failure.
  Future<String?> reserveSeat(int classId) async {
    if (isLoading) return null;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await reserveSeatUseCase.call({
        'class_id': classId,
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      });

      switch (result) {
        case Success<String?>():
          orderId = result.data;
          return orderId;
        case Failure<String?>():
          errorMessage = result.message;
          return null;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
