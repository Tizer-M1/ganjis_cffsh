import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [

            // 🔥 HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
              decoration: const BoxDecoration(
                color: Color(0xFF6F4E37),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location",
                              style: GoogleFonts.poppins(
                                  color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text("Ulaanbaatar, Mongolia",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person,
                            size: 18, color: Color(0xFF6F4E37)),
                      )
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 🔽 Search
                  Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, size: 20),
                        SizedBox(width: 10),
                        Text("Search coffee...",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🔽 Categories
            SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                children: [
                  _chip("Cappuccino", true),
                  _chip("Latte", false),
                  _chip("Americano", false),
                  _chip("Espresso", false),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🔽 GRID
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  return _coffeeCard();
                },
              ),
            ),

            // 🔥 Bottom Nav
            Container(
              height: 65,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6F4E37),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home, color: Colors.white),
                  Icon(Icons.favorite_border, color: Colors.white),
                  Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  Icon(Icons.person_outline, color: Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔽 Category chip
  Widget _chip(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF6F4E37) : Colors.brown.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // 🔽 Coffee card
  Widget _coffeeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔽 Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: Image.network(
              'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg',
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Cappuccino",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14)),

                const SizedBox(height: 4),

                Text("With Chocolate",
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.grey)),

                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    // 🔥 ₮ FIXED HERE
                    Text(
                      "\u20AE12,000",
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF6F4E37),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.add,
                          size: 16, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}