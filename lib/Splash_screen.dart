import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔽 Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/coffee.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔽 Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.75),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔽 Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 100),

                // 🔽 Logo
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: ClipRRect(
  borderRadius: BorderRadius.circular(100),
  child: Image.asset(
    'assets/images/icon.png', // your image
    width: 40,
    height: 40,
    fit: BoxFit.cover,
  ),
),
                  ),
                ),

                const SizedBox(height: 60),

                // 🔽 Title
                Text(
                  "Good Mornings\nStart With Coffee",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 12),

                // 🔽 Subtitle
                Text(
                  "Welcome to our cozy coffee corner.\nMay every cup be enjoyable for you.",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const Spacer(),

                // 🔥 PREMIUM BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ),
  );
},
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8B5E3C),
                            Color(0xFF6F4E37),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Get started",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}