import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/drink_item.dart';
import '../widgets/cafe_widgets.dart';
import '../widgets/delivery_map_widgets.dart';

class DeliveryTrackingPage extends StatelessWidget {
  const DeliveryTrackingPage({super.key, required this.drink});

  final DrinkItem drink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: <Widget>[
            const TopBar(title: 'Track order'),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: <Color>[drink.color, drink.color.withOpacity(0.55)],
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'On the way',
                          style: GoogleFonts.manrope(
                            color: Colors.white.withOpacity(0.95),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          drink.name,
                          style: GoogleFonts.dmSerifDisplay(
                            color: Colors.white,
                            fontSize: 34,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Arrives in about 7 minutes.',
                          style: GoogleFonts.manrope(
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DrinkImage(drink: drink, height: 118),
                ],
              ),
            ),
            const SizedBox(height: 18),
            InfoCard(
              title: 'Live map',
              children: <Widget>[
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EBE2),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const DeliveryMapCard(),
                ),
                const SizedBox(height: 14),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: MiniLocationTile(
                        icon: Icons.storefront_rounded,
                        title: 'Store',
                        subtitle: 'Ganjis Central',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MiniLocationTile(
                        icon: Icons.delivery_dining_rounded,
                        title: 'Courier',
                        subtitle: '2.1 km away',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MiniLocationTile(
                        icon: Icons.home_rounded,
                        title: 'Drop-off',
                        subtitle: 'Peace Ave 18',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            const InfoCard(
              title: 'Delivery progress',
              children: <Widget>[
                TrackerRow(
                  title: 'Order confirmed',
                  subtitle: 'Payment approved and queue started',
                  active: true,
                ),
                SizedBox(height: 14),
                TrackerRow(
                  title: 'Drink being prepared',
                  subtitle: 'Barista is finishing the drink now',
                  active: true,
                ),
                SizedBox(height: 14),
                TrackerRow(
                  title: 'Courier on the road',
                  subtitle: 'Rider is getting closer to your address',
                  active: true,
                ),
                SizedBox(height: 14),
                TrackerRow(
                  title: 'Delivered to your door',
                  subtitle: 'Expected very soon',
                  active: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
