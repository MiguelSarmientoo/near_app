import 'package:flutter/material.dart';
import 'package:near_app/screens/routes/app_routes.dart'; // Asegúrate de tener la importación correcta
import 'package:latlong2/latlong.dart'; // Importar LatLng si es necesario

class MoreInformationScreen extends StatefulWidget {
  final String title;
  final double latitude;
  final double longitude;
  final String description;
  final String image; // Imagen actual
  final String pastImage; // Imagen del pasado
  final String futureImage; // Imagen del futuro
  final String howtoavoid;

  const MoreInformationScreen({
    super.key,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
    required this.pastImage,
    required this.futureImage,
    required this.howtoavoid,
  });

  @override
  _MoreInformationScreenState createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
  late PageController _pageController;
  int _currentPage = 1; // Comenzamos en la imagen actual (índice 1)

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) { // Solo dos páginas después de la actual
      _currentPage++;
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {});
    }
  }

  void _previousPage() {
    if (_currentPage > 0) { // Solo dos páginas antes de la actual
      _currentPage--;
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      setState(() {});
    }
  }

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
          Image.asset(
            widget.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
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
                      'Lat: ${widget.latitude}, Long: ${widget.longitude}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // Galería de imágenes
                SizedBox(
                  height: 200, // Altura de la galería
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          _buildBackgroundImage(widget.pastImage, 'Past'),
                          _buildBackgroundImage(widget.image, 'Present'),
                          _buildBackgroundImage(widget.futureImage, 'Future'),
                        ],
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: ElevatedButton(
                          onPressed: _previousPage,
                          child: const Icon(Icons.arrow_left),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.black54, // Fondo del botón
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          child: const Icon(Icons.arrow_right),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.black54, // Fondo del botón
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Asegúrate de que la ruta para 'how_to_avoid.dart' esté definida en app_routes.dart
                        Navigator.pushNamed(
                          context,
                          AppRoutes.howToAvoid,
                          arguments: {
                            'title': widget.title,
                            'latitude': widget.latitude,
                            'longitude': widget.longitude,
                            'description': widget.description,
                            'image': widget.image,
                            'pastImage': widget.pastImage,
                            'futureImage': widget.futureImage,
                            'howtoavoid': widget.howtoavoid,
                          }, 
                        );
                      },
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
                          AppRoutes.arScreen,
                          arguments: widget.title, // Pass the location name
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

  // Método para construir una página de imagen de fondo
  Widget _buildBackgroundImage(String imagePath, String label) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
