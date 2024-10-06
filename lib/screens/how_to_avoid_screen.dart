// lib/screens/how_to_avoid_screen.dart
import 'package:flutter/material.dart';

class HowToAvoidScreen extends StatelessWidget {
  final String title;
  final double latitude;
  final double longitude;
  final String description;
  final String image;
  final String pastImage;
  final String futureImage;
  final String howtoavoid;

  const HowToAvoidScreen({
    Key? key,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.image,
    required this.pastImage,
    required this.futureImage,
    required this.howtoavoid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How To Avoid That?'),
        backgroundColor: const Color(0xFF6200EA), // Color principal
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 20),
              _buildCoordinates(),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 20),
              _buildImage(),
              const SizedBox(height: 20),
              _buildHowToAvoidText(),
              const SizedBox(height: 20),
              _buildFooter(), // Agregar footer
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  // Método para construir el título
  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6200EA), // Color principal para el título
      ),
    );
  }

  // Método para construir las coordenadas
  Widget _buildCoordinates() {
    return Text(
      'Lat: $latitude, Long: $longitude',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    );
  }

  // Método para construir la descripción
  Widget _buildDescription() {
    return Text(
      description,
      style: const TextStyle(fontSize: 18),
    );
  }

  // Método para mostrar la imagen
  Widget _buildImage() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
      ),
    );
  }

  // Método para mostrar el texto sobre cómo evitar el problema
  Widget _buildHowToAvoidText() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF6200EA).withOpacity(0.1), // Fondo con opacidad
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        howtoavoid,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6200EA), // Color principal
        ),
      ),
    );
  }

  // Método para construir el footer
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF6200EA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '© 2024 Near App. All rights reserved.',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
