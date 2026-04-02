import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeDrink {
  const CoffeeDrink({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  final String name;
  final String subtitle;
  final int price;
  final double rating;
  final String category;
  final String description;
  final String imageUrl;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _categories = <String>[
    'Cappuccino',
    'Latte',
    'Americano',
    'Espresso',
  ];

  static const List<CoffeeDrink> _coffees = <CoffeeDrink>[
    CoffeeDrink(
      name: 'Cappuccino',
      subtitle: 'with cocoa dust',
      price: 12000,
      rating: 4.5,
      category: 'Cappuccino',
      description:
          'A balanced cup with velvety foam, toasted cacao notes, and a mellow sweetness that stays smooth from first sip to finish.',
      imageUrl:
          'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
    CoffeeDrink(
      name: 'Latte',
      subtitle: 'with oat milk',
      price: 11000,
      rating: 4.5,
      category: 'Latte',
      description:
          'Creamy espresso folded into steamed oat milk for a soft, cozy texture that makes slow mornings feel a little more luxurious.',
      imageUrl:
          'https://images.pexels.com/photos/4145790/pexels-photo-4145790.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
    CoffeeDrink(
      name: 'Americano',
      subtitle: 'black coffee',
      price: 10000,
      rating: 5.0,
      category: 'Americano',
      description:
          'Clean, bold, and aromatic with a bright finish. Built for people who like their coffee crisp, deep, and confidently simple.',
      imageUrl:
          'https://images.pexels.com/photos/302902/pexels-photo-302902.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
    CoffeeDrink(
      name: 'Espresso',
      subtitle: 'hot and strong',
      price: 11500,
      rating: 4.5,
      category: 'Espresso',
      description:
          'A concentrated shot with dark chocolate character, a gentle caramel edge, and the kind of finish that lingers pleasantly.',
      imageUrl:
          'https://images.pexels.com/photos/3587566/pexels-photo-3587566.jpeg?auto=compress&cs=tinysrgb&w=900',
    ),
  ];

  int _selectedTab = 0;
  int _selectedCategory = 0;
  String _searchQuery = '';
  final Set<String> _favorites = <String>{'Latte'};

  List<CoffeeDrink> get _filteredCoffees {
    final String selectedCategory = _categories[_selectedCategory];
    return _coffees.where((CoffeeDrink coffee) {
      final bool matchesCategory = coffee.category == selectedCategory;
      final bool matchesSearch = _searchQuery.isEmpty ||
          coffee.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<CoffeeDrink> get _favoriteCoffees => _coffees
      .where((CoffeeDrink coffee) => _favorites.contains(coffee.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = <Widget>[
      _buildExplorePage(context),
      _buildFavoritesPage(context),
      _buildOrdersPage(context),
      _buildProfilePage(context),
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: const Color(0xFFF6F1E8),
      ),
      child: Scaffold(
        extendBody: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFFF8F4EC), Color(0xFFEFE6D8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: IndexedStack(index: _selectedTab, children: pages),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildExplorePage(BuildContext context) {
    final List<CoffeeDrink> coffees =
        _filteredCoffees.isEmpty ? _coffees : _filteredCoffees;

    return Stack(
      children: <Widget>[
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD7C2A3).withOpacity(0.35),
            ),
          ),
        ),
        Positioned(
          top: 140,
          left: -50,
          child: Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFB66A3D).withOpacity(0.08),
            ),
          ),
        ),
        ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Good Morning',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF7E7266),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Find your\nperfect brew',
                        style: GoogleFonts.dmSerifDisplay(
                          height: 0.95,
                          color: const Color(0xFF201512),
                          fontSize: 44,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(11),
                  child: Image.asset('assets/images/icon.png'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE6DCCC)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (String value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF31231D),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF8C7D6E),
                        ),
                        hintText: 'Search latte, beans, dessert',
                        hintStyle: GoogleFonts.manrope(
                          color: const Color(0xFF9D9085),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filter panel coming next.')),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1714),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.tune_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                gradient: const LinearGradient(
                  colors: <Color>[Color(0xFF231815), Color(0xFF6D412B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF6D412B).withOpacity(0.24),
                    blurRadius: 28,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Ulaanbaatar, Mongolia',
                            style: GoogleFonts.manrope(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Roasted slow.\nPoured bold.',
                          style: GoogleFonts.dmSerifDisplay(
                            color: Colors.white,
                            fontSize: 34,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A warmer, cleaner coffee experience with fast ordering and delivery tracking.',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFFE2D8D0),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      coffees.first.imageUrl,
                      width: 112,
                      height: 168,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  final bool selected = _selectedCategory == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    borderRadius: BorderRadius.circular(22),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFF1F1714) : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF1F1714)
                              : const Color(0xFFE2D7C8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.manrope(
                          color: selected
                              ? Colors.white
                              : const Color(0xFF6F6258),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Popular Today',
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 30,
                      color: const Color(0xFF201512),
                    ),
                  ),
                ),
                Text(
                  '${coffees.length} drinks',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF8B7D71),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...coffees.map(
              (CoffeeDrink coffee) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _CoffeeCard(
                  coffee: coffee,
                  isFavorite: _favorites.contains(coffee.name),
                  onFavoriteToggle: () => _toggleFavorite(coffee.name),
                  onAddPressed: () => _openDetails(context, coffee),
                  onTap: () => _openDetails(context, coffee),
                ),
              ),
            ),
            const SizedBox(height: 8),
            _PromoBanner(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Weekend offer added to your wallet.'),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              'Quick Picks',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 28,
                color: const Color(0xFF201512),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 132,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _coffees.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (BuildContext context, int index) {
                  final CoffeeDrink coffee = _coffees[index];
                  return SizedBox(
                    width: 160,
                    child: _MiniCoffeeTile(
                      coffee: coffee,
                      onTap: () => _openDetails(context, coffee),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFavoritesPage(BuildContext context) {
    final List<CoffeeDrink> favorites =
        _favoriteCoffees.isEmpty ? _coffees.take(2).toList() : _favoriteCoffees;

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1714),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Saved Drinks',
                style: GoogleFonts.dmSerifDisplay(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'A shortlist of the cups you keep coming back to.',
                style: GoogleFonts.manrope(
                  color: const Color(0xFFD1C2B6),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  _buildStatCard('Favorites', '${favorites.length}'),
                  const SizedBox(width: 12),
                  _buildStatCard('Avg Price', 'MNT 11k'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...favorites.map(
          (CoffeeDrink coffee) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _FavoriteListTile(
              coffee: coffee,
              onTap: () => _openDetails(context, coffee),
              onFavoriteToggle: () => _toggleFavorite(coffee.name),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersPage(BuildContext context) {
    final CoffeeDrink featuredOrder = _coffees[1];

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Orders',
                style: GoogleFonts.dmSerifDisplay(
                  color: const Color(0xFF201512),
                  fontSize: 38,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5DACB)),
              ),
              child: Text(
                'Live',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF6A5D52),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Checkout and delivery tracking now live from one place.',
          style: GoogleFonts.manrope(
            color: const Color(0xFF817468),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFFE6D6BE), Color(0xFFC68A58)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
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
                        color: const Color(0xFF4C3529),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Latte\nOrder #244',
                      style: GoogleFonts.dmSerifDisplay(
                        color: const Color(0xFF271714),
                        fontSize: 32,
                        height: 0.95,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Expected in 10 minutes',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF4C3529),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  featuredOrder.imageUrl,
                  width: 102,
                  height: 132,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      featuredOrder.imageUrl,
                      height: 82,
                      width: 82,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          featuredOrder.name,
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          featuredOrder.subtitle,
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF8B7A70),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Order #244',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF9C643A),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _openCheckout(context, featuredOrder),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFD6C0AF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        'Open Checkout',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF5B4132),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _openDelivery(context, featuredOrder),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F1714),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        'Track Order',
                        style: GoogleFonts.manrope(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePage(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
      children: <Widget>[
        Text(
          'Profile',
          style: GoogleFonts.dmSerifDisplay(
            color: const Color(0xFF201512),
            fontSize: 38,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1F1714), Color(0xFF6B422D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset('assets/images/icon.png'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Batbaatar Ganji',
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gold member since 2025',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFFE5D3C4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            _buildStatCard('Points', '1,280', dark: false),
            const SizedBox(width: 12),
            _buildStatCard('Orders', '24', dark: false),
          ],
        ),
        const SizedBox(height: 18),
        ...<MapEntry<IconData, String>>[
          const MapEntry(Icons.local_cafe_outlined, 'My orders'),
          const MapEntry(Icons.location_on_outlined, 'Saved addresses'),
          const MapEntry(Icons.wallet_outlined, 'Payment methods'),
          const MapEntry(Icons.settings_outlined, 'Preferences'),
        ].map(
          (MapEntry<IconData, String> item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: Colors.white,
              leading: Icon(item.key, color: const Color(0xFF8E5C3B)),
              title: Text(
                item.value,
                style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.value} opened.')),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    final List<IconData> icons = <IconData>[
      Icons.home_outlined,
      Icons.favorite_border_rounded,
      Icons.shopping_bag_outlined,
      Icons.person_outline_rounded,
    ];
    final List<String> labels = <String>[
      'Home',
      'Saved',
      'Orders',
      'Profile',
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 22),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF18110F),
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(icons.length, (int index) {
          final bool selected = _selectedTab == index;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            borderRadius: BorderRadius.circular(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF8D5634)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    icons[index],
                    color: Colors.white,
                  ),
                  if (selected) ...<Widget>[
                    const SizedBox(width: 8),
                    Text(
                      labels[index],
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _toggleFavorite(String coffeeName) {
    setState(() {
      if (_favorites.contains(coffeeName)) {
        _favorites.remove(coffeeName);
      } else {
        _favorites.add(coffeeName);
      }
    });
  }

  Future<void> _openDetails(BuildContext context, CoffeeDrink coffee) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CoffeeDetailsPage(
          coffee: coffee,
          isFavorite: _favorites.contains(coffee.name),
          onFavoriteToggle: () => _toggleFavorite(coffee.name),
          onBuyNow: () => _openCheckout(context, coffee),
        ),
      ),
    );
    setState(() {});
  }

  void _openCheckout(BuildContext context, CoffeeDrink coffee) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CheckoutPage(
          coffee: coffee,
          onTrackOrder: () => _openDelivery(context, coffee),
        ),
      ),
    );
  }

  void _openDelivery(BuildContext context, CoffeeDrink coffee) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DeliveryTrackingPage(coffee: coffee),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, {bool dark = true}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dark ? Colors.white.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: dark
                ? Colors.white.withOpacity(0.14)
                : const Color(0xFFE5DACD),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: GoogleFonts.manrope(
                color:
                    dark ? const Color(0xFFD8CABE) : const Color(0xFF8A7C70),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.dmSerifDisplay(
                color: dark ? Colors.white : const Color(0xFF201512),
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeeDetailsPage extends StatefulWidget {
  const CoffeeDetailsPage({
    super.key,
    required this.coffee,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onBuyNow,
  });

  final CoffeeDrink coffee;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onBuyNow;

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {
  String _selectedSize = 'M';
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            widget.coffee.imageUrl,
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 14,
                          child: _RoundIconButton(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Positioned(
                          right: 14,
                          top: 14,
                          child: _RoundImageButton(
                            onTap: () {
                              widget.onFavoriteToggle();
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                            icon: _isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.coffee.name,
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 42,
                                  color: const Color(0xFF1F150F),
                                ),
                              ),
                              Text(
                                widget.coffee.subtitle,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: const Color(0xFF3A2B22),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.star_border_rounded,
                              size: 28,
                              color: Color(0xFF2E241E),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.coffee.rating.toStringAsFixed(1),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'MNT ${widget.coffee.price}',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F150F),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Size',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: const Color(0xFF3E3028),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        for (final String size in <String>['S', 'M', 'L'])
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: _SizeChip(
                              label: size,
                              selected: _selectedSize == size,
                              onTap: () {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: const Color(0xFF3E3028),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.coffee.description,
                      style: GoogleFonts.poppins(
                        height: 1.8,
                        color: const Color(0xFF6E5B4F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: widget.onBuyNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC09167),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.coffee,
    required this.onTrackOrder,
  });

  final CoffeeDrink coffee;
  final VoidCallback onTrackOrder;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _delivery = true;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final int subtotal = widget.coffee.price * _quantity;
    final int deliveryFee = _delivery ? 3000 : 0;
    final int total = subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Place Order',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1F150F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFF3ECE5),
              child: Image.asset('assets/images/icon.png', width: 22),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF5EEE7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _SegmentButton(
                      label: 'Delivery',
                      selected: _delivery,
                      onTap: () => setState(() => _delivery = true),
                    ),
                  ),
                  Expanded(
                    child: _SegmentButton(
                      label: 'Pick Up',
                      selected: !_delivery,
                      onTap: () => setState(() => _delivery = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _delivery ? 'Delivery Address' : 'Pick-up Branch',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2119),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _delivery ? '3/244' : 'Shangri-La Coffee Bar',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2119),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _delivery ? 'Shangri-La Hotel' : 'Sukhbaatar District',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF8A7769),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                _PillActionButton(
                  label: 'Edit Address',
                  icon: Icons.edit_outlined,
                  onTap: () => _showNotice(context, 'Address editor opened.'),
                ),
                _PillActionButton(
                  label: 'Add Note',
                  icon: Icons.note_add_outlined,
                  onTap: () => _showNotice(context, 'Note field opened.'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFF0E5DB)),
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      widget.coffee.imageUrl,
                      height: 76,
                      width: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.coffee.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.coffee.subtitle,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF7F6D62),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _QuantityControl(
                    quantity: _quantity,
                    onChanged: (int value) {
                      setState(() {
                        _quantity = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _showNotice(context, 'Discount sheet opened.'),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF0E5DB)),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.discount_rounded, color: Color(0xFF14A44D)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '1 Discount is Applied',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF30231C),
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment Summary',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            _PriceRow(label: 'Item Price', value: subtotal),
            const SizedBox(height: 8),
            _PriceRow(label: 'Delivery Fee', value: deliveryFee),
            const SizedBox(height: 8),
            _PriceRow(label: 'Total', value: total, bold: true),
            const SizedBox(height: 18),
            InkWell(
              onTap: () => _showNotice(context, 'Cash / Wallet selected.'),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.account_balance_wallet_outlined,
                      color: Color(0xFFF29A38)),
                  const SizedBox(width: 10),
                  Text(
                    'Cash/ Wallet',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'MNT 17,000',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  _showNotice(context, 'Order placed successfully.');
                  widget.onTrackOrder();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC09167),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class DeliveryTrackingPage extends StatefulWidget {
  const DeliveryTrackingPage({super.key, required this.coffee});

  final CoffeeDrink coffee;

  @override
  State<DeliveryTrackingPage> createState() => _DeliveryTrackingPageState();
}

class _DeliveryTrackingPageState extends State<DeliveryTrackingPage> {
  final TransformationController _controller = TransformationController();
  int _selectedStop = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_MapStop> stops = <_MapStop>[
      const _MapStop(
        label: 'Cafe',
        subtitle: 'Order picked up',
        position: Offset(130, 335),
      ),
      const _MapStop(
        label: 'Courier',
        subtitle: 'Rider is nearby',
        position: Offset(270, 420),
      ),
      const _MapStop(
        label: 'Destination',
        subtitle: '10 minutes away',
        position: Offset(405, 510),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 52, 14, 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: InteractiveViewer(
                    transformationController: _controller,
                    minScale: 1,
                    maxScale: 3.4,
                    boundaryMargin: const EdgeInsets.all(120),
                    child: SizedBox(
                      height: 700,
                      width: 520,
                      child: CustomPaint(
                        painter: _CityMapPainter(
                          selectedStop: _selectedStop,
                          stops: stops,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 26,
              top: 18,
              child: _RoundIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              right: 26,
              top: 18,
              child: _RoundIconButton(
                icon: Icons.center_focus_strong_rounded,
                onTap: () {
                  _controller.value = Matrix4.identity();
                },
              ),
            ),
            Positioned(
              left: 28,
              right: 28,
              bottom: 22,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '10 minutes left',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF221813),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Delivery to Ganjims Batbaatar',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF8D7B70),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: List<Widget>.generate(
                        4,
                        (int index) => Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                            decoration: BoxDecoration(
                              color: index < 3
                                  ? const Color(0xFF26B23F)
                                  : const Color(0xFFE4DED8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCF8F4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEEE1D4)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.delivery_dining_rounded,
                              color: Color(0xFFDB9D3F),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Hand off your order',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Your courier can complete the drop-off shortly.',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF85766A),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 46,
                                    width: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=300',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Batbaatar',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Delivery Partner',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF8A796E),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        _RoundIconButton(
                          icon: Icons.call_outlined,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Calling your courier...'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final bool selected = _selectedStop == index;
                          return ChoiceChip(
                            label: Text(
                              stops[index].label,
                              style: GoogleFonts.poppins(
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF6D5A4F),
                              ),
                            ),
                            selected: selected,
                            onSelected: (_) {
                              setState(() {
                                _selectedStop = index;
                              });
                            },
                            selectedColor: const Color(0xFFC09167),
                            backgroundColor: const Color(0xFFF1E6DB),
                            showCheckmark: false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          );
                        },
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemCount: stops.length,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        stops[_selectedStop].subtitle,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF8A796E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoffeeCard extends StatelessWidget {
  const _CoffeeCard({
    required this.coffee,
    required this.isFavorite,
    required this.onTap,
    required this.onAddPressed,
    required this.onFavoriteToggle,
  });

  final CoffeeDrink coffee;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onAddPressed;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFE7DCCF)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 22,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    coffee.imageUrl,
                    height: 118,
                    width: 108,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white.withOpacity(0.92),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 17,
                        color: const Color(0xFF8D5634),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    coffee.category.toUpperCase(),
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF9B8A7B),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    coffee.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28,
                      color: const Color(0xFF231710),
                    ),
                  ),
                  Text(
                    coffee.subtitle,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF7D6E61),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5EEE5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star_rounded,
                              size: 15,
                              color: Colors.amber.shade700,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              coffee.rating.toStringAsFixed(1),
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF58463A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'MNT ${coffee.price}',
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: const Color(0xFF231710),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: onAddPressed,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1714),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.arrow_forward_rounded,
                              color: Colors.white, size: 18),
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

class _MiniCoffeeTile extends StatelessWidget {
  const _MiniCoffeeTile({required this.coffee, required this.onTap});

  final CoffeeDrink coffee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        height: 132,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: DecorationImage(
            image: NetworkImage(coffee.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              coffee.name,
              style: GoogleFonts.dmSerifDisplay(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Text(
              'MNT ${coffee.price}',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: <Color>[Color(0xFF1D1512), Color(0xFF8B5536)],
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
                  Text(
                    'Weekend Tasting Menu',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFFE6D7CA),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '50% off your\nfirst crafted cup',
                    style: GoogleFonts.dmSerifDisplay(
                      color: Colors.white,
                      fontSize: 30,
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
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteListTile extends StatelessWidget {
  const _FavoriteListTile({
    required this.coffee,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  final CoffeeDrink coffee;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

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
          border: Border.all(color: const Color(0xFFE6DBCE)),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                coffee.imageUrl,
                width: 92,
                height: 92,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Curated Pick',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF9A8A7C),
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coffee.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    coffee.subtitle,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF89776C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MNT ${coffee.price}',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF8D5634),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavoriteToggle,
              icon: const Icon(
                Icons.favorite_rounded,
                color: Color(0xFFC09167),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundImageButton extends StatelessWidget {
  const _RoundImageButton({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: 48,
          width: 48,
          child: Icon(icon, color: const Color(0xFF6C4A34)),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          height: 44,
          width: 44,
          child: Icon(icon, color: const Color(0xFF2D2119)),
        ),
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({
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
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 68,
        height: 50,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFC09167) : const Color(0xFFF3F0EC),
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.08 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: selected ? Colors.white : const Color(0xFF44342B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
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
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFC09167) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: selected ? Colors.white : const Color(0xFF402E24),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _PillActionButton extends StatelessWidget {
  const _PillActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF4F3A2E),
        side: const BorderSide(color: Color(0xFFD6C8BD)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _MiniActionButton(
          icon: Icons.remove,
          onTap: quantity > 1 ? () => onChanged(quantity - 1) : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '$quantity',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _MiniActionButton(
          icon: Icons.add,
          onTap: () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}

class _MiniActionButton extends StatelessWidget {
  const _MiniActionButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0D4CA)),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onTap == null ? const Color(0xFFB8AAA0) : const Color(0xFF3D2E25),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final int value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF46362C),
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          'MNT $value',
          style: GoogleFonts.poppins(
            color: const Color(0xFF46362C),
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MapStop {
  const _MapStop({
    required this.label,
    required this.subtitle,
    required this.position,
  });

  final String label;
  final String subtitle;
  final Offset position;
}

class _CityMapPainter extends CustomPainter {
  const _CityMapPainter({
    required this.selectedStop,
    required this.stops,
  });

  final int selectedStop;
  final List<_MapStop> stops;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = const Color(0xFFF0EBE4);
    canvas.drawRect(Offset.zero & size, background);

    final Paint roadPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final List<List<Offset>> roads = <List<Offset>>[
      <Offset>[
        const Offset(20, 60),
        const Offset(180, 30),
        const Offset(300, 80),
        const Offset(500, 20),
      ],
      <Offset>[
        const Offset(10, 150),
        const Offset(170, 170),
        const Offset(260, 100),
        const Offset(480, 170),
      ],
      <Offset>[
        const Offset(10, 260),
        const Offset(150, 250),
        const Offset(250, 300),
        const Offset(500, 260),
      ],
      <Offset>[
        const Offset(60, 420),
        const Offset(180, 390),
        const Offset(300, 430),
        const Offset(500, 380),
      ],
      <Offset>[
        const Offset(0, 560),
        const Offset(120, 520),
        const Offset(290, 560),
        const Offset(520, 520),
      ],
      <Offset>[
        const Offset(70, 0),
        const Offset(60, 150),
        const Offset(110, 290),
        const Offset(80, 700),
      ],
      <Offset>[
        const Offset(210, 0),
        const Offset(220, 150),
        const Offset(180, 320),
        const Offset(210, 700),
      ],
      <Offset>[
        const Offset(355, 0),
        const Offset(300, 170),
        const Offset(340, 350),
        const Offset(290, 700),
      ],
      <Offset>[
        const Offset(470, 0),
        const Offset(450, 130),
        const Offset(390, 270),
        const Offset(430, 700),
      ],
    ];

    for (final List<Offset> road in roads) {
      roadPaint.strokeWidth = road.length.isEven ? 10 : 7;
      final Path path = Path()..moveTo(road.first.dx, road.first.dy);
      for (int i = 1; i < road.length; i++) {
        final Offset previous = road[i - 1];
        final Offset current = road[i];
        final Offset midpoint =
            Offset((previous.dx + current.dx) / 2, (previous.dy + current.dy) / 2);
        path.quadraticBezierTo(previous.dx, previous.dy, midpoint.dx, midpoint.dy);
      }
      path.lineTo(road.last.dx, road.last.dy);
      canvas.drawPath(path, roadPaint);
    }

    final Paint river = Paint()
      ..color = const Color(0xFF9FD0D4)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Path riverPath = Path()
      ..moveTo(-20, 470)
      ..quadraticBezierTo(120, 420, 260, 470)
      ..quadraticBezierTo(390, 520, 540, 460);
    canvas.drawPath(riverPath, river);

    final Paint park = Paint()..color = const Color(0xFFBFD7A8);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(410, 280, 90, 120),
        const Radius.circular(18),
      ),
      park,
    );

    final Paint routeShadow = Paint()
      ..color = const Color(0xFFF1B26D).withOpacity(0.35)
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint routePaint = Paint()
      ..color = const Color(0xFFF59A23)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path routePath = Path()
      ..moveTo(stops[0].position.dx, stops[0].position.dy)
      ..lineTo(240, 335)
      ..lineTo(240, 470)
      ..lineTo(stops[2].position.dx, stops[2].position.dy);

    canvas.drawPath(routePath, routeShadow);
    canvas.drawPath(routePath, routePaint);

    for (int i = 0; i < stops.length; i++) {
      final bool selected = selectedStop == i;
      final Offset point = stops[i].position;

      canvas.drawCircle(
        point,
        selected ? 16 : 12,
        Paint()..color = const Color(0xFFF4B44A).withOpacity(0.28),
      );
      canvas.drawCircle(
        point,
        selected ? 10 : 8,
        Paint()..color = const Color(0xFFF59A23),
      );

      final TextPainter painter = TextPainter(
        text: TextSpan(
          text: i == 1 ? 'C' : i == 2 ? 'D' : 'H',
          style: TextStyle(
            color: i == 2 ? Colors.white : const Color(0xFF5A3A1F),
            fontWeight: FontWeight.bold,
            fontSize: selected ? 16 : 13,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        point - Offset(painter.width / 2, painter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CityMapPainter oldDelegate) {
    return oldDelegate.selectedStop != selectedStop ||
        oldDelegate.stops != stops;
  }
}
