import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './OnboardingScreen4.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/courseview.png'), // Asegúrate que esta imagen exista
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Filtro de oscuridad
          Container(
            color: Colors.black54, // Filtro de oscuridad con opacidad
          ),
          // Contenido principal
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w), // Cambiado para un mejor espaciado
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'COURSE AND NEWS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h), // Espacio entre título y descripción

                  // Descripción
                  Text(
                    'Got the key to knowledge? Time to unlock your brain. Stay informed, stay ahead with the latest news and updates.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h), // Espacio adicional antes del botón

                  // Botón de siguiente
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen4(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Color de fondo del botón
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4725F3), // Color primario para el texto
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
