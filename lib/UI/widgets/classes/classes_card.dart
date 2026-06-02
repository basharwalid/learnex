import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnex/UI/seat_reservation/seat_reserve_view.dart';
import 'package:learnex/core/theme/MyTheme.dart';
import 'package:learnex/domain/model/class.dart';
import 'package:learnex/domain/model/course.dart';

class ClassCard extends StatelessWidget {
  final Class session;
  final Course course; // ← add this
  final VoidCallback onPaymentSuccess;

  const ClassCard({
    super.key,
    required this.session,
    required this.course, // ← add this
    required this.onPaymentSuccess,
  });

  void _navigate(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReserveScreen(
          session: session,
          course: course, // ← add this
          onPaymentSuccess: onPaymentSuccess,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final available = session.availableSeats ?? 0;
    final total = (session.totalSeats ?? 1).clamp(1, 99999);
    final fillRatio = available / total;
    final isSoldOut = available == 0;
    final isLow = available > 0 && available <= 3;

    final dateStr = session.classDate != null
        ? DateFormat('EEE, MMM d').format(session.classDate!)
        : 'TBC';
    final timeStr = session.classDate != null
        ? DateFormat('h:mm a').format(session.classDate!)
        : session.classTime ?? 'TBC';

    // Seat fill color: red if sold out, orange if low, blue otherwise
    final Color fillColor = isSoldOut
        ? const Color(0xFFD32F2F)
        : isLow
        ? MyTheme.orange
        : MyTheme.blue;

    return GestureDetector(
      onTap: isSoldOut ? null : () => _navigate(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: MyTheme.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: MyTheme.cardBorder),
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: const Color(0xFF1B3A6B).withOpacity(0.07),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Top accent stripe ──────────────────────────────────────────
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSoldOut
                      ? [Colors.grey.shade300, Colors.grey.shade400]
                      : [MyTheme.navy, MyTheme.blue],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Date + time row ───────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: MyTheme.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.calendar_today_rounded,
                          size: 15,
                          color: MyTheme.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateStr,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: MyTheme.navy,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 1),
                            Text(
                              timeStr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: MyTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status badge
                      _StatusBadge(isSoldOut: isSoldOut, isLow: isLow),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(color: MyTheme.cardBorder, height: 1),
                  const SizedBox(height: 10),

                  // ── Seats row + progress ──────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event_seat_rounded,
                            size: 13,
                            color: isSoldOut ? Colors.grey : fillColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$available / $total seats',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSoldOut ? Colors.grey : MyTheme.navy,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${(fillRatio * 100).round()}% filled',
                        style: TextStyle(
                          fontSize: 11,
                          color: MyTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: fillRatio,
                      minHeight: 5,
                      backgroundColor: MyTheme.bg,
                      valueColor: AlwaysStoppedAnimation(fillColor),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Price + Reserve button ────────────────────────────────
                  Row(
                    children: [
                      // Price tag
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 10,
                              color: MyTheme.textMuted,
                            ),
                          ),
                          Text(
                            session.price != null
                                ? 'EGP ${session.price}'
                                : 'Free',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: MyTheme.navy,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Reserve button
                      SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          onPressed: isSoldOut
                              ? null
                              : () => _navigate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.orange,
                            disabledBackgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(isSoldOut ? 'Sold Out' : 'Reserve'),
                              if (!isSoldOut) ...[
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 11,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final bool isSoldOut, isLow;

  const _StatusBadge({required this.isSoldOut, required this.isLow});

  @override
  Widget build(BuildContext context) {
    if (isSoldOut) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Sold Out',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFFD32F2F),
          ),
        ),
      );
    }
    if (isLow) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: MyTheme.orangeLight.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '${_StatusBadge._seatsText}',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: MyTheme.orange,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: MyTheme.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'Available',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: MyTheme.blue,
        ),
      ),
    );
  }

  static const _seatsText = 'Few left';
}
