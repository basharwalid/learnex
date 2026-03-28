import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/core/network/results.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/use_case/get_all_classes_use_case.dart';

@injectable
class ClassesViewModel extends ChangeNotifier {
  final GetAllClassesUseCase _useCase;

  ClassesViewModel(this._useCase);

  List<Class> classes = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> loadClasses(int courseId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _useCase(courseId);

    switch (result) {
      case Success<List<Class>>():
        classes = result.data ?? [];
      case Failure<List<Class>>():
        errorMessage = result.message ?? "something went wrong";
    }

    isLoading = false;
    notifyListeners();
  }
}
