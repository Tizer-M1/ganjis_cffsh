import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniLocationTile extends StatelessWidget {
  const MiniLocationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3EC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: const Color(0xFF7A513A), size: 18),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.manrope(
              color: const Color(0xFF241713),
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.manrope(
              color: const Color(0xFF7B6E62),
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryMapCard extends StatelessWidget {
  const DeliveryMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(
          child: CustomPaint(
            painter: DeliveryMapPainter(),
          ),
        ),
        const Positioned(
          left: 22,
          top: 28,
          child: MapMarker(
            icon: Icons.storefront_rounded,
            label: 'Store',
            color: Color(0xFF241713),
          ),
        ),
        const Positioned(
          right: 28,
          bottom: 34,
          child: MapMarker(
            icon: Icons.home_rounded,
            label: 'Home',
            color: Color(0xFFC08461),
          ),
        ),
        Positioned(
          left: 124,
          top: 108,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2E0D0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delivery_dining_rounded,
                    size: 16,
                    color: Color(0xFF7A513A),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Courier nearby',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF241713),
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'ETA 7 min',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF7B6E62),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MapMarker extends StatelessWidget {
  const MapMarker({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withOpacity(0.28),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              color: const Color(0xFF241713),
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class DeliveryMapPainter extends CustomPainter {
  const DeliveryMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()..color = const Color(0xFFF1EBE2);
    canvas.drawRect(Offset.zero & size, base);

    final Paint parkPaint = Paint()..color = const Color(0xFFDDE9CB);
    final Paint waterPaint = Paint()..color = const Color(0xFFCDE3EE);
    final Paint roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width - 110, 26, 86, 76),
        const Radius.circular(20),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(18, size.height - 96, 110, 54),
        const Radius.circular(24),
      ),
      waterPaint,
    );

    final List<List<Offset>> roads = <List<Offset>>[
      <Offset>[
        Offset(0, size.height * 0.22),
        Offset(size.width * 0.24, size.height * 0.18),
        Offset(size.width * 0.48, size.height * 0.26),
        Offset(size.width, size.height * 0.14),
      ],
      <Offset>[
        Offset(0, size.height * 0.46),
        Offset(size.width * 0.34, size.height * 0.44),
        Offset(size.width * 0.58, size.height * 0.54),
        Offset(size.width, size.height * 0.48),
      ],
      <Offset>[
        Offset(size.width * 0.12, 0),
        Offset(size.width * 0.18, size.height * 0.34),
        Offset(size.width * 0.32, size.height * 0.58),
        Offset(size.width * 0.26, size.height),
      ],
      <Offset>[
        Offset(size.width * 0.72, 0),
        Offset(size.width * 0.64, size.height * 0.28),
        Offset(size.width * 0.78, size.height * 0.62),
        Offset(size.width * 0.7, size.height),
      ],
    ];

    for (final List<Offset> road in roads) {
      roadPaint.strokeWidth = 11;
      final Path path = Path()..moveTo(road.first.dx, road.first.dy);
      for (int i = 1; i < road.length; i++) {
        path.lineTo(road[i].dx, road[i].dy);
      }
      canvas.drawPath(path, roadPaint);
    }

    final Paint routeGlow = Paint()
      ..color = const Color(0xFFF2C08E).withOpacity(0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final Paint routePaint = Paint()
      ..color = const Color(0xFFC08461)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final Path route = Path()
      ..moveTo(42, 52)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.22,
        size.width * 0.38,
        size.height * 0.4,
      )
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.54,
        size.width * 0.62,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.76,
        size.height * 0.42,
        size.width - 46,
        size.height - 58,
      );

    canvas.drawPath(route, routeGlow);
    canvas.drawPath(route, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
