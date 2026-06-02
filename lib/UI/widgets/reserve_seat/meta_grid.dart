import 'package:flutter/material.dart';
import 'package:learnex/UI/widgets/reserve_seat/meta_tile.dart';

class MetaGrid extends StatelessWidget {
  final String date, time, classTime;
  final int seatsLeft;

  const MetaGrid({
    required this.date,
    required this.time,
    required this.classTime,
    required this.seatsLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3.4,
        children: [
          MetaTile(
              icon: Icons.calendar_today_outlined, label: 'Date', value: date),
          MetaTile(icon: Icons.access_time_rounded, label: 'Time', value: time),
          MetaTile(
              icon: Icons.hourglass_bottom_rounded,
              label: 'Starts At',
              value: classTime),
          MetaTile(
            icon: Icons.event_seat_outlined,
            label: 'Seats left',
            value: '$seatsLeft available',
            valueColor: seatsLeft > 5 ? Colors.green[700] : Colors.orange[800],
          ),
        ],
      ),
    );
  }
}
