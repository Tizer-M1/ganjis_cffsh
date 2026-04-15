import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/drink_data.dart';
import '../models/drink_item.dart';
import '../widgets/cafe_widgets.dart';
import 'delivery_tracking_screen.dart';
import 'drink_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _favorites = <String>{
    'Spanish Latte',
    'Iced Matcha Latte',
    'Mango Smoothie',
  };

  int _tabIndex = 0;
  int _categoryIndex = 0;
  String _query = '';

  List<String> get _categories => <String>[
        'All',
        ...cafeDrinks.map((DrinkItem e) => e.category).toSet(),
      ];

  List<DrinkItem> get _filteredDrinks {
    final String category = _categories[_categoryIndex];
    return cafeDrinks.where((DrinkItem drink) {
      final bool categoryMatch =
          category == 'All' || drink.category == category;
      final String q = _query.toLowerCase();
      final bool queryMatch = q.isEmpty ||
          drink.name.toLowerCase().contains(q) ||
          drink.category.toLowerCase().contains(q) ||
          drink.subtitle.toLowerCase().contains(q);
      return categoryMatch && queryMatch;
    }).toList();
  }

  List<DrinkItem> get _favoriteDrinks => cafeDrinks
      .where((DrinkItem e) => _favorites.contains(e.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      _homePage(),
      _menuPage(),
      _favoritesPage(),
      _ordersPage(),
      _profilePage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E8),
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFF8F2E9), Color(0xFFF1E7D9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: IndexedStack(index: _tabIndex, children: pages),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: NavigationBar(
            selectedIndex: _tabIndex,
            height: 76,
            backgroundColor: const Color(0xFFFBF7F2),
            indicatorColor: const Color(0xFFEBD8C3),
            onDestinationSelected: (int index) {
              setState(() {
                _tabIndex = index;
              });
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Menu'),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'Saved',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                label: 'Orders',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homePage() {
    final List<DrinkItem> drinks =
        _filteredDrinks.isEmpty ? cafeDrinks.take(6).toList() : _filteredDrinks;

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 120),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Good drinks',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF7E7268),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'More than\njust coffee',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 42,
                      height: 0.94,
                      color: const Color(0xFF241713),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset('assets/images/icon.png'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SearchField(
          onChanged: (String value) {
            setState(() => _query = value);
          },
        ),
        const SizedBox(height: 18),
        FeatureBanner(
          drink: cafeDrinks[2],
          onTap: () => _openDetails(cafeDrinks[2]),
        ),
        const SizedBox(height: 22),
        const SectionTitle(
          title: 'Categories',
          subtitle: 'Coffee, tea, matcha, smoothies, refreshers, and more.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 46,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (BuildContext context, int index) {
              return CategoryChip(
                label: _categories[index],
                selected: _categoryIndex == index,
                onTap: () => setState(() => _categoryIndex = index),
              );
            },
          ),
        ),
        const SizedBox(height: 22),
        SectionTitle(
          title: 'Popular Today',
          subtitle: '${drinks.length} drinks match your search.',
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 245,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: drinks.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (BuildContext context, int index) {
              final DrinkItem drink = drinks[index];
              return SizedBox(
                width: 210,
                child: DrinkCard(
                  drink: drink,
                  favorite: _favorites.contains(drink.name),
                  onFavorite: () => _toggleFavorite(drink.name),
                  onTap: () => _openDetails(drink),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1D1512), Color(0xFF87553A)],
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Weekend special',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFFE8D8CC),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try tea,\nfruit, and coffee',
                      style: GoogleFonts.dmSerifDisplay(
                        color: Colors.white,
                        fontSize: 29,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...drinks.take(6).map(
          (DrinkItem drink) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: DrinkListTile(
              drink: drink,
              favorite: _favorites.contains(drink.name),
              onFavorite: () => _toggleFavorite(drink.name),
              onTap: () => _openDetails(drink),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuPage() {
    final Map<String, List<DrinkItem>> sections = <String, List<DrinkItem>>{};
    final List<DrinkItem> source =
        _filteredDrinks.isEmpty ? cafeDrinks : _filteredDrinks;
    for (final DrinkItem drink in source) {
      sections.putIfAbsent(drink.category, () => <DrinkItem>[]).add(drink);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        const PageHeader(
          title: 'Full menu',
          subtitle:
              'More options, more drinks, and more pages just like you asked.',
        ),
        const SizedBox(height: 20),
        ...sections.entries.map(
          (MapEntry<String, List<DrinkItem>> entry) => Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionTitle(
                  title: entry.key,
                  subtitle: '${entry.value.length} options',
                ),
                const SizedBox(height: 12),
                ...entry.value.map(
                  (DrinkItem drink) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MenuTile(
                      drink: drink,
                      onTap: () => _openDetails(drink),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _favoritesPage() {
    final List<DrinkItem> drinks = _favoriteDrinks.isEmpty
        ? cafeDrinks.take(3).toList()
        : _favoriteDrinks;

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        const PageHeader(
          title: 'Favorites',
          subtitle: 'Your saved drinks from different categories.',
        ),
        const SizedBox(height: 18),
        ...drinks.map(
          (DrinkItem drink) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: FavoriteTile(
              drink: drink,
              onFavorite: () => _toggleFavorite(drink.name),
              onTap: () => _openDetails(drink),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ordersPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        const PageHeader(
          title: 'Orders',
          subtitle: 'Live progress, recent drinks, and delivery tracking.',
        ),
        const SizedBox(height: 18),
        LiveOrderTile(
          drink: cafeDrinks[2],
          status: 'Brewing now',
          eta: '7 min',
          progress: 0.55,
          onTap: () => _openDelivery(cafeDrinks[2]),
        ),
        const SizedBox(height: 18),
        RecentOrderTile(
          drink: cafeDrinks[5],
          status: 'Delivered',
          time: 'Today 4:12 PM',
        ),
        const SizedBox(height: 12),
        RecentOrderTile(
          drink: cafeDrinks[7],
          status: 'Picked up',
          time: 'Yesterday',
        ),
      ],
    );
  }

  Widget _profilePage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1714),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 58,
                    width: 58,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Image.asset('assets/images/icon.png'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Ganjis Rewards',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFFD8CCC0),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ariunaa S.',
                          style: GoogleFonts.dmSerifDisplay(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'You now have enough points for one free drink upgrade.',
                style: GoogleFonts.manrope(
                  color: const Color(0xFFD8CCC0),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const ProfileInfoTile(
          icon: Icons.water_drop_rounded,
          title: 'Less ice by default',
          subtitle: 'Applied to cold drinks and refreshers',
        ),
        const SizedBox(height: 12),
        const ProfileInfoTile(
          icon: Icons.grass_rounded,
          title: 'Oat milk preference',
          subtitle: 'Suggested for coffee and matcha',
        ),
        const SizedBox(height: 12),
        const ProfileInfoTile(
          icon: Icons.notifications_active_rounded,
          title: 'Pickup ready alerts',
          subtitle: 'Order updates are turned on',
        ),
      ],
    );
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
  }

  Future<void> _openDetails(DrinkItem drink) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => DrinkDetailsPage(drink: drink),
      ),
    );
  }

  Future<void> _openDelivery(DrinkItem drink) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => DeliveryTrackingPage(drink: drink),
      ),
    );
  }
}
