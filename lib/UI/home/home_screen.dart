import 'package:flutter/material.dart';
import 'package:learnex/UI/widgets/home_screen_widgets/main_home_screen_course_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fc),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title
                RichText(
                  text: TextSpan(
                    text: "Learnex",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Subtitle
                RichText(
                  text: TextSpan(
                    text:
                        "Reserve your spot in English, Math, and Programming classes",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                /// Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    MainHomeScreenCourseCard(
                      title: "English",
                      description:
                          "Improve your English skills with our expert teachers.",
                      icon: Icons.language,
                    ),
                    MainHomeScreenCourseCard(
                      title: "Math",
                      description:
                          "Master mathematics with interactive lessons.",
                      icon: Icons.calculate,
                    ),
                    MainHomeScreenCourseCard(
                      title: "Programming",
                      description: "Learn programming from basics to advanced.",
                      icon: Icons.code,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
