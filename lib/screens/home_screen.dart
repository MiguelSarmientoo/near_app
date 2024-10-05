import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> allPlaces = const [
    {'name': 'Machu Picchu', 'imagePath': 'assets/images/Machupicchu.jpg'},
    {'name': 'Mangalore', 'imagePath': 'assets/images/Mangalore.png'},
    {'name': 'Punta Arenas', 'imagePath': 'assets/images/PuntaArenas.png'},
    {'name': 'Cape Town', 'imagePath': 'assets/images/CapeTown.png'},
  ];

  List<Map<String, String>> filteredPlaces = [];
  String _locationMessage = "Getting location...";
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    filteredPlaces = allPlaces;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _locationMessage =
          "Lat: ${_currentPosition!.latitude}, Long: ${_currentPosition!.longitude}";
    });
  }

  void _filterPlaces(String query) {
    final results = allPlaces.where((place) {
      final placeName = place['name']!.toLowerCase();
      final input = query.toLowerCase();
      return placeName.contains(input);
    }).toList();

    setState(() {
      filteredPlaces = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Agregar un degradado al encabezado
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6200EA), Color(0xFF3700B3)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to NE-AR",
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Location:",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              _locationMessage,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Barra de búsqueda mejorada
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (query) => _filterPlaces(query),
                decoration: InputDecoration(
                  hintText: "Looking for other places?",
                  hintStyle: GoogleFonts.poppins(),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),

            // Sección con el mapa mejorado visualmente
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Endangered from Global Warming",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (_currentPosition != null) {
                        Navigator.pushNamed(
                          context,
                          '/map',
                          arguments: {
                            'latitude': _currentPosition!.latitude,
                            'longitude': _currentPosition!.longitude,
                          },
                        );
                      } else {
                        print("Current position is not available.");
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/map.gif',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Título mejorado para la sección de lugares cercanos
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Some other places",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),

                  // Lista mejorada con diseño de tarjetas
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredPlaces.length,
                      itemBuilder: (context, index) {
                        final place = filteredPlaces[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    place['imagePath']!,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: 130,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    place['name']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
