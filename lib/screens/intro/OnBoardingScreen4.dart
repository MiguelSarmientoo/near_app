// lib/screens/intro/OnBoardingScreen4.dart
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart'; 

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);

    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo (opcional)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/socialmediaview.png'), // Asegúrate que esta imagen exista
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Filtro de oscuridad
          Container(
            color: Colors.black54, // Añadido filtro oscuro para mejorar la visibilidad del contenido
          ),
          // Contenido principal
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Título
                  Text(
                    'JOIN US NOW!',
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
                    'Be part of the NE-AR community and start experiencing the benefits today!',
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

                  // Botón para ir a la pantalla de inicio de sesión
                  ElevatedButton(
                    onPressed: () {
                      _completeOnboarding(context); // Llama a la función para completar el Onboarding y navegar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Color de fondo del botón
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordes redondeados
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4725F3), // Color primario del texto
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
