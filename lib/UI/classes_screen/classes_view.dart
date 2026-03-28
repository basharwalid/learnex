import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view_model.dart';
import 'package:learnex/UI/widgets/classes/classes_card.dart';
import 'package:learnex/core/di/di.dart';

class ClassesView extends StatefulWidget {
  static const String routeName = '/classes';

  final int courseId;
  final String courseName;

  const ClassesView({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  final ClassesViewModel viewModel = getIt<ClassesViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadClasses(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.courseName} Classes',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(child: _buildBody()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    }

    if (viewModel.classes.isEmpty) {
      return const Center(child: Text("No classes available."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        childAspectRatio: 1.4,
      ),
      itemCount: viewModel.classes.length,
      itemBuilder: (context, index) => ClassCard(session: viewModel.classes[index]),
    );
  }
}