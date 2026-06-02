import 'package:learnex/core/network/results.dart';
import 'package:learnex/data/model/class_dto.dart';

import 'package:learnex/data/model/course_dto.dart';
import 'package:learnex/data/model/payment/Payment_intention_dto.dart';

abstract class OnlineRemoteDataSource {
  Future<Results<List<ClassDto>>> getClasses(int courseId);

  Future<Results<List<CourseDto>>> getCourses();

  Future<Results<String?>> reserveSeat(Map<String, dynamic> body);

  Future<Results<PaymentIntentionDto>> createPaymentIntention(
    Map<String, dynamic> body,
  );
}
