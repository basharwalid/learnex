import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:learnex/domain/use_case/get_all_courses_use_case.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  final GetAllCoursesUseCase _useCase;

  HomeViewModel(this._useCase);

  List<Course> courses = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _useCase();

    switch (result) {
      case Success<List<Course>>():
        courses = result.data ??[];
      case Failure<List<Course>>():
        errorMessage = result.message ?? "something went wrong";
    }

    isLoading = false;
    notifyListeners();
  }
}