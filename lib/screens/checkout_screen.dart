import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/drink_item.dart';
import '../widgets/cafe_widgets.dart';
import 'delivery_tracking_screen.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
    required this.drink,
    required this.quantity,
    required this.size,
    required this.temperature,
    required this.option,
  });

  final DrinkItem drink;
  final int quantity;
  final String size;
  final String temperature;
  final String option;

  @override
  Widget build(BuildContext context) {
    final int subtotal = drink.price * quantity;
    const int delivery = 2000;
    final int total = subtotal + delivery;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: <Widget>[
            const TopBar(title: 'Checkout'),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: <Widget>[
                  DrinkImage(drink: drink, height: 110),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          drink.name,
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 28,
                            color: const Color(0xFF241713),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            MiniTag(text: '$size size'),
                            MiniTag(text: temperature),
                            MiniTag(text: option),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const InfoCard(
              title: 'Delivery details',
              children: <Widget>[
                InfoRow(label: 'Address', value: 'Peace Avenue 18, Ulaanbaatar'),
                SizedBox(height: 12),
                InfoRow(label: 'Method', value: 'Express delivery'),
                SizedBox(height: 12),
                InfoRow(label: 'Payment', value: 'Visa ending 2048'),
              ],
            ),
            const SizedBox(height: 14),
            InfoCard(
              title: 'Payment summary',
              children: <Widget>[
                InfoRow(label: 'Subtotal', value: 'MNT $subtotal'),
                const SizedBox(height: 12),
                const InfoRow(label: 'Delivery', value: 'MNT 2000'),
                const Divider(height: 24),
                InfoRow(label: 'Total', value: 'MNT $total', bold: true),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          DeliveryTrackingPage(drink: drink),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF241713),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: Text(
                  'Place order',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
