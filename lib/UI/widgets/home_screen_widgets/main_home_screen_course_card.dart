import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view.dart';

class MainHomeScreenCourseCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const MainHomeScreenCourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<MainHomeScreenCourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<MainHomeScreenCourseCard> {

  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 330,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: hover ? 25 : 10,
              color: Colors.black12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Icon
            Icon(
              widget.icon,
              size: 40,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            /// Title
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// Description
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            /// Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesView(),));
              },
              child: const Text("View Classes"),
            )
          ],
        ),
      ),
    );
  }
}