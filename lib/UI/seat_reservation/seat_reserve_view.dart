import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnex/UI/payment/payment_view.dart';
import 'package:learnex/UI/payment/payment_view_model.dart';
import 'package:learnex/UI/payment/payment_web_view.dart';
import 'package:learnex/UI/seat_reservation/seat_reserve_view_model.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:learnex/core/di/di.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const error       = Color(0xFFD32F2F);
}

// ─────────────────────────────────────────────────────────────────────────────
// ReserveScreen
// ─────────────────────────────────────────────────────────────────────────────
class ReserveScreen extends StatefulWidget {
  final Class session;
  final VoidCallback onPaymentSuccess;
  final Course course;
  const ReserveScreen({
    super.key,
    required this.session,
    required this.onPaymentSuccess,
    required this.course,
  });

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen>
    with SingleTickerProviderStateMixin {
  final seatReservationViewModel = getIt<SeatReservationViewModel>();
  final paymentViewModel = getIt<PaymentViewModel>();

  late final AnimationController _animController;
  late final Animation<double>  _fadeAnim;
  late final Animation<Offset>  _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnim  = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    seatReservationViewModel.nameController.dispose();
    seatReservationViewModel.phoneController.dispose();
    seatReservationViewModel.emailController.dispose();
    super.dispose();
  }

  String get _formattedDate => widget.session.classDate != null
      ? DateFormat('EEE, d MMM yyyy').format(widget.session.classDate!)
      : 'N/A';

  String get _formattedTime => widget.session.classDate != null
      ? DateFormat('h:mm a').format(widget.session.classDate!)
      : widget.session.classTime ?? 'N/A';

  Future<void> _submit() async {
    final isValid = seatReservationViewModel.formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // Step 1: Reserve seat
    final orderId = await seatReservationViewModel.reserveSeat(widget.session.id ?? 0);
    if (!mounted) return;

    if (orderId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            seatReservationViewModel.errorMessage ?? 'Reservation failed. Please try again.',
          ),
          backgroundColor: _EduExColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Step 2: Create payment intention
    final intention = await paymentViewModel.createPaymentIntention(
      amount: widget.session.price! * 100 ?? 0,
      selectedCourse: widget.course,
      orderId: orderId,
      firstName: seatReservationViewModel.firstName,
      lastName: seatReservationViewModel.lastName,
      email: seatReservationViewModel.emailController.text,
      phone: seatReservationViewModel.phoneController.text,
      paymentMethods: [5700003],
    );
    if (!mounted) return;

    if (intention == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            paymentViewModel.errorMessage ?? 'Payment setup failed. Please try again.',
          ),
          backgroundColor: _EduExColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Step 3: Open Paymob WebView
    final url = Uri.parse(
      'https://accept.paymob.com/unifiedcheckout/?publicKey=${ApiConstants.paymobPublicKey}&clientSecret=${intention.clientSecret}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open payment page')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _EduExColors.bg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  children: [
                    _buildNavBar(),
                    const SizedBox(height: 28),
                    Form(
                      key: seatReservationViewModel.formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _EduExColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _EduExColors.cardBorder),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 32,
                              color: const Color(0xFF1B3A6B).withOpacity(0.08),
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ListenableBuilder(
                          listenable: seatReservationViewModel,
                          builder: (context, _) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildHeader(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _MetaGrid(
                                      date: _formattedDate,
                                      time: _formattedTime,
                                      classTime: widget.session.classTime ?? 'N/A',
                                      seatsLeft: widget.session.availableSeats ?? 0,
                                    ),
                                    const SizedBox(height: 28),
                                    _Divider(),
                                    const SizedBox(height: 24),
                                    _SectionLabel(text: 'Your information'),
                                    const SizedBox(height: 14),
                                    _InputField(
                                      controller: seatReservationViewModel.nameController,
                                      label: 'Full name',
                                      hint: 'Enter your full name',
                                      icon: Icons.person_outline_rounded,
                                      textInputAction: TextInputAction.next,
                                      validator: (v) => v == null || v.trim().isEmpty
                                          ? 'Required' : null,
                                    ),
                                    const SizedBox(height: 14),
                                    _InputField(
                                      controller: seatReservationViewModel.emailController,
                                      label: 'Email address',
                                      hint: 'your@email.com',
                                      icon: Icons.mail_outline_rounded,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      validator: (v) {
                                        if (v == null || v.trim().isEmpty) return 'Required';
                                        if (!v.contains('@')) return 'Enter a valid email';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 14),
                                    _InputField(
                                      controller: seatReservationViewModel.phoneController,
                                      label: 'Phone number',
                                      hint: '+20 1xx xxx xxxx',
                                      icon: Icons.phone_outlined,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      validator: (v) => v == null || v.trim().isEmpty
                                          ? 'Required' : null,
                                    ),
                                    const SizedBox(height: 28),
                                    _Divider(),
                                    const SizedBox(height: 24),
                                    _SectionLabel(text: 'Payment summary'),
                                    const SizedBox(height: 14),
                                    _PriceSummary(price: widget.session.price ?? 0),
                                    const SizedBox(height: 24),
                                    _SubmitButton(
                                      priceLabel: 'EGP ${widget.session.price ?? 0}',
                                      isLoading: seatReservationViewModel.isLoading,
                                      onTap: _submit,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Top nav bar (same pattern as PaymentScreen) ───────────────────────────
  Widget _buildNavBar() {
    return Row(children: [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: _EduExColors.white,
            border: Border.all(color: _EduExColors.cardBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 15, color: _EduExColors.navy),
        ),
      ),
      const SizedBox(width: 14),
      RichText(text: const TextSpan(
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        children: [
          TextSpan(text: 'Edu', style: TextStyle(color: _EduExColors.navy)),
          TextSpan(text: 'Ex', style: TextStyle(color: _EduExColors.blue)),
        ],
      )),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _EduExColors.white,
          border: Border.all(color: _EduExColors.cardBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: const [
          Icon(Icons.event_seat_rounded, size: 13, color: _EduExColors.textMuted),
          SizedBox(width: 5),
          Text('Seat Reservation',
              style: TextStyle(fontSize: 12, color: _EduExColors.textMuted,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    ]);
  }

  // ── Card header — navy gradient (same as PaymentScreen) ──────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B3A6B), Color(0xFF1A4D8F)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.event_seat_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.session.status ?? 'Reserve a Seat',
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              const Text('Complete your booking below',
                  style: TextStyle(fontSize: 12, color: Colors.white70)),
            ]),
          ),
          const SizedBox(width: 12),
          // Orange pill accent
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _EduExColors.orange.withOpacity(0.2),
              border: Border.all(color: _EduExColors.orange.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Reserve',
                style: TextStyle(fontSize: 11, color: _EduExColors.orangeLight,
                    fontWeight: FontWeight.w600)),
          ),
        ]),
        const SizedBox(height: 20),
        // Step indicator
        Row(children: [
          _StepDot(number: '1', label: 'Details', active: true),
          _StepLine(),
          _StepDot(number: '2', label: 'Payment', active: false),
          _StepLine(),
          _StepDot(number: '3', label: 'Confirm', active: false),
        ]),
        const SizedBox(height: 20),
      ]),
    );
  }
}

// ── Step indicator widgets ────────────────────────────────────────────────────
class _StepDot extends StatelessWidget {
  final String number, label;
  final bool active;
  const _StepDot({required this.number, required this.label, required this.active});

  @override
  Widget build(BuildContext context) => Column(children: [
    Container(
      width: 28, height: 28,
      decoration: BoxDecoration(
        color: active ? _EduExColors.orange : Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? _EduExColors.orangeLight : Colors.white.withOpacity(0.3),
        ),
      ),
      alignment: Alignment.center,
      child: Text(number,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700,
              color: active ? Colors.white : Colors.white60)),
    ),
    const SizedBox(height: 4),
    Text(label,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w500,
            color: active ? Colors.white : Colors.white54)),
  ]);
}

class _StepLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 1,
      margin: const EdgeInsets.only(bottom: 18),
      color: Colors.white.withOpacity(0.2),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Meta Grid — date / time / seats
// ─────────────────────────────────────────────────────────────────────────────
class _MetaGrid extends StatelessWidget {
  final String date, time, classTime;
  final int seatsLeft;

  const _MetaGrid({
    required this.date, required this.time,
    required this.classTime, required this.seatsLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(children: [
        Expanded(child: _MetaTile(
            icon: Icons.calendar_today_outlined,
            label: 'Date', value: date)),
        const SizedBox(width: 12),
        Expanded(child: _MetaTile(
            icon: Icons.access_time_rounded,
            label: 'Time', value: time)),
        const SizedBox(width: 12),
        Expanded(child: _MetaTile(
            icon: Icons.event_seat_rounded,
            label: 'Seats left',
            value: '$seatsLeft',
            valueColor: seatsLeft <= 3 ? _EduExColors.orange : _EduExColors.navy)),
      ]),
    );
  }
}

class _MetaTile extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color? valueColor;
  const _MetaTile({required this.icon, required this.label,
    required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _EduExColors.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _EduExColors.cardBorder),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
            color: _EduExColors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 15, color: _EduExColors.blue),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 11, color: _EduExColors.textMuted)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: valueColor ?? _EduExColors.navy),
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared small widgets
// ─────────────────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Divider(color: _EduExColors.cardBorder, height: 1);
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 11, letterSpacing: 1.1,
      fontWeight: FontWeight.w600, color: _EduExColors.textMuted,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Input Field
// ─────────────────────────────────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller, required this.label,
    required this.hint, required this.icon,
    this.keyboardType, this.textInputAction, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: _EduExColors.navy)),
      const SizedBox(height: 7),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        style: const TextStyle(fontSize: 14, color: _EduExColors.navy),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: _EduExColors.textMuted),
          prefixIcon: Container(
            margin: const EdgeInsets.all(10),
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: _EduExColors.blue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: _EduExColors.blue),
          ),
          filled: true,
          fillColor: _EduExColors.bg,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _EduExColors.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _EduExColors.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _EduExColors.blue, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _EduExColors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _EduExColors.error, width: 1.5),
          ),
        ),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Price Summary
// ─────────────────────────────────────────────────────────────────────────────
class _PriceSummary extends StatelessWidget {
  final int price;
  const _PriceSummary({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _EduExColors.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _EduExColors.cardBorder),
      ),
      child: Column(children: [
        _PriceRow(label: 'Session fee', value: 'EGP $price'),
        const SizedBox(height: 10),
        _PriceRow(label: 'Platform fee', value: 'EGP 0'),
        const SizedBox(height: 14),
        Divider(color: _EduExColors.cardBorder, height: 1),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total due',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700, color: _EduExColors.navy)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_EduExColors.orange, _EduExColors.orangeLight],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('EGP $price',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ],
        ),
      ]),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label, value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 13, color: _EduExColors.textMuted)),
      Text(value,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: _EduExColors.navy)),
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Submit Button
// ─────────────────────────────────────────────────────────────────────────────
class _SubmitButton extends StatelessWidget {
  final String priceLabel;
  final bool isLoading;
  final VoidCallback onTap;

  const _SubmitButton({
    required this.priceLabel, required this.isLoading, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _EduExColors.orange,
          disabledBackgroundColor: _EduExColors.orange.withOpacity(0.55),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: isLoading
            ? const SizedBox(width: 22, height: 22,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.lock_outline_rounded, size: 16),
          const SizedBox(width: 10),
          Text('Proceed to Payment · $priceLabel',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14),
        ]),
      ),
    );
  }
}