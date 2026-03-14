import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view_model.dart';
import 'package:learnex/UI/widgets/classes/classes_card.dart';
import 'package:learnex/core/di/di.dart';

class ClassesView extends StatefulWidget {
  static const String routeName = '/course';

  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  // Pull the ViewModel from GetIt
  final CourseViewModel viewModel = getIt<CourseViewModel>();

  @override
  void initState() {
    super.initState();
    // Trigger the data fetch
    viewModel.loadClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: ListenableBuilder(
          // Listens to changes in the ViewModel
          listenable: viewModel,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "English Classes",
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

    final sessions = viewModel.sessions ?? [];

    if (sessions.isEmpty) {
      return const Center(child: Text("No classes available."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        childAspectRatio: 1.4,
      ),
      itemCount: sessions.length,
      itemBuilder: (context, index) => ClassCard(session: sessions[index]),
    );
  }
}
