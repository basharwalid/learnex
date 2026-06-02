import 'package:flutter/material.dart';
import 'package:learnex/UI/widgets/reserve_seat/price_row.dart';

class PriceSummary extends StatelessWidget {
  final int price;
  const PriceSummary({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff7f9fc),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.06), width: 1),
      ),
      child: Column(
        children: [
          PriceRow(label: 'Session fee', value: 'EGP $price'),
          const SizedBox(height: 10),
          PriceRow(
              label: 'Booking fee',
              value: 'Free',
              valueColor: const Color(0xff1a7a4a)),
          const SizedBox(height: 12),
          Divider(color: Colors.black.withOpacity(0.08), height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              Text(
                'EGP $price',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1a7a4a)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}