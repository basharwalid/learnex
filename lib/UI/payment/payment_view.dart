import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnex/UI/seat_reservation/seat_reserve_view_model.dart';
import 'package:learnex/core/theme/MyTheme.dart';
import 'package:learnex/domain/model/class.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment';

  final Class session;
  final String orderId;
  final String studentName;
  final String studentEmail;
  final VoidCallback? onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.session,
    required this.orderId,
    required this.studentName,
    required this.studentEmail,
    this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedMethod;
  bool _isProcessing = false;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  String get _formattedDate => widget.session.classDate != null
      ? DateFormat('EEE, d MMM yyyy · h:mm a').format(widget.session.classDate!)
      : widget.session.classTime ?? 'N/A';

  // Future<void> _pay(String method) async {
  //   setState(() {
  //     _selectedMethod = method;
  //     _isProcessing = true;
  //   });
  //
  //   final viewModel = context.read<SeatReservationViewModel>();
  //
  //   final intention = await viewModel.createPaymentIntention(
  //     selectedClass: widget.session,
  //     selectedCourse: widget.session,
  //     paymentMethods: [158],
  //   );
  //
  //   if (!mounted) return;
  //
  //   if (intention == null) {
  //     setState(() => _isProcessing = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(viewModel.errorMessage ?? 'Payment failed')),
  //     );
  //     return;
  //   }
  //
  //   // Open Paymob payment sheet with client_secret
  //   final result = await PaymobPay.pay(
  //     context: context,
  //     clientSecret: intention.clientSecret,
  //   );
  //
  //   if (!mounted) return;
  //   setState(() => _isProcessing = false);
  //
  //   if (result == PaymobPayResult.success) {
  //     widget.onPaymentSuccess?.call();
  //     _showSuccessDialog();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Payment was not completed')),
  //     );
  //   }
  // }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialog(
        session: widget.session,
        orderId: widget.orderId,
        paymentMethod: _selectedMethod ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  children: [
                    _buildNavBar(),
                    const SizedBox(height: 28),
                    // _buildCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Minimal top nav (consistent with HomeScreen) ──────────────────────────
  Widget _buildNavBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: MyTheme.white,
              border: Border.all(color: MyTheme.cardBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: MyTheme.navy,
            ),
          ),
        ),
        const SizedBox(width: 14),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: 'Edu',
                style: TextStyle(color: MyTheme.navy),
              ),
              TextSpan(
                text: 'Ex',
                style: TextStyle(color: MyTheme.blue),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: MyTheme.white,
            border: Border.all(color: MyTheme.cardBorder),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.lock_outline_rounded,
                size: 13,
                color: MyTheme.textMuted,
              ),
              SizedBox(width: 5),
              Text(
                'Secure Checkout',
                style: TextStyle(
                  fontSize: 12,
                  color: MyTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Main card ─────────────────────────────────────────────────────────────
  // Widget _buildCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: MyTheme.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: MyTheme.cardBorder),
  //       boxShadow: [
  //         BoxShadow(
  //           blurRadius: 32,
  //           color: const Color(0xFF1B3A6B).withOpacity(0.08),
  //           offset: const Offset(0, 8),
  //         ),
  //       ],
  //     ),
  //     clipBehavior: Clip.hardEdge,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         _buildHeader(),
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               _OrderSummary(
  //                 orderId: widget.orderId,
  //                 date: _formattedDate,
  //                 name: widget.studentName,
  //                 email: widget.studentEmail,
  //                 price: widget.session.price ?? 0,
  //               ),
  //               const SizedBox(height: 28),
  //               Divider(color: MyTheme.cardBorder, height: 1),
  //               const SizedBox(height: 24),
  //               _sectionLabel('Choose payment method'),
  //               const SizedBox(height: 14),
  //               _PaymentButton(
  //                 label: 'Pay with Vodafone Cash',
  //                 icon: Icons.phone_android_rounded,
  //                 color: MyTheme.vodafone,
  //                 isLoading:
  //                     _isProcessing && _selectedMethod == 'Vodafone Cash',
  //                 onTap: _isProcessing ? null : () => _pay('Vodafone Cash'),
  //               ),
  //               const SizedBox(height: 12),
  //               _PaymentButton(
  //                 label: 'Pay with Instapay',
  //                 icon: Icons.bolt_rounded,
  //                 color: MyTheme.instaPay,
  //                 isLoading: _isProcessing && _selectedMethod == 'Instapay',
  //                 onTap: _isProcessing ? null : () => _pay('Instapay'),
  //               ),
  //               const SizedBox(height: 12),
  //               _PaymentButton(
  //                 label: 'Bank Transfer',
  //                 icon: Icons.account_balance_rounded,
  //                 color: MyTheme.bank,
  //                 isLoading:
  //                     _isProcessing && _selectedMethod == 'Bank Transfer',
  //                 onTap: _isProcessing ? null : () => _pay('Bank Transfer'),
  //               ),
  //               const SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: const [
  //                   Icon(
  //                     Icons.lock_outline_rounded,
  //                     size: 13,
  //                     color: MyTheme.textMuted,
  //                   ),
  //                   SizedBox(width: 5),
  //                   Text(
  //                     'Payments are secure and encrypted',
  //                     style: TextStyle(fontSize: 12, color: MyTheme.textMuted),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // ── Card header — navy gradient matching HomeScreen hero ──────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B3A6B), Color(0xFF1A4D8F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          // Icon badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.payment_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete Payment',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Choose how you\'d like to pay',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          // Orange accent pill — matches HomeScreen CTA color
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: MyTheme.orange.withOpacity(0.2),
              border: Border.all(color: MyTheme.orange.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'EduEx Pay',
              style: TextStyle(
                fontSize: 11,
                color: MyTheme.orangeLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
    text.toUpperCase(),
    style: const TextStyle(
      fontSize: 11,
      letterSpacing: 1.1,
      fontWeight: FontWeight.w600,
      color: MyTheme.textMuted,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Order Summary
// ─────────────────────────────────────────────────────────────────────────────
class _OrderSummary extends StatelessWidget {
  final String orderId, date, name, email;
  final int price;

  const _OrderSummary({
    required this.orderId,
    required this.date,
    required this.name,
    required this.email,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: MyTheme.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MyTheme.cardBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order ID',
                    style: TextStyle(fontSize: 11, color: MyTheme.textMuted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: MyTheme.navy,
                    ),
                  ),
                ],
              ),
              // Price badge — orange accent like HomeScreen CTA
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [MyTheme.orange, MyTheme.orangeLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'EGP $price',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: MyTheme.cardBorder, height: 1),
          const SizedBox(height: 14),
          _SummaryRow(
            icon: Icons.calendar_today_outlined,
            label: 'Class',
            value: date,
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            icon: Icons.person_outline_rounded,
            label: 'Student',
            value: name,
          ),
          const SizedBox(height: 8),
          _SummaryRow(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: email,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label, value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: MyTheme.blue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: MyTheme.blue),
        ),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 13, color: MyTheme.textMuted),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: MyTheme.navy,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Payment Button
// ─────────────────────────────────────────────────────────────────────────────
class _PaymentButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isLoading;
  final VoidCallback? onTap;

  const _PaymentButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: color.withOpacity(0.55),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                ],
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Success Dialog
// ─────────────────────────────────────────────────────────────────────────────
class _SuccessDialog extends StatelessWidget {
  final Class session;
  final String orderId;
  final String paymentMethod;

  const _SuccessDialog({
    required this.session,
    required this.orderId,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Container(
          decoration: BoxDecoration(
            color: MyTheme.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyTheme.cardBorder),
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: const Color(0xFF1B3A6B).withOpacity(0.12),
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header — navy gradient consistent with payment card header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B3A6B), Color(0xFF1A4D8F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Animated check circle
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: MyTheme.orange.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyTheme.orangeLight.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: MyTheme.orangeLight,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Payment Successful!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your seat is confirmed',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                child: Column(
                  children: [
                    _DetailRow(
                      icon: Icons.confirmation_number_outlined,
                      label: 'Order ID',
                      value: orderId,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.payment_rounded,
                      label: 'Paid via',
                      value: paymentMethod,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.mail_outline_rounded,
                      label: 'Receipt',
                      value: 'Sent to your email',
                    ),
                    const SizedBox(height: 22),
                    Divider(color: MyTheme.cardBorder, height: 1),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Back to classes',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label, value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: MyTheme.blue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: MyTheme.blue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: MyTheme.textMuted),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.navy,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
