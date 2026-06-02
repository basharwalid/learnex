import 'package:flutter/material.dart';
import 'package:learnex/UI/classes_screen/classes_view_model.dart';
import 'package:learnex/UI/widgets/classes/classes_card.dart';
import 'package:learnex/core/di/di.dart';
import 'package:learnex/domain/model/course.dart';

// ── Brand tokens (shared across all screens) ──────────────────────────────────
class _EduExColors {
  static const navy        = Color(0xFF1B3A6B);
  static const blue        = Color(0xFF2E9CD4);
  static const orange      = Color(0xFFE8761A);
  static const orangeLight = Color(0xFFF5A623);
  static const bg          = Color(0xFFEBF4FB);
  static const white       = Color(0xFFFFFFFF);
  static const textMuted   = Color(0xFF6B8CAE);
  static const cardBorder  = Color(0x262E9CD4);
}

// ─────────────────────────────────────────────────────────────────────────────
// ClassesView
// ─────────────────────────────────────────────────────────────────────────────
class ClassesView extends StatefulWidget {
  static const String routeName = '/classes';

  final int courseId;
  final String courseName;
  final Course course;
  const ClassesView({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.course,
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
      backgroundColor: _EduExColors.bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNavBar(),
          _buildPageHeader(),
          Expanded(
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) => _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top nav (same pattern as all other screens) ───────────────────────────
  Widget _buildNavBar() {
    return Container(
      height: 64,
      color: _EduExColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(children: [
        // Back button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: _EduExColors.bg,
              border: Border.all(color: _EduExColors.cardBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 15, color: _EduExColors.navy),
          ),
        ),
        const SizedBox(width: 16),
        // Logo
        RichText(text: const TextSpan(
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          children: [
            TextSpan(text: 'Edu', style: TextStyle(color: _EduExColors.navy)),
            TextSpan(text: 'Ex', style: TextStyle(color: _EduExColors.blue)),
          ],
        )),
        const Spacer(),
        // Course breadcrumb pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _EduExColors.bg,
            border: Border.all(color: _EduExColors.cardBorder),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.school_rounded, size: 13, color: _EduExColors.blue),
            const SizedBox(width: 6),
            Text(widget.courseName,
                style: const TextStyle(
                    fontSize: 12, color: _EduExColors.navy,
                    fontWeight: FontWeight.w600)),
          ]),
        ),
      ]),
    );
  }

  // ── Page header — navy gradient banner matching other screens ─────────────
  Widget _buildPageHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B3A6B), Color(0xFF1A4D8F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(children: [
        // Icon badge
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.class_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${widget.courseName} Classes',
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 3),
            const Text('Select a session to reserve your seat',
                style: TextStyle(fontSize: 13, color: Colors.white70)),
          ]),
        ),
        const SizedBox(width: 16),
        // Orange pill accent
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _EduExColors.orange.withOpacity(0.2),
            border: Border.all(color: _EduExColors.orange.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (_, __) => Text(
              '${viewModel.classes.length} sessions',
              style: const TextStyle(
                  fontSize: 12, color: _EduExColors.orangeLight,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }

  // ── Body — loading / error / empty / grid ─────────────────────────────────
  Widget _buildBody() {
    if (viewModel.isLoading) return _buildLoading();
    if (viewModel.errorMessage != null) return _buildError(viewModel.errorMessage!);
    if (viewModel.classes.isEmpty) return _buildEmpty();

    return Padding(
      padding: const EdgeInsets.all(28),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.4,
        ),
        itemCount: viewModel.classes.length,
        itemBuilder: (context, index) => ClassCard(
          session: viewModel.classes[index],
          course: widget.course,         // ← add this
          onPaymentSuccess: () => viewModel.loadClasses(widget.courseId),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
    child: CircularProgressIndicator(color: _EduExColors.blue),
  );

  Widget _buildError(String message) => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 64, height: 64,
        decoration: BoxDecoration(
          color: _EduExColors.orange.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.error_outline_rounded,
            color: _EduExColors.orange, size: 30),
      ),
      const SizedBox(height: 16),
      Text(message,
          style: const TextStyle(
              fontSize: 15, color: _EduExColors.navy, fontWeight: FontWeight.w500)),
      const SizedBox(height: 12),
      OutlinedButton.icon(
        onPressed: () => viewModel.loadClasses(widget.courseId),
        icon: const Icon(Icons.refresh_rounded, size: 16, color: _EduExColors.blue),
        label: const Text('Try again',
            style: TextStyle(color: _EduExColors.blue, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _EduExColors.cardBorder),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ]),
  );

  Widget _buildEmpty() => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 72, height: 72,
        decoration: BoxDecoration(
          color: _EduExColors.blue.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.calendar_today_outlined,
            color: _EduExColors.blue, size: 32),
      ),
      const SizedBox(height: 16),
      const Text('No classes available yet',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: _EduExColors.navy)),
      const SizedBox(height: 6),
      const Text('Check back soon for new sessions',
          style: TextStyle(fontSize: 13, color: _EduExColors.textMuted)),
    ]),
  );
}