import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/use_case/get_all_classes_use_case.dart'; // Your domain model

@injectable
class CourseViewModel extends ChangeNotifier {
  final GetAllClassesUseCase _useCase;

  CourseViewModel(this._useCase);
  List<Classes>? sessions;
  String? errorMessage;
  bool isLoading = false;

  Future<void> loadClasses() async {
    isLoading = true;
    notifyListeners();

    final result = await _useCase.getClasses("English");
    // Handle your 'Results' wrapper logic
    // ... update sessions or errorMessage ...

    isLoading = false;
    notifyListeners();
  }
}