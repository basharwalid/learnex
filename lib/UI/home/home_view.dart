import 'package:flutter/material.dart';
import 'package:learnex/UI/home/home_view_model.dart';
import 'package:learnex/UI/widgets/home_screen_widgets/main_home_screen_course_card.dart';
import 'package:learnex/core/di/di.dart';
import 'package:learnex/core/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.errorMessage != null) {
                  return Center(child: Text(viewModel.errorMessage!));
                }

                if (viewModel.courses.isEmpty) {
                  return const Center(child: Text("No courses available."));
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: "Learnex",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: const TextSpan(
                        text: "Reserve your spot in English, Math, and Programming classes",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: viewModel.courses.map((course) {
                        return MainHomeScreenCourseCard(
                          title: course.name,
                          description: course.description,
                          icon: Icons.book,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.classScreen,
                            arguments: {
                              'courseId': course.id,
                              'courseName': course.name,
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}