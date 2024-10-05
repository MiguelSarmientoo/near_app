import 'package:flutter/material.dart';
import 'package:near_app/screens/routes/app_routes.dart'; // Asegúrate de tener la importación correcta

class MoreInformationScreen extends StatelessWidget {
  final String title;
  final double latitude;
  final double longitude;
  final String description;
  final String image;

  const MoreInformationScreen({
    super.key,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      'Lat: $latitude, Long: $longitude',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color.fromARGB(169, 147, 90, 212),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'How To Avoid That?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.arScreen, // Navegar a la nueva pantalla AR
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color.fromARGB(255, 61, 18, 162),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Want to see more? Try NE-AR On your Location',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
