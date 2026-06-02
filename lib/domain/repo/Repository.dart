import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:learnex/domain/model/payment/payment_intention.dart';

abstract class Repository {
  Future<Results<List<Class>>> getClasses(int courseId);
  Future<Results<List<Course>>> getCourses();
  Future<Results<String?>>  reserveSeat(Map<String, dynamic> body);
  Future<Results<PaymentIntention>> createPaymentIntention(
      Map<String, dynamic> body,
      );
}