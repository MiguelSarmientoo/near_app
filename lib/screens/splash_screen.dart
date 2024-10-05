import 'package:flutter/material.dart';
import 'dart:async';
import './routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  final bool showOnboarding;

  const SplashScreen({super.key, required this.showOnboarding});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _dotCount = 3; // Número de puntos en la animación
  List<double> _dotOpacity = []; // Lista para almacenar opacidad de los puntos
  Timer? _timer; // Temporizador para la animación
  bool _showLoading = false; // Controla si se debe mostrar el indicador de carga
  bool _showLogo = true; // Controla si se debe mostrar el logo

  @override
  void initState() {
    super.initState();
    _initializeDots();
    _startSplashScreen();
  }

  void _initializeDots() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    // Inicializar la opacidad de los puntos
    _dotOpacity = List.filled(_dotCount, 0.3); // Inicia con opacidad baja

    // Animar los puntos
    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (mounted) {
        setState(() {
          // Cambia la opacidad de los puntos
          for (int i = 0; i < _dotCount; i++) {
            _dotOpacity[i] = (i == (timer.tick % _dotCount)) ? 1.0 : 0.3; // Cambia solo el punto actual
          }
        });
      }
    });
  }

  void _startSplashScreen() async {
    // Muestra el logo durante 3 segundos
    await Future.delayed(const Duration(seconds: 3));

    // Cambia a mostrar "cargando"
    setState(() {
      _showLogo = false; // Desvanece el logo
      _showLoading = true; // Muestra el cargando
    });

    // Redirige basado en si ya vio el Onboarding
    await Future.delayed(const Duration(seconds: 2)); // Espera 2 segundos para mostrar "cargando"
    if (widget.showOnboarding) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.intro1);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Limpia el controlador de la animación
    _timer?.cancel(); // Cancela el temporizador si está activo
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Establece el fondo a negro
      body: Stack(
        children: [
          // Imagen del splash
          Center(
            child: AnimatedOpacity(
              opacity: _showLogo ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                'assets/images/logosplash.png', // Asegúrate de que esta ruta sea correcta
                width: 250, // Ajusta el tamaño según sea necesario
                height: 250,
              ),
            ),
          ),
          // Footer con la imagen "Powered by"
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Minimiza el tamaño para ajustarse al contenido
              children: [
                const SizedBox(height: 20), // Espacio entre la imagen y el footer
                if (_showLoading) // Muestra solo si se está cargando
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_dotCount, (index) {
                      return Opacity(
                        opacity: _dotOpacity[index],
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      );
                    }),
                  ),
                if (_showLoading) // Muestra la imagen de "Powered by" solo si se está cargando
                  Column(
                    children: [
                      const SizedBox(height: 20), // Espacio entre los puntos y la imagen
                      AnimatedOpacity(
                        opacity: _showLoading ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 600),
                        child: Image.asset(
                          'assets/images/splash2.png', // Ruta de la imagen "Powered by"
                          width: 100, // Ajusta el tamaño según sea necesario
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20), // Espacio inferior
              ],
            ),
          ),
        ],
      ),
    );
  }
}
