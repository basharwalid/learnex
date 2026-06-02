import 'package:flutter/material.dart';
import 'package:learnex/UI/home/home_view_model.dart';
import 'package:learnex/core/di/di.dart';
import 'package:learnex/core/routes/routes.dart';

// ── Brand tokens ────────────────────────────────────────────────────────────
class _EduExColors {
  static const navy       = Color(0xFF1B3A6B);
  static const blue       = Color(0xFF2E9CD4);
  static const orange     = Color(0xFFE8761A);
  static const orangeLight= Color(0xFFF5A623);
  static const bg         = Color(0xFFEBF4FB);
  static const white      = Color(0xFFFFFFFF);
  static const textMuted  = Color(0xFF6B8CAE);
  static const cardBorder = Color(0x262E9CD4);
  static const heroOverlay= Color(0x1F2E9CD4);
}

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

  String getCourseImage(String name) {
    switch (name) {
      case 'English 101':
        return 'assets/images/english.png';
      case 'Dynamic 101':
        return 'assets/images/math.jpg';
      case 'Flutter Development':
        return 'assets/images/programming.png';
      default:
        return 'assets/images/default.png';
    }
  }

  // Returns a gradient color pair per course for the card header
  List<Color> _courseGradient(String name) {
    switch (name) {
      case 'English 101':
        return [_EduExColors.navy, _EduExColors.blue];
      case 'Dynamic 101':
        return [_EduExColors.orange, _EduExColors.orangeLight];
      case 'Flutter Development':
        return [const Color(0xFF1D9E75), const Color(0xFF5DCAA5)];
      default:
        return [_EduExColors.navy, _EduExColors.blue];
    }
  }

  String _courseTag(String name) {
    switch (name) {
      case 'English 101':       return 'Language';
      case 'Dynamic 101':       return 'Mathematics';
      case 'Flutter Development': return 'Programming';
      default:                  return 'Course';
    }
  }

  String _courseEmoji(String name) {
    switch (name) {
      case 'English 101':         return '📖';
      case 'Dynamic 101':         return '📐';
      case 'Flutter Development': return '💻';
      default:                    return '🎓';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _EduExColors.bg,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) return _buildLoading();
          if (viewModel.errorMessage != null) return _buildError(viewModel.errorMessage!);
          if (viewModel.courses.isEmpty) return _buildEmpty();

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                children: [
                  _buildNavBar(),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        _HeroSection(),
                        const SizedBox(height: 48),
                        _buildSectionHeader(),
                        const SizedBox(height: 24),
                        ...viewModel.courses.map((course) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _CourseCard(
                            title: course.name,
                            description: course.description,
                            image: getCourseImage(course.name),
                            tag: _courseTag(course.name),
                            emoji: _courseEmoji(course.name),
                            gradientColors: _courseGradient(course.name),
                            onViewMore: () => Navigator.pushNamed(
                              context,
                              Routes.classScreen,
                              arguments: {
                                'courseId': course.id,
                                'courseName': course.name,
                                'course': course,
                              },
                            ),
                          ),
                        )),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Nav Bar ───────────────────────────────────────────────────────────────
  Widget _buildNavBar() {
    return Container(
      height: 64,
      color: _EduExColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Logo
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_EduExColors.blue, _EduExColors.navy],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text('Ex',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
          ),
          const SizedBox(width: 10),
          RichText(text: const TextSpan(
            style: TextStyle(fontFamily: 'serif', fontSize: 22, fontWeight: FontWeight.w700),
            children: [
              TextSpan(text: 'Edu', style: TextStyle(color: _EduExColors.navy)),
              TextSpan(text: 'Ex', style: TextStyle(color: _EduExColors.blue)),
            ],
          )),
          const Spacer(),
          // Nav links
          for (final label in ['Home', 'Courses', 'My Learning', 'Community'])
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(label,
                  style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500,
                    color: label == 'Home' ? _EduExColors.navy : _EduExColors.textMuted,
                  )),
            ),
          const Spacer(),
          // Buttons
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _EduExColors.cardBorder),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text('Sign In',
                style: TextStyle(color: _EduExColors.navy, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _EduExColors.orange,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text('Get Started',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── Section header ────────────────────────────────────────────────────────
  Widget _buildSectionHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available Courses',
                style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w700,
                  color: _EduExColors.navy,
                )),
            SizedBox(height: 4),
            Text('Browse all courses and start learning today',
                style: TextStyle(fontSize: 14, color: _EduExColors.textMuted)),
          ],
        ),
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Text('View all',
              style: TextStyle(color: _EduExColors.orange, fontSize: 14, fontWeight: FontWeight.w600)),
          label: const Icon(Icons.arrow_forward, color: _EduExColors.orange, size: 16),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0x40E8761A)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ],
    );
  }

  // ── States ────────────────────────────────────────────────────────────────
  Widget _buildLoading() => const Center(
    child: CircularProgressIndicator(color: _EduExColors.blue),
  );

  Widget _buildError(String msg) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline, color: _EduExColors.orange, size: 48),
      const SizedBox(height: 12),
      Text(msg, style: const TextStyle(color: _EduExColors.navy)),
    ]),
  );

  Widget _buildEmpty() => const Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.school_outlined, color: _EduExColors.textMuted, size: 48),
      SizedBox(height: 12),
      Text('No courses available.', style: TextStyle(color: _EduExColors.textMuted)),
    ]),
  );
}

// ── Hero Section ─────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B3A6B), Color(0xFF1A4D8F), Color(0xFF1E5FA8)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative circles
          Positioned(right: -60, top: -60,
              child: Container(width: 320, height: 320,
                  decoration: const BoxDecoration(
                      color: Color(0x1FE8761A), shape: BoxShape.circle))),
          Positioned(right: 120, bottom: -80,
              child: Container(width: 200, height: 200,
                  decoration: const BoxDecoration(
                      color: Color(0x192E9CD4), shape: BoxShape.circle))),
          // Content
          Padding(
            padding: const EdgeInsets.all(56),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _heroLeft()),
                const SizedBox(width: 48),
                Expanded(child: _heroRight()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroLeft() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Badge
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0x2EE8761A),
          border: Border.all(color: const Color(0x59E8761A)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.bolt, color: Color(0xFFF5A623), size: 14),
          SizedBox(width: 6),
          Text('Education Express Platform',
              style: TextStyle(
                color: Color(0xFFF5A623), fontSize: 12,
                fontWeight: FontWeight.w600, letterSpacing: 0.5,
              )),
        ]),
      ),
      const SizedBox(height: 20),
      // Headline
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, height: 1.2),
          children: [
            TextSpan(text: 'Learn Faster,\nGrow ', style: TextStyle(color: Colors.white)),
            TextSpan(text: 'Further', style: TextStyle(color: Color(0xFFF5A623))),
          ],
        ),
      ),
      const SizedBox(height: 18),
      const Text(
        'Access world-class courses in English, Mathematics, Programming, and more — '
            'designed to accelerate your career at every stage.',
        style: TextStyle(color: Color(0xB8FFFFFF), fontSize: 16, height: 1.7),
      ),
      const SizedBox(height: 32),
      // CTA buttons
      Row(children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow_rounded, size: 18),
          label: const Text('Explore Courses'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE8761A),
            foregroundColor: Colors.white,
            elevation: 0,
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0x40FFFFFF)),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('How it works',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      ]),
      const SizedBox(height: 40),
      // Stats row
      const Divider(color: Color(0x1FFFFFFF), height: 1),
      const SizedBox(height: 32),
      Row(children: const [
        _StatItem(number: '12K+', label: 'Active students'),
        SizedBox(width: 32),
        _StatItem(number: '48', label: 'Expert courses'),
        SizedBox(width: 32),
        _StatItem(number: '96%', label: 'Completion rate'),
      ]),
    ],
  );

  Widget _heroRight() => Column(
    children: [
      _MiniProgressCard(
        icon: Icons.menu_book_rounded,
        iconColor: const Color(0xFF2E9CD4),
        iconBg: const Color(0x402E9CD4),
        title: 'English 101',
        subtitle: 'Lesson 4 of 12 · Grammar Foundations',
        progress: 0.33,
      ),
      const SizedBox(height: 14),
      _MiniProgressCard(
        icon: Icons.calculate_rounded,
        iconColor: const Color(0xFFF5A623),
        iconBg: const Color(0x40F5A623),
        title: 'Dynamic 101',
        subtitle: 'Lesson 7 of 10 · Advanced Dynamics',
        progress: 0.70,
      ),
      const SizedBox(height: 14),
      _MiniProgressCard(
        icon: Icons.code_rounded,
        iconColor: const Color(0xFF1D9E75),
        iconBg: const Color(0x401D9E75),
        title: 'Flutter Development',
        subtitle: 'Lesson 2 of 15 · Widgets & State',
        progress: 0.13,
      ),
    ],
  );
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(number,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white)),
      const SizedBox(height: 2),
      Text(label,
          style: const TextStyle(fontSize: 12, color: Color(0x8CFFFFFF))),
    ],
  );
}

class _MiniProgressCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final double progress;

  const _MiniProgressCard({
    required this.icon, required this.iconColor, required this.iconBg,
    required this.title, required this.subtitle, required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        border: Border.all(color: const Color(0x26FFFFFF)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(subtitle,
                style: const TextStyle(color: Color(0x8CFFFFFF), fontSize: 12)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: const Color(0x26FFFFFF),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2E9CD4)),
              ),
            ),
          ],
        )),
      ]),
    );
  }
}

// ── Course Card ───────────────────────────────────────────────────────────────
class _CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String tag;
  final String emoji;
  final List<Color> gradientColors;
  final VoidCallback onViewMore;

  const _CourseCard({
    required this.title, required this.description, required this.image,
    required this.tag, required this.emoji, required this.gradientColors,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _EduExColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _EduExColors.cardBorder),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Image / gradient header
        SizedBox(
          height: 180,
          child: Stack(fit: StackFit.expand, children: [
            // Try loading actual image, fall back to gradient
            Image.asset(image, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(emoji, style: const TextStyle(fontSize: 52)),
              ),
            ),
          ]),
        ),
        // Body
        Padding(
          padding: const EdgeInsets.all(22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0x192E9CD4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(tag.toUpperCase(),
                  style: const TextStyle(
                    color: _EduExColors.blue, fontSize: 11,
                    fontWeight: FontWeight.w600, letterSpacing: 0.5,
                  )),
            ),
            const SizedBox(height: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: _EduExColors.navy)),
            const SizedBox(height: 8),
            Text(description,
                maxLines: 2, overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13, color: _EduExColors.textMuted, height: 1.6)),
            const SizedBox(height: 18),
            const Divider(color: Color(0x192E9CD4), height: 1),
            const SizedBox(height: 16),
            // Footer
            Row(children: [
              const Icon(Icons.access_time_rounded, size: 14, color: _EduExColors.textMuted),
              const SizedBox(width: 4),
              const Text('12 lessons',
                  style: TextStyle(fontSize: 12, color: _EduExColors.textMuted)),
              const SizedBox(width: 14),
              const Icon(Icons.star_rounded, size: 14, color: _EduExColors.textMuted),
              const SizedBox(width: 4),
              const Text('4.8',
                  style: TextStyle(fontSize: 12, color: _EduExColors.textMuted)),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: onViewMore,
                icon: const Text('View'),
                label: const Icon(Icons.arrow_forward, size: 14),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _EduExColors.navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}