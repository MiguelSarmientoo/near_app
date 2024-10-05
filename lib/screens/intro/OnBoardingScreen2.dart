import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './OnboardingScreen3.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mountainsview.jpg'), // Cambia la ruta según sea necesario
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Filtro de oscuridad
          Container(
            color: Colors.black54, // Color negro con opacidad
          ),
          // Contenido de la pantalla
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w), // Cambiado para un mejor espaciado
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'GLOBAL VIEW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Descripción
                  Text(
                    'Embrace a world of possibilities via Unity in Diversity through our global view',
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
                  SizedBox(height: 4.h),

                  // Botón para ir a la siguiente pantalla
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen3(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Color del botón
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFF4725F3), // Color del texto
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
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
