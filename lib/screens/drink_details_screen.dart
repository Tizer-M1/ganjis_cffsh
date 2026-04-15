import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/drink_item.dart';
import '../widgets/cafe_widgets.dart';
import 'checkout_screen.dart';

class DrinkDetailsPage extends StatefulWidget {
  const DrinkDetailsPage({super.key, required this.drink});

  final DrinkItem drink;

  @override
  State<DrinkDetailsPage> createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  static const List<String> _sizes = <String>['S', 'M', 'L'];
  static const List<String> _temps = <String>['Hot', 'Warm', 'Iced'];

  int _sizeIndex = 1;
  int _tempIndex = 0;
  int _optionIndex = 0;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.drink.category != 'Coffee' &&
        widget.drink.category != 'Chocolate') {
      _tempIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DrinkItem drink = widget.drink;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: <Widget>[
            const TopBar(title: 'Details'),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: <Color>[drink.color, drink.color.withOpacity(0.55)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SmallBadge(label: drink.category),
                  const SizedBox(height: 18),
                  Center(child: DrinkImage(drink: drink, height: 250)),
                  const SizedBox(height: 16),
                  Text(
                    drink.name,
                    style: GoogleFonts.dmSerifDisplay(
                      color: Colors.white,
                      fontSize: 38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    drink.description,
                    style: GoogleFonts.manrope(
                      color: Colors.white.withOpacity(0.94),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Size', subtitle: 'Choose your cup size.'),
            const SizedBox(height: 12),
            Row(
              children: List<Widget>.generate(_sizes.length, (int index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
                  child: ChoiceBox(
                    label: _sizes[index],
                    selected: _sizeIndex == index,
                    onTap: () => setState(() => _sizeIndex = index),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            const SectionTitle(
              title: 'Temperature',
              subtitle: 'Hot, warm, or iced.',
            ),
            const SizedBox(height: 12),
            Row(
              children: List<Widget>.generate(_temps.length, (int index) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
                    child: SegmentBox(
                      label: _temps[index],
                      selected: _tempIndex == index,
                      onTap: () => setState(() => _tempIndex = index),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            const SectionTitle(
              title: 'Options',
              subtitle: 'Add what fits this drink best.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List<Widget>.generate(drink.options.length, (int index) {
                return OptionBox(
                  label: drink.options[index],
                  selected: _optionIndex == index,
                  onTap: () => setState(() => _optionIndex = index),
                );
              }),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: <Widget>[
                  QuantityPicker(
                    quantity: _quantity,
                    onMinus: _quantity > 1
                        ? () => setState(() => _quantity--)
                        : null,
                    onPlus: () => setState(() => _quantity++),
                  ),
                  const Spacer(),
                  Text(
                    'MNT ${drink.price * _quantity}',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 30,
                      color: const Color(0xFF241713),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => CheckoutPage(
                        drink: drink,
                        quantity: _quantity,
                        size: _sizes[_sizeIndex],
                        temperature: _temps[_tempIndex],
                        option: drink.options[_optionIndex],
                      ),
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
                  'Continue to checkout',
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
