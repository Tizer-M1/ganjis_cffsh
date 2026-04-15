import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/drink_item.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE6D9CC)),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF8E8074)),
          hintText: 'Search coffee, tea, smoothies, lemonade...',
          hintStyle: GoogleFonts.manrope(color: const Color(0xFF9F9287)),
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 40,
            color: const Color(0xFF241713),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.manrope(
            color: const Color(0xFF827569),
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 30,
            color: const Color(0xFF241713),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.manrope(
            color: const Color(0xFF87796D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class FeatureBanner extends StatelessWidget {
  const FeatureBanner({super.key, required this.drink, required this.onTap});

  final DrinkItem drink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: <Color>[drink.color, drink.color.withOpacity(0.55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SmallBadge(label: 'Featured'),
                  const SizedBox(height: 16),
                  Text(
                    drink.name,
                    style: GoogleFonts.dmSerifDisplay(
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    drink.subtitle,
                    style: GoogleFonts.manrope(
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ),
            ),
            DrinkImage(drink: drink, height: 140),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF241713) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? const Color(0xFF241713) : const Color(0xFFE1D5C7),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: selected ? Colors.white : const Color(0xFF6B5D51),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  const DrinkCard({
    super.key,
    required this.drink,
    required this.favorite,
    required this.onFavorite,
    required this.onTap,
  });

  final DrinkItem drink;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFE5D9CC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: const Color(0xFFC08461),
                ),
              ),
            ),
            Expanded(child: Center(child: DrinkImage(drink: drink, height: 110))),
            Text(
              drink.name,
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                color: const Color(0xFF241713),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              drink.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(color: const Color(0xFF8A7C71)),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(Icons.star_rounded, color: Colors.amber.shade700, size: 18),
                const SizedBox(width: 4),
                Text(
                  drink.rating.toStringAsFixed(1),
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF5B4D42),
                  ),
                ),
                const Spacer(),
                Text(
                  'MNT ${drink.price}',
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF241713),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkListTile extends StatelessWidget {
  const DrinkListTile({
    super.key,
    required this.drink,
    required this.favorite,
    required this.onFavorite,
    required this.onTap,
  });

  final DrinkItem drink;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE5D9CC)),
        ),
        child: Row(
          children: <Widget>[
            DrinkImage(drink: drink, height: 102),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          drink.name,
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 28,
                            color: const Color(0xFF241713),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onFavorite,
                        icon: Icon(
                          favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: const Color(0xFFC08461),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    drink.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF7B6E63),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MNT ${drink.price}',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF241713),
                      fontWeight: FontWeight.w800,
                    ),
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

class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.drink, required this.onTap});

  final DrinkItem drink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: <Widget>[
            DrinkImage(drink: drink, height: 88),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    drink.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 26,
                      color: const Color(0xFF241713),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    drink.subtitle,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF8C7E72),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'MNT ${drink.price}',
              style: GoogleFonts.manrope(
                color: const Color(0xFF241713),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    super.key,
    required this.drink,
    required this.onFavorite,
    required this.onTap,
  });

  final DrinkItem drink;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: <Widget>[
            DrinkImage(drink: drink, height: 100),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    drink.category.toUpperCase(),
                    style: GoogleFonts.manrope(
                      color: const Color(0xFFA09183),
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    drink.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28,
                      color: const Color(0xFF241713),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'MNT ${drink.price}',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFFC08461),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavorite,
              icon: const Icon(Icons.favorite_rounded, color: Color(0xFFC08461)),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveOrderTile extends StatelessWidget {
  const LiveOrderTile({
    super.key,
    required this.drink,
    required this.status,
    required this.eta,
    required this.progress,
    required this.onTap,
  });

  final DrinkItem drink;
  final String status;
  final String eta;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DrinkImage(drink: drink, height: 96),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      drink.name,
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 30,
                        color: const Color(0xFF241713),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF7C6F63),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ETA $eta',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF241713),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: const Color(0xFFF0E4D6),
            color: const Color(0xFFC08461),
            borderRadius: BorderRadius.circular(99),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onTap,
              child: Text(
                'Track live',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF7A513A),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentOrderTile extends StatelessWidget {
  const RecentOrderTile({
    super.key,
    required this.drink,
    required this.status,
    required this.time,
  });

  final DrinkItem drink;
  final String status;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          DrinkImage(drink: drink, height: 82),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  drink.name,
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 24,
                    color: const Color(0xFF241713),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF7C6F63),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.manrope(
              color: const Color(0xFF8B7D71),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E7D8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF6A4E3C)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF241713),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(color: const Color(0xFF817367)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
        const Spacer(),
        Text(
          title,
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 28,
            color: const Color(0xFF241713),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 44),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: 44,
          width: 44,
          child: Icon(icon, color: const Color(0xFF241713), size: 20),
        ),
      ),
    );
  }
}

class DrinkImage extends StatelessWidget {
  const DrinkImage({super.key, required this.drink, required this.height});

  final DrinkItem drink;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height * 0.78,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(color: drink.color.withOpacity(0.14)),
            Image.asset(
              drink.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: drink.color.withOpacity(0.18),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.local_drink_rounded,
                    color: drink.color,
                    size: height * 0.28,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SmallBadge extends StatelessWidget {
  const SmallBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ChoiceBox extends StatelessWidget {
  const ChoiceBox({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 74,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFC08461) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: selected ? Colors.white : const Color(0xFF4F4035),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class SegmentBox extends StatelessWidget {
  const SegmentBox({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF241713) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: selected ? Colors.white : const Color(0xFF4F4035),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class OptionBox extends StatelessWidget {
  const OptionBox({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF241713) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: selected ? Colors.white : const Color(0xFF55463A),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class QuantityPicker extends StatelessWidget {
  const QuantityPicker({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback? onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        QuantityButton(icon: Icons.remove, onTap: onMinus),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '$quantity',
            style: GoogleFonts.dmSerifDisplay(
              fontSize: 28,
              color: const Color(0xFF241713),
            ),
          ),
        ),
        QuantityButton(icon: Icons.add, onTap: onPlus),
      ],
    );
  }
}

class QuantityButton extends StatelessWidget {
  const QuantityButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: onTap == null ? const Color(0xFFF1E8DD) : const Color(0xFFF8F2E8),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: onTap == null ? const Color(0xFFBBAEA1) : const Color(0xFF4D3E33),
        ),
      ),
    );
  }
}

class MiniTag extends StatelessWidget {
  const MiniTag({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EBDD),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          color: const Color(0xFF5B4D42),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.dmSerifDisplay(
              fontSize: 28,
              color: const Color(0xFF241713),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: GoogleFonts.manrope(
            color: const Color(0xFF7E7064),
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: const Color(0xFF241713),
            fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class TrackerRow extends StatelessWidget {
  const TrackerRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 4),
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: active ? const Color(0xFFC08461) : const Color(0xFFD8CBBB),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF241713),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF7B6E62),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
