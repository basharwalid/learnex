import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnex/domain/model/class.dart';

class ClassCard extends StatelessWidget {
  final Class session;

  const ClassCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final percent = (session.availableSeats ?? 0) / (session.totalSeats ?? 1);
    final formattedDate = session.classDate != null
        ? DateFormat('EEE, MMM d · hh:mm a').format(session.classDate!)
        : 'No date available';

    Text("Duration: ${session.classTime ?? 'N/A'}");
    Text("Price: ${session.price ?? 0} EGP");
    Text("Available seats: ${session.availableSeats ?? 0} / ${session.totalSeats ?? 0}");

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(.08),
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate, // ✅ was hardcoded "session.date"
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Available seats: ${session.availableSeats ?? 0} / ${session.totalSeats ?? 0}",
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey[300],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                /// Reserve seat API
              },
              child: const Text("Reserve Seat",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}