import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './OnboardingScreen2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/arview2.jpg'), // Cambia a la ruta de tu imagen
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
                children: [
                  // Título
                  Text(
                    'AR VIEW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Descripción
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Step into a new future with NE-AR magic & be the change with\nclimate AR in your hands.',
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
                  ),
                  SizedBox(height: 4.h),

                  // Botón de Siguiente
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen2(),
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
                        color: Color(0xFF4725F3), // Color primario para el texto
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
